// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Circle" 
{
	Properties 
	{
		_Color ("Color", Color) = (1,1,1,1)
	}
 
	SubShader 
	{
		Tags{ "Queue" = "Transparent"  }
		Pass 
		{
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
 
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
 
			struct v2f 
			{
				float4 pos : SV_POSITION;
				float4 oPos : TEXCOORD1;
			};
			fixed4 _Color;
			int _Width;

			float4 _MainTex_ST;
			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.oPos = v.vertex;
				return o;
			}
 
			fixed4 frag(v2f i) : COLOR
			{
				float dis = sqrt(i.oPos.x * i.oPos.x + i.oPos.y * i.oPos.y);
				_Color.a = (1 - dis * 2.5) * step(dis, 0.5)* 0.6;
				return _Color;
			}
			ENDCG
			}
		}
		FallBack "Diffuse"
}
