Shader "Valkyrie/Toon/Scene/Sf-AlphaTestWithShadow"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5

		_ShadowTex("Shadow (RGB) Trans (A)", 2D) = "white" {}
		_DirX("DirX", Range(0,250)) = 0.5
		_DirY("DirY", Range(0,250)) = 0.5
		[Toggle]_IsRotate("IsRotate", Range(0,1)) = 0
		_Speed("Speed", Range(-1,1)) = 0.1
		_ShadowAlphaRatio("ShadowAlphaRatio", Range(0.5,1.5)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque" }
		Tags {"Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout"}
		Cull Off
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "../Scene.cginc"
		#pragma surface surf Lambert alphatest:_Cutoff vertex:vert

		fixed4 _Color;
		sampler2D _MainTex;

		sampler2D _ShadowTex;
		fixed _DirX;
		fixed _DirY;
		fixed _IsRotate;
		fixed _Speed;
		fixed _ShadowAlphaRatio;
		struct Input
		{
			float2 uv_MainTex;
			float4 posW:TEXCOORD0;
		};

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.posW = VertCalaShadow(mul(unity_ObjectToWorld, v.vertex), _DirX, _DirY);
		}

		void surf(Input i, inout SurfaceOutput o)
		{
			fixed4 col = tex2D(_MainTex, i.uv_MainTex) * _Color;
			col = FragCalaShadow(col, i.posW, _Time.y, _Speed, _IsRotate, _ShadowAlphaRatio, _ShadowTex);
			o.Albedo = col.rgb;
			o.Alpha = col.a;
		}
		ENDCG
	}
	Fallback "VertexLit"
}
