Shader "Valkyrie/Toon/Scene/Sf-TextureWithShadow" 
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}

		_ShadowTex("Shadow (RGB) Trans (A)", 2D) = "white" {}
		_DirX("DirX", Range(0,250)) = 0.5
		_DirY("DirY", Range(0,250)) = 0.5
		[Toggle]_IsRotate("IsRotate", Range(0,1)) = 0
		_Speed("Speed", Range(-1,1)) = 0.1
		_ShadowAlphaRatio("ShadowAlphaRatio", Range(0.5,1.5)) = 1
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		//Pass
		//{
			CGPROGRAM
			#include "UnityCG.cginc"
			#include  "../Scene.cginc"
			#pragma surface surf Lambert vertex:vert

			struct Input
			{
				float2 uv_MainTex;
				float4 posW:TEXCOORD0;
			};

			fixed4 _Color;
			sampler2D _MainTex;

			sampler2D _ShadowTex;
			fixed _DirX;
			fixed _DirY;
			fixed _IsRotate;
			fixed _Speed;
			fixed _ShadowAlphaRatio;

			void vert(inout appdata_full v, out Input o)
			{
				UNITY_INITIALIZE_OUTPUT(Input, o);
				o.posW = VertCalaShadow(mul(unity_ObjectToWorld, v.vertex), _DirX, _DirY);
			}

			void surf(Input IN, inout SurfaceOutput o)
			{
				fixed4 col = tex2D(_MainTex, IN.uv_MainTex);
				col.rgb *= _Color.rgb;
				o.Albedo = FragCalaShadow(col, IN.posW, _Time.y, _Speed, _IsRotate, _ShadowAlphaRatio, _ShadowTex);
			}
			ENDCG
		//}
	}
	Fallback "Diffuse"
}