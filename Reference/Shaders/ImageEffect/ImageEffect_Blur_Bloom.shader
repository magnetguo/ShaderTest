////////////////////////////////////////////
// from CameraFilterPack - by VETASOFT 2016 /////
////////////////////////////////////////////

Shader "Valkyrie/ImageEffect/Unlit/Blur_Bloom" {
Properties 
{
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_Params("Params",Vector) = (5.,5.,0.,0.)
}
SubShader 
{
	Pass
	{
		ZTest Always
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest
		#pragma target 3.0
		#pragma glsl
		#include "UnityCG.cginc"


		uniform sampler2D _MainTex;
		uniform float4 _Params;
		uniform float4 _ColorMix;

		struct appdata_t
		{
			float4 vertex   : POSITION;
			float2 texcoord : TEXCOORD0;
		};

		struct v2f
		{
			float2 texcoord  : TEXCOORD0;
			float4 vertex   : SV_POSITION;
		};   

		v2f vert(appdata_t IN)
		{
			v2f OUT;
			OUT.vertex = UnityObjectToClipPos(IN.vertex);
			OUT.texcoord = IN.texcoord;

			return OUT;
		}

		float4 frag (v2f i) : COLOR
		{
			float2 stepUV = (1.0 / _Params.zw) * _Params.x;
			float3 color = tex2D(_MainTex,i.texcoord );

			float3x3 gaussian = float3x3(
			1.0,	2.0,	1.0,
			2.0,	4.0,	2.0,
			1.0,	2.0,	1.0);

			float4 result = 0;

			for(int u=0;u<3;u++) 
			{
				for(int j=0;j<3;j++) 
				{
					float2 texCoord = i.texcoord + float2( float(u-1)*stepUV.x, float(j-1)*stepUV.y );
					result += gaussian[u][j] * tex2D(_MainTex,texCoord);
				}
			}

			result /=8;

			result.rgb = lerp(color.rgb, result.rgb, _Params.y * 0.25) + _ColorMix * _ColorMix.a * 0.1;


			return result;	
		}

		ENDCG
	}

}
}