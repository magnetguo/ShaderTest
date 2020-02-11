// Toon卡通渲染

uniform sampler2D _MainTex;
uniform float4 _Color;
uniform float4 _Emission;
uniform sampler2D _MaskTex;
uniform sampler2D _LightMaskTex;
uniform sampler2D _RampTex;
uniform float4 _RampColor;
uniform sampler2D _ShadowTex;
uniform float4 _ColorParam;
uniform float _HighLight;
uniform float4 _HighLightColor;
uniform float _BrightnessFactor;
uniform float _HighLightStrength;
uniform float _LightMaskParam;
uniform float _LightMaskBackParam;
uniform float4 _LightInfo;
uniform float4 _LightColor;
uniform float _BrightnessRatio;
uniform float _BrightnessIncrease;

// UV动画/流光 + 闪烁(Shining) 闪光(Flash)
sampler2D _UVAniNoiseTex;
float4 _UVAniNoiseTex_ST;
float4 _UVAniNoiseColor;
float _UVAniNoiseIntensity;
float _USpeed;
float _VSpeed;
float _FresnelPower;
float _ShiningSpeed;
float4 _CenterColor;
sampler2D _FlashTex;
float4 _FlashTex_ST;
float _FlashRange;
float _FlashIntensity;
float4 _FlashColor;

uniform fixed _DirX;
uniform fixed _DirY;
uniform fixed _Speed;
uniform fixed _ShadowAlphaRatio;
uniform fixed _Transparency;
uniform fixed _NewRamp;
uniform fixed _IsColoration;
uniform fixed4	_Coloration;
uniform sampler2D _DissolveTex;
uniform fixed _DissolveFactor;
uniform float _DissolveMin;
uniform float _DissolveMax;
uniform float _AddExposure;

//#define FLASH_SWITCH 1
//#define SHADOW_SWITCH 1

struct appdata {
    float4 vertex : POSITION;
    float3 normal : NORMAL;
	fixed4 color : COLOR;
    float4 uv : TEXCOORD0;
};

struct v2f_basic
{
	float4 pos:SV_POSITION;
	// b:outline
	fixed4 color:COLOR;
	half2 uv : TEXCOORD0;
	// x:light attenuate[Dot(norm,light)]
	// y:rim [Dot(norm,viewDir)]
	// z:distance [camera space Z]
	// w:normal height [camera space Y]
	half4 params : TEXCOORD1;
#ifdef SHADOW_SWITCH
	half4 posW:TEXCOORD2;
#endif
	half height:TEXCOORD3;
};

v2f_basic BasicVert(appdata v)
{
	v2f_basic o;
	UNITY_INITIALIZE_OUTPUT(v2f_basic, o);
	o.pos = UnityObjectToClipPos(v.vertex);
	o.uv = v.uv;
	o.color = v.color;
	half3 lightWorldDir = UnityWorldToObjectDir(-normalize(_LightInfo.xyz));
	float3 normal = normalize(v.normal);
	o.params.x = dot(normal, normalize(lightWorldDir));
	float3 viewDir = ObjSpaceViewDir(v.vertex);
	o.params.y = 1 - dot(normal, normalize(viewDir));
	o.params.z = abs(UnityObjectToViewPos(v.vertex).z);
	float3 normalDir = UnityObjectToWorldNormal(v.normal);
	o.params.w = mul(UNITY_MATRIX_V, float4(normalDir,0)).y;

#ifdef SHADOW_SWITCH
	half4 posW = mul(unity_ObjectToWorld, v.vertex);
	o.posW.x = posW.x / 6000 * _DirX;
	o.posW.y = posW.z / 6000 * _DirY;
#endif
	o.height = mul(unity_ObjectToWorld, v.vertex).y;
	return o;
}

