// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
// /*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.4627451,fgcg:0.2745098,fgcb:0.4624949,fgca:1,fgde:0.01,fgrn:-6.54,fgrf:81.06,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33528,y:32248,varname:node_9361,prsc:2|emission-286-OUT;n:type:ShaderForge.SFN_Fresnel,id:8941,x:32938,y:32258,varname:node_8941,prsc:2|EXP-38-OUT;n:type:ShaderForge.SFN_ValueProperty,id:38,x:32710,y:32258,ptovrint:False,ptlb:ld,ptin:_ld,varname:node_38,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Multiply,id:286,x:33331,y:32358,varname:node_286,prsc:2|A-4324-OUT,B-9441-RGB;n:type:ShaderForge.SFN_Power,id:4324,x:33152,y:32307,varname:node_4324,prsc:2|VAL-8941-OUT,EXP-7517-OUT;n:type:ShaderForge.SFN_ValueProperty,id:7517,x:32919,y:32436,ptovrint:False,ptlb:dx,ptin:_dx,varname:node_7517,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Color,id:9441,x:33126,y:32467,ptovrint:False,ptlb:color,ptin:_color,varname:node_9441,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;proporder:38-7517-9441;pass:END;sub:END;*/

Shader "Shader Forge/ICE" {
    Properties {
        _ld ("ld", Float ) = 1
        _dx ("dx", Float ) = 1
        _color ("color", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "CanUseSpriteAtlas"="True"
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
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal vulkan
            #pragma target 3.0
            uniform float _ld;
            uniform float _dx;
            uniform float4 _color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 emissive = (pow(pow(1.0-max(0,dot(normalDirection, viewDirection)),_ld),_dx)*_color.rgb);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
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
        //     #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal 
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
    // FallBack "Diffuse"
    // CustomEditor "ShaderForgeMaterialInspector"
}
