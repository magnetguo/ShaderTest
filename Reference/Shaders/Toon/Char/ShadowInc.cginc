// Shadow阴影渲染

// XYZ:光照阴影的方向,Y:模型高,XZ:投射的水平范围,Y与XZ正比关系,W:高度偏移
uniform float4 _LightInfoShadow;
// 地型高度
uniform float _TerrainHeight;

uniform float _Transparency;
uniform float4 _ShadowColor;

uniform sampler2D _DissolveTex;
uniform fixed _DissolveFactor;


struct appdata {
    float4 vertex : POSITION;
	float4 uv : TEXCOORD0;
};

struct v2f_shadow
{
	float4 pos : POSITION;
	half2 uv : TEXCOORD0;
};

v2f_shadow ShadowVert(appdata v)
{
	v2f_shadow o;
	UNITY_INITIALIZE_OUTPUT(v2f_shadow, o);
	float3 posWorld = mul(unity_ObjectToWorld, v.vertex).xyz;	
	_LightInfoShadow.yw += _TerrainHeight;

	float hightDiff = _LightInfoShadow.w - posWorld.y;
	float diffFactor = hightDiff / _LightInfoShadow.y;
	float2 posWXZOffset = _LightInfoShadow.xz * diffFactor;
	float2 posWXZ = posWXZOffset + posWorld.xz;

	float3 newPosW = float3(posWXZ.x, _LightInfoShadow.w, posWXZ.y);
	o.pos = UnityWorldToClipPos(newPosW);
	o.uv = v.uv;
	return o;
}

fixed4 ShadowFrag(v2f_shadow i) :COLOR
{
	fixed dissolveDegree = tex2D(_DissolveTex, i.uv).r;
	//如果_DissolveFactor 趋向0, 采样值稍变大一点,防止也为0,clip掉,否则趋向1,采样值变小，确保全部clip掉
	//dissolveDegree -= (_DissolveFactor - 0.5)*0.001; 
	clip(dissolveDegree -_DissolveFactor);

	return fixed4(_ShadowColor.rgb,_ShadowColor.a * _Transparency);
}