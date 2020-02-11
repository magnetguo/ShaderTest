// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Valkyrie/Toon/Char/Occlusion1" 
{
	Properties
	{

		_RimColor("Rim Color", Color) = (1.0,1.0,1.0,0.3)
		_RimPower("Rim Power", Range(0.2,3.0)) = 0.2
		_CutValue("Cut Value", Range(0.0,1.0)) = 0.5
		_Transparency("Transparency", range(0,1)) = 1

	}
	SubShader
	{
		//遮挡轮廓
		pass
		{
			Tags{ "RenderType" = "Opaque" "Queue" = "Transparent-20" }
			Blend SrcAlpha OneMinusSrcAlpha
			ZTest greater
			ZWrite off

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 

			#include "UnityCG.cginc"		

			uniform float4 _RimColor;
			uniform float _RimPower;
			uniform float _CutValue;
			uniform float _Transparency;

			struct v2f_full
			{
				half4 pos : POSITION;
				half3 norm : TEXCOORD0;
				half3 viewDir : TEXCOORD2;
			};

			v2f_full vert(appdata_full v)
			{
				v2f_full o;

				o.pos = UnityObjectToClipPos(v.vertex);

				half3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 worldNormal = mul((half3x3)unity_ObjectToWorld, v.normal.xyz);

				o.norm = worldNormal;
				o.viewDir = (_WorldSpaceCameraPos.xyz - worldPos);

				return o;
			}

			fixed4 frag(v2f_full i) : COLOR
			{
				half4 outColor = _RimColor;

				float3 N = normalize(i.norm);
				float3 V = normalize(i.viewDir);
				float rim = 1.0 - saturate(dot(N,V));

				if (rim < _CutValue)
					discard;
				return outColor * 0.2;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}