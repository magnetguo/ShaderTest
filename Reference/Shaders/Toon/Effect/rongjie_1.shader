 
Shader "Effect/rongjie_1" {
    Properties {
        _color ("color", Color) = (0.5,0.5,0.5,1)
        _textrues ("textrues", 2D) = "white" {}
        _mask ("mask", 2D) = "white" {}
        _kd ("kd", Range(0, 1)) = 0.3279424
        _ys ("ys", Color) = (0,0.5034485,1,1)
        _qd ("qd", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "CanUseSpriteAtlas"="True"
            "PreviewType"="Plane"
        }
        Pass {
            // Name "FORWARD"
            // Tags {
            //     "LightMode"="ForwardBase"
            // }
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #pragma multi_compile _ PIXELSNAP_ON
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _textrues; uniform float4 _textrues_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform float _kd;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                #ifdef PIXELSNAP_ON
                    o.pos = UnityPixelSnap(o.pos);
                #endif
                return o;
            }
            half4 frag(VertexOutput i, half facing : VFACE) : COLOR {
                // half isFrontFace = ( facing >= 0 ? 1 : 0 );
                // half faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                half4 _textrues_var = tex2D(_textrues,TRANSFORM_TEX(i.uv0, _textrues));
                half4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                half node_3229 = (_mask_var.r*0.9);
                half node_850 = (1.0 - i.vertexColor.a);
                half node_5674_if_leA = step((node_3229+_kd),node_850);
                half node_5674_if_leB = step(node_850,(node_3229+_kd));
                half node_9082 = 0.0;
                half node_1423 = 1.0;
                half node_5674 = lerp((node_5674_if_leA*node_9082)+(node_5674_if_leB*node_1423),node_1423,node_5674_if_leA*node_5674_if_leB);
                half node_7126_if_leA = step(node_3229,node_850);
                half node_7126_if_leB = step(node_850,node_3229);
                half node_269 = (node_5674-lerp((node_7126_if_leA*node_9082)+(node_7126_if_leB*node_1423),node_1423,node_7126_if_leA*node_7126_if_leB));
                half node_9458 = (node_5674+node_269);
                half3 emissive = (_color.rgb*((_textrues_var.rgb*i.vertexColor.rgb)*node_9458));
                half3 finalColor = emissive + (_textrues_var.b*((node_269*_ys.rgb)*_qd));
                return fixed4(finalColor,(_textrues_var.b*node_9458));
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
        //     #define UNITY_PASS_SHADOWCASTER
        //     #pragma multi_compile _ PIXELSNAP_ON
        //     #include "UnityCG.cginc"
        //     #include "Lighting.cginc"
        //     #pragma fragmentoption ARB_precision_hint_fastest
        //     #pragma multi_compile_shadowcaster
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
        //         #ifdef PIXELSNAP_ON
        //             o.pos = UnityPixelSnap(o.pos);
        //         #endif
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
