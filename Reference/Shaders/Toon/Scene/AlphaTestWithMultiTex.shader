Shader "Custom/AlphaTestWithMultiTex" 
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
			Tags {"Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout"}
			Lighting Off
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha
			Pass 
			{
				CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					#pragma multi_compile_fog

					#include "UnityCG.cginc"
					#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"

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
						UNITY_FOG_COORDS(1)
						float4 color : COLOR;
					};
					float4 _Color;
					fixed4 _WeatherColor;
					sampler2D _MainTex;
					float4 _MainTex_ST;
					fixed _Cutoff;

					fixed _AddAlphaRatio;
					fixed _AddFlashSpeed;
					fixed _AddSwitch;
					sampler2D _AddTex;
					v2f vert(appdata_t v)
					{
						v2f o;
						o.vertex = UnityObjectToClipPos(v.vertex);
						o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
						o.color = v.color;
						UNITY_TRANSFER_FOG(o,o.vertex);
						return o;
					}

					fixed4 frag(v2f i) : SV_Target
					{
						fixed4 col = tex2D(_MainTex, i.texcoord);
						clip(col.a - _Cutoff);
						fixed4 add = tex2D(_AddTex, i.texcoord);
						add *= _AddAlphaRatio * abs(sin(_Time.y * _AddFlashSpeed))   * add.a;
						col.rgb += col.rgb * add.rgb / (1 - add.rgb);
						UNITY_APPLY_FOG(i.fogCoord, col);
						col *= i.color*_Color;
						APPLY_WEATHER(col.rgb,_WeatherColor);
						return col;
					}
				ENDCG
			}
	}

}
