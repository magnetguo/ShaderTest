// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Valkyrie/Toon/Scene/Other-ToonWithRotLightMask"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_ColorParam("Main ColorParam", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}

		_MaskTex("Mask", 2D) = "black" {}
		_LightMaskTex("LightMask", 2D) = "black" {}
		_LightMaskParam("_LightMaskParam", Range(0.0,1.0)) = 0.7
		_LightMaskBackParam("_LightMaskBackParam", Range(0.0,1.0)) = 0.7
		_RampTex("Ramp", 2D) = "white"{}
		_RampColor("Ramp Color", Color) = (1,1,1,1)

		_HighLight("HighLight",range(0,1)) = 0.9		// 高光范围
		_HighLightColor("HighLight Color", Color) = (1,1,1,1)
		_HighLightStrength("HighLightStrength", range(0,1000)) = 5

		_BrightnessFactor("MinBrightness", range(0, 1)) = 0

		_LightInfo("LightInfo", Vector) = (0.9, -1, 0.5, 0.005)
		_LightColor("LightColor",color) = (1,1,1,1)
		
		_Outline("Outline Thickness", range(0,10)) = 0.4
		_RampFactor("RampFactor", range(0,3)) = 2.5
		_RampFactor1("RampFactor1", range(0.1,20)) = 3
		_Transparency("Transparency", range(0,1)) = 1

		_BrightnessRatio("Brightness Ratio", range(0,10)) = 0
		_BrightnessIncrease("Brightness Increase", range(0,10)) = 4

		_SpeedSin("SpeedSin", Range(-100,100)) = 0
		_SpeedCos("SpeedCos", Range(-100,100)) = 1
	}
		SubShader
		{
			Tags
			{
				"IgnoreProjector" = "true"
				"Queue" = "Transparent"
				"RenderType" = "Transparent"
			}
			//模型Base渲染 + 染色
			pass
			{

			Name "TOON"
				//平行光的的pass渲染
				Tags{ "LightMode" = "ForwardBase"}
				Lighting Off
				Blend SrcAlpha OneMinusSrcAlpha
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#pragma target 3.0 

				sampler2D _MainTex;
				sampler2D _MaskTex;
				sampler2D _LightMaskTex;

				sampler2D _RampTex;
				float4 _RampColor;

				uniform float4 _MainTex_ST;
				uniform float4 _Color;
				uniform float4 _ColorParam;

				float _HighLight;
				float4 _HighLightColor;
				float _HighLightStrength;

				float _BrightnessFactor;

				float _LightMaskParam;
				float _LightMaskBackParam;

				float4 _LightInfo;
				float4 _LightColor;

				float _SpeedSin;
				float _SpeedCos;

				float _RampFactor;
				float _RampFactor1;

				float _Transparency;

				float _BrightnessRatio;
				float _BrightnessIncrease;

				uniform fixed _FlashSwitch;
				uniform sampler2D _FlashTex;
				uniform fixed4 _FlashMixedColor;
				uniform fixed4 _FlashFactor;
				uniform fixed _FlashStrength;
				uniform fixed4 _FlashMixedColorAdd;
				uniform fixed _FlashStrengthAdd;
				uniform fixed _FlashSpeed;

				uniform fixed _ShadowSwitch;
				uniform sampler2D _ShadowTex;
				uniform fixed _DirX;
				uniform fixed _DirY;
				uniform fixed _IsRotate;
				uniform fixed _Speed;
				uniform fixed _ShadowAlphaRatio;

				struct v2f
				{
					float4 pos:SV_POSITION;
					float4 color:COLOR;
					float2 uv : TEXCOORD0;
					float4 lightDir:TEXCOORD1;
					float3 normal:TEXCOORD2;
					float3 viewDir:TEXCOORD3;

					float3 worldNormal : NORMAL;
					float3 worldLight : TEXCOORD4;
					float4 worldPos : TEXCOORD5;
					float4 posW:TEXCOORD6;
				};
				
				v2f vert(appdata_full v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.color = v.color;
					o.normal = v.normal;
					half3 View = WorldSpaceViewDir(v.vertex);
					o.viewDir = mul((half3x3)unity_WorldToObject, View);
					half4 normDir = float4(normalize(_LightInfo.xyz), 0);
					normDir.xyz *= -1;
					
					half3 dir = mul(unity_WorldToObject, normDir).xyz;
					TANGENT_SPACE_ROTATION;
					o.lightDir.w = dot(normalize(v.normal), normalize(dir));
					
					return o;
				}

				half4 frag(v2f i) : COLOR
				{
					float2 uv = i.uv - float2(0.5, 0.5);
					uv = float2(uv.x*_SpeedCos - uv.y*_SpeedSin, uv.y*_SpeedCos + uv.x*_SpeedSin);
					uv += float2(0.5, 0.5);
					half4 texCol = tex2D(_MainTex,i.uv);
					
					float4 lightMask = tex2D(_LightMaskTex,uv);
					fixed4 mask = tex2D(_MaskTex, i.uv);

					half diff_misc = max(0, i.lightDir.w);
					float a = lerp(lightMask.r, diff_misc, _LightMaskParam);
					diff_misc = lerp(lightMask.r * diff_misc, diff_misc, a);
					//6等分
					half v = 0.625 + mask.r * 0.25 - 0.5 * mask.b;
					//5等分
					//half v = 0.5 + mask.r * 0.2 - 0.4 * mask.b;
					half2 rampUV = half2(diff_misc, v);
					half4 ramp = tex2D(_RampTex, rampUV);

					if (ramp.r + ramp.g + ramp.b != 3)
						ramp.rgb = ramp.rgb*_RampColor;

					ramp -= (1.0 - ramp) * (1.0 - mask.g);

					texCol.rgb *= ramp.rgb;
					texCol.rgb *= (1 + _BrightnessIncrease * 0.02);

					texCol.rgb -= lerp(0, (1 - lightMask.rrr)*_LightMaskBackParam, max(0, -i.lightDir.w));
					texCol.rgb *= clamp(_LightColor.rgb * (1 - _BrightnessFactor) + _BrightnessFactor, 0, 1);
					texCol.rgb *= _Color;
					texCol.rgb *= _ColorParam;

					fixed4 specColor = half4(1, 1, 1, 1);
					rampUV = half2(diff_misc * _RampFactor, 0.08);
					ramp = tex2D(_RampTex, rampUV);
					if (ramp.r + ramp.g + ramp.b != 3)
						specColor *= 0;
					else
						specColor *= 0.6 * pow(diff_misc, floor(_RampFactor1)) *_HighLightStrength;

					texCol += lightMask.g * _HighLightColor * _HighLight * specColor;

					texCol *= i.color;
					texCol.a = _Transparency;
					return texCol;
				}
				ENDCG
			}


		}
			FallBack "Diffuse"
}