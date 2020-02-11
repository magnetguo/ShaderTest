// Ť��Ч����ͨ��ץ��+�Ŷ���ʽ��ÿ�ζ�������ץ���������ڲ�ͬλ�õ�Ť��Ч����
// �����Ҫ��ͬһ��ץ��������ã���ʹ������Shader
Shader "Effect/niuqu_1"
{
	Properties
	{
		_Textrues("Textrues", 2D) = "white" {}
		_qd("qd", Color) = (0.5,0.5,0.5,1)
	}
		SubShader
		{
			Tags
			{
				"IgnoreProjector" = "True"
				"Queue" = "Transparent+200"
				"RenderType" = "Transparent"
			}
			GrabPass{} // û������������ÿ����Ⱦ��������ץ��һ�Σ���ʡʹ��
			Pass
			{
				Blend SrcAlpha OneMinusSrcAlpha
				ZWrite Off

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"
				#pragma target 3.0
				uniform sampler2D _GrabTexture;
				uniform sampler2D _Textrues;
				uniform float4 _Textrues_ST;
				uniform float4 _GrabTexture_ST;
				uniform float4 _qd;

				struct VertexInput
				{
					float4 vertex : POSITION;
					half2 texcoord0 : TEXCOORD0;
					half4 vertexColor : COLOR;
				};
				struct VertexOutput
				{
					float4 pos : SV_POSITION;
					half2 uv0 : TEXCOORD0;
					half4 vertexColor : COLOR;
					float4 projPos : TEXCOORD1;
				};
				VertexOutput vert(VertexInput v)
				{
					VertexOutput o = (VertexOutput)0;
					o.uv0 = TRANSFORM_TEX(v.texcoord0, _GrabTexture);
					o.vertexColor = v.vertexColor;
					o.pos = UnityObjectToClipPos(v.vertex);
					o.projPos = ComputeGrabScreenPos(o.pos);
					return o;
				}
				half4 frag(VertexOutput i) : COLOR
				{
					half4 col = tex2D(_Textrues,i.uv0);
					float2 sceneUVs = i.projPos.xy / i.projPos.w + _qd.a * col.rg * 0.2 * i.vertexColor.a;
					col = tex2D(_GrabTexture, sceneUVs);
					col.a = 1;
					return col;
				}
				ENDCG
			}
		}
}
