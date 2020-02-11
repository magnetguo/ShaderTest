Shader "Valkyrie/Toon/Scene/Sf-AlphaTest"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
	}

	SubShader
	{
		Tags {"Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout"}

		CGPROGRAM
		#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"
		#pragma surface surf Lambert alphatest:_Cutoff

		fixed4 _Color;
		fixed4 _WeatherColor;
		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			APPLY_WEATHER(c.rgb,_WeatherColor);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	Fallback "VertexLit"
}
