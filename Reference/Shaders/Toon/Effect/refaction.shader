Shader "Effect/refaction" {
    Properties {
        _node_6904 ("node_6904(RG)", 2D) = "white" {} //noise
    }
    SubShader {

        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent+200"
            "RenderType"="Transparent"
        }

        GrabPass{ }

        Pass {
            Name "REFACTION"

            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
	    Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0


            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 color : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 color : COLOR;
                float2 uv0 : TEXCOORD0;
                float4 projPos : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.color = v.color;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }

            sampler2D _GrabTexture;
            sampler2D _node_6904; 
            float4 _node_6904_ST;

            float4 frag(VertexOutput i) : COLOR {
                float4 noiseColor = tex2D(_node_6904,TRANSFORM_TEX(i.uv0, _node_6904));
                float2 sceneUVs = i.projPos.xy / i.projPos.w + noiseColor.rg * i.color.a * 0.2;
                float4 finalColor = tex2D(_GrabTexture, sceneUVs);
                return fixed4(finalColor.rgb,1);
            }
            ENDCG
        }
    }
}