float4 BasicFrag(v2f_basic i) : COLOR
{
	if (i.height > _DissolveMin + (_DissolveMax - _DissolveMin) * (1 - _DissolveFactor))
		return 0;
	////溶解
	//fixed dissolveDegree = tex2D(_DissolveTex, i.uv).r;
	////如果_DissolveFactor 趋向0, 采样值稍变大一点,防止也为0,clip掉,否则趋向1,采样值变小，确保全部clip掉
	////dissolveDegree -= (_DissolveFactor - 0.5)*0.001; 
	//clip(dissolveDegree -_DissolveFactor);

	half3 final;
	fixed4 texCol = tex2D(_MainTex, i.uv);
	final = texCol.rgb;
	
	fixed4 lightMask = tex2D(_LightMaskTex, i.uv);
	fixed4 mask = tex2D(_MaskTex, i.uv);
	//光照衰减强度
	fixed lightAtten = saturate(lerp(i.params.x, 1, 0.5 * _NewRamp));
	//光照衰减强度与光照遮罩图结合
	lightAtten = lerp(lightMask.r * lightAtten, lightAtten, _LightMaskParam);

	//6等分 通过 遮罩图(RB)把角色拆分为(0.125,0.375,0.625,0.875)四个层次
	fixed v = (0.625 + mask.r * 0.25 - 0.5 * mask.b);
	fixed2 rampUV = fixed2(lightAtten, v);
	// 采样Ramp贴图
	// U:光照强度，从左到右亮度渐渐增强，
	// V:四个层次，取每个层次的中间值，比如0.125为0-0.25的中间值
	fixed4 ramp = tex2D(_RampTex, rampUV);
	// 取出纯白色值
	fixed rampWhiteColor = step(3, ramp.r + ramp.g + ramp.b);
	ramp.rgb = lerp(ramp.rgb * _RampColor, ramp.rgb, rampWhiteColor);
	//闭塞边缘暗部高亮
	ramp -= (1.0 - ramp) * (1.0 - mask.g);
	fixed isRamp = step(i.params.y, 0.85 / sqrt(sqrt(sqrt(i.params.z))));
	isRamp = 1 - (step(isRamp, 0) * step(1, lightMask.g));

	
	final *= lerp(1, ramp.rgb, isRamp);
	final += (ramp.rgb - 0.75) * _BrightnessRatio;
	final *= (1 + _BrightnessIncrease * 0.02);
	final -= lerp(0, (1 - lightMask.rrr)*_LightMaskBackParam, max(0, -i.params.x));
	final *= lerp(_LightColor.rgb, 1, _BrightnessFactor);
	final *= _ColorParam * _Color;
	
	// 闪光效果，叠加UV动画 
#ifdef FLASH_SWITCH
	float2 uvOffset = i.uv + float2(_USpeed,_VSpeed) * _Time.x;
	float3 uvAniNosieTexColor = tex2D(_UVAniNoiseTex,TRANSFORM_TEX(uvOffset, _UVAniNoiseTex)).rgb * _UVAniNoiseColor.rgb *_UVAniNoiseIntensity;
	float fresnelTerm = pow(i.params.y,_FresnelPower);
	float3 finalUVAni = lerp(_CenterColor.rgb, uvAniNosieTexColor*abs(cos(_Time.x*_ShiningSpeed)),fresnelTerm); // 流光 _ShiningSpeed控制闪烁的变化
	
	float2 flashUV = i.uv + float2(0,5.2*_FlashRange- 1.5 + i.params.w*2.0 - 1.0);
	float3 flashTexColor = tex2D(_FlashTex,TRANSFORM_TEX(flashUV, _FlashTex)).rgb * _FlashColor.rgb * _FlashIntensity;
	float3 finalFlash = flashTexColor * sin(_FlashRange*3.142); //闪光 3.142 是 PI 闪光的强弱变化
	
	final += finalUVAni + finalFlash;
#endif

	//云影掠过效果
#ifdef SHADOW_SWITCH
	half2 uv = i.posW.xy;
	fixed cosT = cos(_Time.y * _Speed);
	fixed sinT = sin(_Time.y * _Speed);
	uv = half2(uv.x*cosT - uv.y*sinT, uv.y*cosT + uv.x*sinT);
	half4 shadow = tex2D(_ShadowTex, half2(frac(uv.x - 0.5), frac(uv.y - 0.5)));
	
	//有点晕了
	shadow.a *= _ShadowAlphaRatio;
	shadow *= (2 - _ShadowAlphaRatio);
	shadow.rgb *= shadow.a;
	final *= (1 - shadow.a);
	final += final * shadow.rgb / (1 - shadow.rgb);
	
#else
	// 高亮，把 _HighLight lightMask.b 易出现为0值放置前面
	half3 specColor = _HighLight * step(1, lightMask.b) *
		lightAtten * lightAtten * lightAtten *
		_HighLightStrength * _HighLightColor.rgb * 0.6;
	final += specColor;
#endif

	// 染色
	fixed m = step(_Coloration.r, 0.5);
	half3  coloration = lerp(2.0*_Coloration.rgb*final,
		(1.0 - (1.0 - 2.0*(_Coloration.rgb - 0.5))*(1.0 - final)), m);
	final = lerp(final, coloration, _IsColoration);
	final *= i.color.rgb;
	half alpha = texCol.a * i.color.a * _Transparency;
	if (mask.g < 0.001)
	{
		half4 emiFinal = _Emission * half4(final.rgb, 1);
		return lerp(emiFinal,half4(1,1,1,1),_AddExposure);
	}
	final = lerp(final,half3(1,1,1),_AddExposure);
	return half4(final, alpha);
}