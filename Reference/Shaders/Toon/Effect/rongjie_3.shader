 
Shader "Effect/rongjie_3" {
    Properties {
        [HDR]_color ("color", Color) = (0.5,0.5,0.5,1)
        _textrues ("textrues", 2D) = "white" {}
        _mask ("mask", 2D) = "white" {}
        _kd ("kd", Range(0, 1)) = 0.455833
        _ys ("ys", Color) = (0.5,0.5,0.5,1)
        _qd ("qd", Float ) = 2
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "CanUseSpriteAtlas"="True"
        }
        Pass {
         
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform float _kd;
            uniform sampler2D _textrues; uniform float4 _textrues_ST;
            uniform float4 _ys;
            uniform float _qd;
            uniform float4 _color;
            struct VertexInput {
                float4 vertex : POSITION;
                half2 texcoord0 : TEXCOORD0;
                half4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half4 vertexColor : COLOR;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            half4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                // float isFrontFace = ( facing >= 0 ? 1 : 0 );
                // float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                half4 _textrues_var = tex2D(_textrues,TRANSFORM_TEX(i.uv0, _textrues));
                half3 emissive = (_color.rgb*(i.vertexColor.rgb*_textrues_var.rgb));
                half4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                half node_831 = (1.0 - i.vertexColor.a * _color.a);
                half node_1292_if_leA = step((_mask_var.a+_kd),node_831);
                half node_1292_if_leB = step(node_831,(_mask_var.a+_kd));
                half node_3817 = 0.0;
                half node_4684 = 1.0;
                half node_1292 = lerp((node_1292_if_leA*node_3817)+(node_1292_if_leB*node_4684),node_4684,node_1292_if_leA*node_1292_if_leB);
                half node_2844_if_leA = step(_mask_var.a,node_831);
                half node_2844_if_leB = step(node_831,_mask_var.a);
                half node_4820 = (node_1292-lerp((node_2844_if_leA*node_3817)+(node_2844_if_leB*node_4684),node_4684,node_2844_if_leA*node_2844_if_leB));
                half3 finalColor = emissive + ((node_4820*_qd)*_ys.rgb);
                fixed4 finalRGBA = fixed4(finalColor,(_textrues_var.a*(node_1292+node_4820)));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        // Pass {
        //     Name "ShadowCaster"
        //     Tags {
        //         "LightMode"="ShadowCaster"
        //     }
        //     Offset 1, 1
        //     Cull Off
            
        //     CGPROGRAM
        //     #pragma vertex vert
        //     #pragma fragment frag
        //     #include "UnityCG.cginc"
        //     #include "Lighting.cginc"
        //     #pragma fragmentoption ARB_precision_hint_fastest
        //     #pragma multi_compile_shadowcaster
        //     #pragma multi_compile_fog
        //     //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
        //     #pragma target 3.0
        //     struct VertexInput {
        //         float4 vertex : POSITION;
        //     };
        //     struct VertexOutput {
        //         V2F_SHADOW_CASTER;
        //     };
        //     VertexOutput vert (VertexInput v) {
        //         VertexOutput o = (VertexOutput)0;
        //         o.pos = UnityObjectToClipPos( v.vertex );
        //         TRANSFER_SHADOW_CASTER(o)
        //         return o;
        //     }
        //     float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
        //         float isFrontFace = ( facing >= 0 ? 1 : 0 );
        //         float faceSign = ( facing >= 0 ? 1 : -1 );
        //         SHADOW_CASTER_FRAGMENT(i)
        //     }
        //     ENDCG
        // }
    }
 
}
