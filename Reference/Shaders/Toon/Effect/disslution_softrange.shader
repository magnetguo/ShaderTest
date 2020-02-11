Shader "dissolution" {
    Properties {
        _rongjie_T ("rongjie_T(R)", 2D) = "white" {}
        _ruanying ("ruanying", Range(0.5, 1)) = 0.7
        _zifaguang_liangdu ("zifaguang_liangdu", Range(0, 50)) = 1
        _diffuse ("diffuse", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "DISSOLUTION"
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
                float2 uv0 : TEXCOORD0;
                float4 color : COLOR;
            };

            sampler2D _rongjie_T; 
            float4 _rongjie_T_ST;
            float _ruanying;
            float _zifaguang_liangdu;
            sampler2D _diffuse; 
            float4 _diffuse_ST;

            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.color = v.color;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 diffuseColor = tex2D(_diffuse,TRANSFORM_TEX(i.uv0, _diffuse));
                float rongjieAlpha = tex2D(_rongjie_T,TRANSFORM_TEX(i.uv0, _rongjie_T)).r;
                float3 finalColor = diffuseColor.rgb*i.color.rgb*_zifaguang_liangdu;
                float alpha = diffuseColor.a*smoothstep(1.0 - _ruanying, _ruanying, saturate(rongjieAlpha + i.color.a*2 -1.0));
                return float4(finalColor,alpha);
            }
            ENDCG
        }        
    }
}
