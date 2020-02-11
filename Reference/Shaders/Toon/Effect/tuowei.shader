Shader "Shader Forge/tuowei" {
    Properties {
        _mask ("mask(RGB)", 2D) = "white" {}
        _diffuse ("diffuse(R)", 2D) = "white" {}
        _u ("u", Float ) = 0.5
        _v ("v", Float ) = 2
        _raodong1 ("raodong1(R)", 2D) = "white" {}
        _raodong2 ("raodong2(G)", 2D) = "white" {}
        _r1_u ("r1_u", Float ) = 1
        _r1_v ("r1_v", Float ) = 1
        _r1_su ("r1_su", Float ) = -1
        _r1_sv ("r1_sv", Float ) = 1
        _r2_su ("r2_su", Float ) = 0.3
        _r2_sv ("r2_sv", Float ) = -2
        _raodongqiangdu ("raodongqiangdu", Float ) = 0.25
        _node_6796 ("uv power", Float ) = 0.3
        _node_8955 ("r2_u", Float ) = 1
        _node_5918 ("r2_v", Float ) = 1
        _zifaguang ("zifaguang", Range(0, 50)) = 1
        _alpha ("alpha", Range(0, 10)) = 1
    }
    SubShader {

        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "TUOWEI"
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

            sampler2D _mask; 
            float4 _mask_ST;
            sampler2D _diffuse; 
            float4 _diffuse_ST;
            float _u;
            float _v;
            sampler2D _raodong1; 
            float4 _raodong1_ST;
            sampler2D _raodong2; 
            float4 _raodong2_ST;
            float _r1_u;
            float _r1_v;
            float _r1_su;
            float _r1_sv;
            float _r2_su;
            float _r2_sv;
            float _raodongqiangdu;
            float _node_6796;
            float _node_8955;
            float _node_5918;
            float _zifaguang;
            float _alpha;

            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 Color : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 Color : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.Color = v.Color;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float4 maskColor = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                float2 uvOffset1 = i.uv0*float2(_r1_u,_r1_v)+float2(_r1_su*_Time.x,_Time.x*_r1_sv);
                float4 raodongColor1 = tex2D(_raodong1,TRANSFORM_TEX(uvOffset1, _raodong1));
                float2 uvOffset2 = ((i.uv0*float2(_node_8955,_node_5918))+float2((_r2_su*_Time.x),(_Time.x*_r2_sv)));
                float4 raodongColor2 = tex2D(_raodong2,TRANSFORM_TEX(uvOffset2, _raodong2));

                float2 diffuseUVOffset = i.uv0*float2(_u,_v)
                    +_raodongqiangdu*float2(raodongColor1.r,raodongColor2.g)*pow(i.uv0.r,_node_6796)+_Time.y*float2(-1.5,0);
                float4 diffuseColor = tex2D(_diffuse,TRANSFORM_TEX(diffuseUVOffset, _diffuse));
                float3 finalColor = maskColor.rgb*diffuseColor.r*i.Color.rgb*_zifaguang;
                return fixed4(finalColor,saturate((maskColor.r*_alpha*i.Color.a)));
            }
            ENDCG
        }        
    }
}
