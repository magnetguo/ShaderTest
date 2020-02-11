Shader "Valkyrie/Toon/Scene/Sf-AlphaTestWithShine"
{

	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5

		_AddTex("Shine (RGB) Trans (A)", 2D) = "white" {}
		_AddAlphaRatio("Shine Alpha Ratio", Range(0,1)) = 0
		_AddFlashSpeed("Shine Flash Speed", Range(0,5)) = 0
	}
	SubShader
	{
		Tags{ "Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" }
		Lighting Off
		Cull Off
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "../Scene.cginc"
		#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"
		#pragma surface surf Lambert alphatest:_Cutoff

		struct appdata_t
		{
			float4 vertex : POSITION;
			float2 texcoord : TEXCOORD0;
			float4 color : COLOR;
		};

		struct v2f
		{
			float4 vertex : SV_POSITION;
			half2 texcoord : TEXCOORD0;
			float4 color : COLOR;
		};

		struct Input
		{
			float2 uv_MainTex;
		};
		
		float4 _Color;
		fixed4 _WeatherColor;
		sampler2D _MainTex;

		fixed _AddAlphaRatio;
		fixed _AddFlashSpeed;
		sampler2D _AddTex;

		void surf(Input i, inout SurfaceOutput o)
		{
			fixed4 col = SurfCalaShine(_MainTex, _AddTex, _AddAlphaRatio, _AddFlashSpeed, i.uv_MainTex, _Time.y);
			o.Albedo = col.rgb * _Color;
			APPLY_WEATHER(o.Albedo.rgb,_WeatherColor);
			o.Alpha = col.a;
		}
		ENDCG
	}

}
