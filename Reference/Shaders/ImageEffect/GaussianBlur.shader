// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Colorful FX - Unity Asset
// Copyright (c) 2015 - Thomas Hourdel
// http://www.thomashourdel.com

Shader "Hidden/Colorful/Gaussian Blur"
{
	Properties
	{
		_MainTex("Base (RGB)", 2D) = "white" {}
		_Direction("Direction (XY)", Vector) = (0, 0, 0, 0)
		_Amount("Blend factor (Float)", Float) = 1.0
	}

		SubShader
		{
			ZTest Always Cull Off ZWrite Off
			Fog { Mode off }

			// (0) Blur
			Pass
			{
				CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					#pragma fragmentoption ARB_precision_hint_fastest 
					#include "UnityCG.cginc"

					sampler2D _MainTex;
					half2 _Direction;

					struct fInput
					{
						float4 pos : SV_POSITION;
						half2 uv : TEXCOORD0;
						half4 uv1 : TEXCOORD1;
						half4 uv2 : TEXCOORD2;
					};

					fInput vert(appdata_img v)
					{
						fInput o;
						o.pos = UnityObjectToClipPos(v.vertex);
						o.uv = v.texcoord.xy;
						half2 d1 = 1.385h * _Direction;
						half2 d2 = 3.230h * _Direction;
						o.uv1.xy = d1;
						o.uv1.zw = -d1;
						o.uv2.xy = d2;
						o.uv2.zw = -d2;
						return o;
					}

					fixed4 frag(fInput i) : SV_Target
					{
						fixed4 oc = tex2D(_MainTex, i.uv);
						fixed3 c = oc.rgb * 0.227h;
						c += tex2D(_MainTex, i.uv + half2(i.uv1.x, 0)).rgb * 0.158h;
						c += tex2D(_MainTex, i.uv + half2(0, i.uv1.y)).rgb * 0.158h;
						c += tex2D(_MainTex, i.uv + half2(i.uv1.z, 0)).rgb * 0.158h;
						c += tex2D(_MainTex, i.uv + half2(0, i.uv1.w)).rgb * 0.158h;
						c += tex2D(_MainTex, i.uv + half2(i.uv2.x, 0)).rgb * 0.035h;
						c += tex2D(_MainTex, i.uv + half2(0, i.uv2.y)).rgb * 0.035h;
						c += tex2D(_MainTex, i.uv + half2(i.uv2.z, 0)).rgb * 0.035h;
						c += tex2D(_MainTex, i.uv + half2(0, i.uv2.w)).rgb * 0.035h;
						return fixed4(c, oc.a);
					}

				ENDCG
			}

			// (1) Composite if _Amount is in ]0;1[
			Pass
			{
				CGPROGRAM
					#pragma vertex vert_img
					#pragma fragment frag
					#pragma fragmentoption ARB_precision_hint_fastest 
					#include "UnityCG.cginc"

					sampler2D _MainTex;
					sampler2D _Blurred;
					half _Amount;

					half4 frag(v2f_img i) : SV_Target
					{
						half4 oc = tex2D(_MainTex, i.uv);
						half4 bc = tex2D(_Blurred, i.uv);
						return lerp(oc, bc, _Amount);
					}

				ENDCG
			}
		}

			FallBack off
}
