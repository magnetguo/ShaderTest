Shader "Valkyrie/Toon/Scene/UnLit-AlphaTestWithShadow" 
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
		_Brightness("Brightness", Range(0,10)) = 1
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
		Tags {"Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout"}
		Lighting Off
		Cull Off
		Pass 
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "..\Scene.cginc"
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
				float4 posW:TEXCOORD1;
				float4 color : COLOR;
			};

			fixed4 _Color;
			fixed4 _WeatherColor;
			fixed _Brightness;
			sampler2D _MainTex;
			fixed4 _MainTex_ST;
			fixed _Cutoff;

			sampler2D _ShadowTex;
			fixed _DirX;
			fixed _DirY;
			fixed _IsRotate;
			fixed _Speed;
			fixed _ShadowAlphaRatio;

			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.color = v.color;
				o.posW = VertCalaShadow(mul(unity_ObjectToWorld, v.vertex), _DirX, _DirY);
				return o;
			}
			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				
				col = FragCalaShadow(col, i.posW, _Time.y, _Speed, _IsRotate, _ShadowAlphaRatio, _ShadowTex);
				i.color.a = 1;
				col *= i.color;
				col *= _Color * _Brightness;
				APPLY_WEATHER(col.rgb,_WeatherColor);
				clip(col.a - _Cutoff);
				return col;
			}
			ENDCG
		}
	}
	Fallback "VertexLit"
}
