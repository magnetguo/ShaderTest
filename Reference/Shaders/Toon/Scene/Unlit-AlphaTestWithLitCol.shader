// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Unlit alpha-cutout shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Custom/AlphaTestWithLitCol" {
Properties {
	_Color("Main Color", Color) = (1,1,1,1)
	_Brightness("Brightness", Range(0,10)) = 1
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5

	[Toggle]_ShadowSwitch ("Shadow Switch", Range(0,1)) = 0
	_ShadowTex ("Shadow (RGB) Trans (A)", 2D) = "white" {}
	_DirX ("DirX", Range(0,250)) = 0.5
	_DirY ("DirY", Range(0,250)) = 0.5
	[Toggle]_IsRotate ("IsRotate", Range(0,1)) = 0
	_Speed ("Speed", Range(-1,1)) = 0.1
	_ShadowAlphaRatio ("ShadowAlphaRatio", Range(0.5,1.5)) = 1
	[Toggle]_IsFog("IsFog", Range(0,1)) = 0
}
SubShader {
	//Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 100
	//ZWrite Off
	Lighting Off
	Cull Off
	//Blend SrcAlpha OneMinusSrcAlpha
	Pass {  
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata_t {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				float4 color : COLOR;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				half2 texcoord : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 posW:TEXCOORD2;
				float4 color : COLOR;
			};
			float4 _Color;
			float _Brightness;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed _Cutoff;

			fixed _ShadowSwitch;
			sampler2D _ShadowTex;
			fixed _DirX;
			fixed _DirY;
			fixed _IsRotate;
			fixed _Speed;
			fixed _ShadowAlphaRatio;
			fixed _IsFog;
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.color = v.color;
				o.posW = mul(unity_ObjectToWorld,v.vertex);
				o.posW.x = o.posW.x / 6000 * _DirX;
				o.posW.z = o.posW.z / 6000 * _DirY;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.texcoord);
				clip(col.a - _Cutoff);
				if (_ShadowSwitch > 0.5)
				{
					float2 uv = float2(i.posW.x, i.posW.z);
					fixed s = _Time.y * _Speed;
					if (_IsRotate)
						uv = float2(uv.x*cos(s) - uv.y*sin(s), uv.y*cos(s) + uv.x*sin(s));
					else
						uv = float2(uv.x + s, uv.y + s);
					fixed4 shadow = tex2D(_ShadowTex, float2(uv.x % 1 - 0.5, uv.y % 1 - 0.5));
					if (_IsFog && (uv.x > 0.5 || uv.x < -0.5 || uv.y > 0.5 || uv.y < -0.5))
						shadow = tex2D(_ShadowTex, float2(0, 0));
					shadow.a *= _ShadowAlphaRatio;
					//shadow *= (2 - _ShadowAlphaRatio);
					if (!_IsFog)
					{
						col.rgb *= (1 - shadow.a);
						shadow.rgb *= shadow.a;
						col.rgb += col.rgb * shadow.rgb / (1 - shadow.rgb);
					}
					else
					{
						//shadow *= 1.25;
						col.rgb = col.rgb * (1 - shadow.a) + shadow.rgb * shadow.a;
					}
				}
				UNITY_APPLY_FOG(i.fogCoord, col);
				i.color.a = 1;
				col *= i.color;
				col *= _Color * _Brightness;
				return col;
			}
		ENDCG
	}
}

}
