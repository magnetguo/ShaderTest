// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Valkyrie/Toon/Char/SuitLine" 
{
	Properties
	{
		_MainLineTex("LineTexture", 2D) = "white" {}
	}
	SubShader
	{
		//染色描线
		pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			Name "BaseLine"
			Tags{ "LightMode" = "ForwardBase" }

			Cull Back

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _MainLineTex;
			uniform float4 _MainLineTex_ST;

			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 color:COLOR;
				float2 uv : TEXCOORD0;
				//float4 lightDir:TEXCOORD1;
			};

			v2f vert(appdata_full v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainLineTex);
				o.color = v.color;
				return o;
			}

			half4 frag(v2f i) : COLOR
			{
				half4 texCol = tex2D(_MainLineTex,i.uv);
				return texCol;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}