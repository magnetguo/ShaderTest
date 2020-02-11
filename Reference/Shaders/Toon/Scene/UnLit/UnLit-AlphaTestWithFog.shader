Shader "Valkyrie/Toon/Scene/UnLit-AlphaTestWithFog"
{
	Properties
	{
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_FogRadius("Fog Radius", Range(0,10)) = 1
		_MainTexStrength("MainTex Strength", Range(0,10)) = 1
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
	}

	SubShader
	{
		Tags {"Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent"}
		LOD 100

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass 
		{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 3.0

				#include "UnityCG.cginc"
				#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"

				struct appdata_t 
				{
					float4 vertex : POSITION;
					float2 texcoord : TEXCOORD0;
					UNITY_VERTEX_INPUT_INSTANCE_ID
				};

				struct v2f {
					float4 vertex : SV_POSITION;
					float2 texcoord : TEXCOORD0;
					float4 worldPos : TEXCOORD1;
					UNITY_VERTEX_OUTPUT_STEREO
				};

				sampler2D _MainTex;
				float4 _MainTex_ST;
				float _FogRadius;
				float _MainTexStrength;
				fixed4 _WeatherColor;
				v2f vert(appdata_t v)
				{
					v2f o;
					UNITY_SETUP_INSTANCE_ID(v);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
					o.worldPos = mul(unity_ObjectToWorld, v.vertex);
					return o;
				}

				fixed4 frag(v2f i) : SV_Target
				{
					fixed4 col = tex2D(_MainTex, i.texcoord);
					col.rgb *= _MainTexStrength;
					float3 offset = i.worldPos.xyz - _WorldSpaceCameraPos;
					float a = length(offset) / _FogRadius / 10;
					col.a *= saturate(a * a);
					APPLY_WEATHER(col.rgb,_WeatherColor);
					return col;
				}
			ENDCG
		}
	}
}


