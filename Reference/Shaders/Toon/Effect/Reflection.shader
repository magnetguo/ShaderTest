
Shader "Valkyrie/Toon/Effect/Reflection"
{
	Properties
	{
		_Color("Color", Color) = (0.5,0.5,0.5,1)
		_RefStrength("RefStrength", Float) = 0.25
		_BlurSize("BlurSize", Float) = 20
	}
	SubShader
	{
		 Tags
		{
			"IgnoreProjector" = "True"
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
		}
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			
			struct appdata
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
			struct v2f
			{
				float4 screenPos : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD1;
				float4 uv1 : TEXCOORD2;
				float4 uv2 : TEXCOORD3;
			};
			sampler2D _ReflectionTex;
			float _RefStrength;
			float4 _Color;

			float _BlurSize;
			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.screenPos = ComputeScreenPos(o.vertex);
				o.uv = v.texcoord.xy;
				half2 d1 = 1.385h * _BlurSize / 10000;
				half2 d2 = 3.230h * _BlurSize / 10000;
				o.uv1.xy = d1;
				o.uv1.zw = -d1;
				o.uv2.xy = d2;
				o.uv2.zw = -d2;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float2 uv = i.screenPos.xy / i.screenPos.w;
				fixed4 col = tex2D(_ReflectionTex, uv);
				col *= 0.227;
				col.rgb += tex2D(_ReflectionTex, uv + half2(i.uv1.x, 0)).rgb * 0.158h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(0, i.uv1.y)).rgb * 0.158h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(i.uv1.z, 0)).rgb * 0.158h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(0, i.uv1.w)).rgb * 0.158h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(i.uv2.x, 0)).rgb * 0.035h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(0, i.uv2.y)).rgb * 0.035h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(i.uv2.z, 0)).rgb * 0.035h;
				col.rgb += tex2D(_ReflectionTex, uv + half2(0, i.uv2.w)).rgb * 0.035h;
				col.a = _RefStrength;
				col.rgb *= _Color.rgb;
				return col;
			}

			
			ENDCG
		}
	
	}

}
