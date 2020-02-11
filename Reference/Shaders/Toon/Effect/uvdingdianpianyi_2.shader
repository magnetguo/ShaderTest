Shader "Shader Forge/uvdingdianpianyi_2" 
{
	Properties
	{
		_color("color", Color) = (0.5,0.5,0.5,1)
		_Matcap("Matcap", 2D) = "white" {}
		_OutlineWidth("OutlineWidth", Range(0, 1)) = 0
		_OutlineColor("OutlineColor", Color) = (0.5,0.5,0.5,1)
		_qd("qd", Float) = 0.02
		_fw("fw", Float) = 5
		[HDR]_uvcolor("uvcolor", Color) = (0.5,0.5,0.5,1)
		_pos("pos", Float) = 0
		_speed("speed", Float) = 0
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}
		Pass
		{
			Name "Outline"
			Cull Front
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#pragma target 3.0
			uniform float _OutlineWidth;
			uniform float4 _OutlineColor;
			uniform float _qd;
			uniform float _fw;
			uniform float _pos;
			uniform float _speed;
			struct VertexInput 
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord1 : TEXCOORD1;
			};
			struct VertexOutput 
			{
				float4 pos : SV_POSITION;
				float2 uv1 : TEXCOORD0;
				float3 normalDir : TEXCOORD1;
				UNITY_FOG_COORDS(2)
			};
			VertexOutput vert(VertexInput v) 
			{
				VertexOutput o = (VertexOutput)0;
				o.uv1 = v.texcoord1;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				float4 node_4398 = _Time;
				float node_7822 = abs((frac((o.uv1 + (node_4398.g*_speed)*float2(0.15,0)).r) - 0.5));
				float node_7213 = pow((node_7822*2.0),_fw);
				v.vertex.xyz += ((node_7213*_qd*v.normal) + (node_7822*_pos));
				o.pos = UnityObjectToClipPos(float4(v.vertex.xyz + v.normal*_OutlineWidth,1));
				return o;
			}
			float4 frag(VertexOutput i) : COLOR 
			{
				return _OutlineColor;
			}
			ENDCG
		}
		Pass 
		{
			Name "FORWARD"
			Tags 
			{
				"LightMode" = "ForwardBase"
			}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#pragma target 3.0
			uniform sampler2D _Matcap; 
			uniform float4 _Matcap_ST;
			uniform float4 _color;
			uniform float _qd;
			uniform float _fw;
			uniform float4 _uvcolor;
			uniform float _pos;
			uniform float _speed;
			struct VertexInput 
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				half2 texcoord1 : TEXCOORD1;
			};
			struct VertexOutput 
			{
				float4 pos : SV_POSITION;
				half2 uv1 : TEXCOORD0;
				float3 normalDir : TEXCOORD1;
			};
			VertexOutput vert(VertexInput v) 
			{
				VertexOutput o = (VertexOutput)0;
				o.uv1 = v.texcoord1;
				o.normalDir = UnityObjectToWorldNormal(v.normal);
				// float4 node_4398 = _Time;
				float node_7822 = abs((frac((o.uv1 + (_Time.g*_speed)*float2(0.15,0)).r) - 0.5));
				float node_7213 = pow((node_7822*2.0),_fw);
				v.vertex.xyz += ((node_7213*_qd*v.normal) + (node_7822*_pos));
				o.pos = UnityObjectToClipPos(v.vertex);
				return o;
			}
			half4 frag(VertexOutput i) : COLOR 
			{
				i.normalDir = normalize(i.normalDir);
				// float3 normalDirection = i.normalDir;
				// float4 node_4398 = _Time;
				float node_7822 = abs((frac((i.uv1 + (_Time.g * _speed)*float2(0.15,0)).r) - 0.5));
				float node_7213 = pow((node_7822*2.0),_fw);
				float3 emissive = (_uvcolor.rgb*node_7213*5.0);
				float2 node_9314 = (mul(UNITY_MATRIX_V, float4(i.normalDir,0)).xyz.rgb.rg*0.5 + 0.5);
				half4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9314, _Matcap));
				half3 finalColor = emissive + saturate((_color.rgb > 0.5 ? (1.0 - (1.0 - 2.0*(_color.rgb - 0.5))*(1.0 - _Matcap_var.rgb)) : (2.0*_color.rgb*_Matcap_var.rgb)));
				half4 finalRGBA = fixed4(finalColor,1);
				UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
				return finalRGBA;
			}
			ENDCG
		}
	}
 
}
