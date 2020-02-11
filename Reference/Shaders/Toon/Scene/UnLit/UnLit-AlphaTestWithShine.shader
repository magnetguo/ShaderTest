Shader "Valkyrie/Toon/Scene/UnLit-AlphaTestWithShine"
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
		[Toggle]_IsUseLM("Is Use Lightmap", Range(0,1)) = 0
		_LMTex("Lightmap Tex", 2D) = "white" {}
	}
	SubShader
	{
		Tags{ "Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" }
		Lighting Off
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "../Scene.cginc"
			#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"

			struct appdata_t
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoord2 : TEXCOORD1;
				float4 color : COLOR;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				float4 color : COLOR;
				float2 uv_lightmap : TEXCOORD1;
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

			sampler2D _LMTex;
			float4 _LMTex_ST;
			fixed _IsUseLM;

			v2f vert(appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.color = v.color;
				o.uv_lightmap = v.texcoord2.xy *_LMTex_ST.xy + _LMTex_ST.zw;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = SurfCalaShine(_MainTex, _AddTex, _AddAlphaRatio, _AddFlashSpeed, i.texcoord, _Time.y);
				col *= i.color;
				fixed3 lm = DecodeLightmap(tex2D(_LMTex, i.uv_lightmap))* col.rgb;
				col.rgb = (1 - _IsUseLM) * col.rgb + _IsUseLM * lm;
				col *= _Color;
				APPLY_WEATHER(col.rgb,_WeatherColor);
				return col * _Color;
			}
		ENDCG
		}
	}

}
