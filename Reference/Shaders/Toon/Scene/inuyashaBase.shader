Shader "Custom/inuyashaBase" {
	Properties{
		_Color("Main Color", Color) = (1,1,1,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5

		[Toggle]_ShadowSwitch("Shadow Switch", Range(0,1)) = 0
		_ShadowTex("Shadow (RGB) Trans (A)", 2D) = "white" {}
		_DirX("DirX", Range(0,250)) = 0.5
		_DirY("DirY", Range(0,250)) = 0.5
		[Toggle]_IsRotate("IsRotate", Range(0,1)) = 0
		_Speed("Speed", Range(-1,1)) = 0.1
		_ShadowAlphaRatio("ShadowAlphaRatio", Range(0.5,1.5)) = 1
		[Toggle]_IsFog("IsFog", Range(0,1)) = 0
	}

		SubShader{
			Tags {"Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout"}
			//LOD 200
			//Cull Off
		CGPROGRAM

		#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"
		#pragma surface surf Lambert alphatest:_Cutoff vertex:vert
		

		sampler2D _MainTex;
		fixed4 _Color;
		fixed4 _WeatherColor;
		fixed _ShadowSwitch;
		sampler2D _ShadowTex;
		fixed _DirX;
		fixed _DirY;
		fixed _IsRotate;
		fixed _Speed;
		fixed _ShadowAlphaRatio;
		fixed _IsFog;
		struct Input {
			float2 uv_MainTex;
			float2 posW;
		};

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float4 w = mul(unity_ObjectToWorld, v.vertex);
			o.posW.x = w.x / 6000 * _DirX;
			o.posW.y = w.z / 6000 * _DirY;
		}
		void surf(Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			if (_ShadowSwitch > 0.5)
			{
				float2 uv = float2(IN.posW.x, IN.posW.y);
				fixed s = _Time.y * _Speed;
				if (_IsRotate)
					uv = float2(uv.x*cos(s) - uv.y*sin(s), uv.y*cos(s) + uv.x*sin(s));
				else
					uv = float2(uv.x + s, uv.y + s);
				fixed4 shadow = tex2D(_ShadowTex, float2(uv.x - 0.5, uv.y - 0.5));
				if (_IsFog && (uv.x > 0.5 || uv.x < -0.5 || uv.y > 0.5 || uv.y < -0.5))
					shadow = tex2D(_ShadowTex, float2(0, 0));
				shadow.a *= _ShadowAlphaRatio;
				shadow *= (2 - _ShadowAlphaRatio);
				if (!_IsFog)
				{
					c.rgb *= (1 - shadow.a);
					shadow.rgb *= shadow.a;
					c.rgb += c.rgb * shadow.rgb / (1 - shadow.rgb);
				}
				else
				{
					c.rgb = c.rgb * (1 - shadow.a) + shadow.rgb * shadow.a;
				}
			}
			APPLY_WEATHER(c.rgb,_WeatherColor);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
		}

			Fallback "Legacy Shaders/Transparent/Cutout/VertexLit"
}
