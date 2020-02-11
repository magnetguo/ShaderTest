Shader "Valkyrie/Toon/Scene/Sf-Texture" 
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}		
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		CGPROGRAM
		#include  "../Scene.cginc"
		#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"
		#pragma surface surf Lambert vertex:vert
		struct Input 
		{
			float2 uv_MainTex;
			float4 world_pos : TEXCOORD1;
		};

		fixed4 _Color;
		sampler2D _MainTex;
		fixed4 _WeatherColor;

		#define ARR_MAX_NUM  4
		uniform sampler2D _ProjectorTex1;
		uniform sampler2D _ProjectorTex2;

		uniform float _ProjNum1;
		uniform float3 _ProjAngle1[ARR_MAX_NUM];
		uniform float3 _ProjOffset1[ARR_MAX_NUM];
		uniform float3 _ProjSize1[ARR_MAX_NUM];

		uniform float _ProjNum2;
		uniform float3 _ProjAngle2[ARR_MAX_NUM];
		uniform float3 _ProjOffset2[ARR_MAX_NUM];
		uniform float3 _ProjSize2[ARR_MAX_NUM];
		uniform float _ProjRange2[ARR_MAX_NUM];

		uniform float _ProjNum3;
		uniform float3 _ProjOffset3[ARR_MAX_NUM];
		uniform float3 _ProjSize3[ARR_MAX_NUM];
		uniform float3 _ProjMixedColor3[ARR_MAX_NUM];

		
		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.world_pos = mul(unity_ObjectToWorld, v.vertex);
		}

		void surf(Input IN, inout SurfaceOutput o) 
		{
			fixed4 col = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			col = projRect(_ProjectorTex1, IN.world_pos, col, _ProjNum1, _ProjAngle1, _ProjOffset1, _ProjSize1);
			col = projRad(_ProjectorTex2, IN.world_pos, col, _ProjNum2, _ProjAngle2, _ProjOffset2, _ProjSize2, _ProjRange2);

			/*half radius = 3;
			half decrease = 0.5;
			fixed3 mixedCol = fixed3(0.5, 0.5, 0.5) / 3;
			float dis = IN.world_pos.x * IN.world_pos.x + IN.world_pos.z * IN.world_pos.z;
			if (dis < radius)
				col.rgb += mixedCol * (pow(radius, decrease) - pow(dis, decrease));*/
			o.Albedo = col.rgb + projPointLight(IN.world_pos, _ProjNum3, _ProjOffset3, _ProjSize3, _ProjMixedColor3);
			APPLY_WEATHER(o.Albedo.rgb,_WeatherColor);
		}

		
		ENDCG
	}
	Fallback "Diffuse"
}