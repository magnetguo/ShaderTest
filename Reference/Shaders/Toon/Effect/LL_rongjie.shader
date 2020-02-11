// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32964,y:32704,varname:node_3138,prsc:2|emission-4863-OUT,alpha-3418-OUT;n:type:ShaderForge.SFN_Multiply,id:3047,x:32588,y:32800,varname:node_3047,prsc:2|A-9052-A,B-8890-RGB;n:type:ShaderForge.SFN_Multiply,id:3418,x:32588,y:32965,varname:node_3418,prsc:2|A-9052-A,B-4424-OUT;n:type:ShaderForge.SFN_Tex2d,id:1279,x:31255,y:32977,ptovrint:False,ptlb:rongjie_T,ptin:_rongjie_T,varname:_rongjie_T,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:d62141b35d6382b4dbb3f1342a5d054d,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Add,id:8732,x:31830,y:33145,varname:node_8732,prsc:2|A-1279-R,B-543-OUT,C-4669-OUT;n:type:ShaderForge.SFN_Vector1,id:543,x:31592,y:33162,varname:node_543,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:4669,x:31751,y:33360,varname:node_4669,prsc:2|A-7812-OUT,B-1267-OUT;n:type:ShaderForge.SFN_Vector1,id:1267,x:31545,y:33488,varname:node_1267,prsc:2,v1:-2;n:type:ShaderForge.SFN_Clamp01,id:3751,x:32001,y:33145,varname:node_3751,prsc:2|IN-8732-OUT;n:type:ShaderForge.SFN_Smoothstep,id:4424,x:32152,y:33010,varname:node_4424,prsc:2|A-9015-OUT,B-1364-OUT,V-3751-OUT;n:type:ShaderForge.SFN_OneMinus,id:9015,x:32001,y:32979,varname:node_9015,prsc:2|IN-1364-OUT;n:type:ShaderForge.SFN_Slider,id:1364,x:31673,y:32995,ptovrint:False,ptlb:ruanying,ptin:_ruanying,varname:_ruanying,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.5,cur:0.690371,max:1;n:type:ShaderForge.SFN_VertexColor,id:8890,x:32353,y:33110,varname:node_8890,prsc:2;n:type:ShaderForge.SFN_Multiply,id:4863,x:32758,y:32679,varname:node_4863,prsc:2|A-6375-OUT,B-3047-OUT;n:type:ShaderForge.SFN_Slider,id:6375,x:32568,y:32598,ptovrint:False,ptlb:zifaguang_liangdu,ptin:_zifaguang_liangdu,varname:_zifaguang_liangdu,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:50;n:type:ShaderForge.SFN_Tex2d,id:9052,x:31990,y:32724,ptovrint:False,ptlb:diffuse,ptin:_diffuse,varname:_diffuse,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_OneMinus,id:7812,x:31518,y:33338,varname:node_7812,prsc:2|IN-8890-A;proporder:1279-1364-6375-9052;pass:END;sub:END;*/

Shader "Shader Forge/LL_rongjie" {
    Properties {
        _rongjie_T ("rongjie_T", 2D) = "white" {}
        _ruanying ("ruanying", Range(0.5, 1)) = 0.690371
        _zifaguang_liangdu ("zifaguang_liangdu", Range(0, 50)) = 1
        _diffuse ("diffuse", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
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
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles vulkan metal gles3
            #pragma target 3.0
            uniform sampler2D _rongjie_T; uniform float4 _rongjie_T_ST;
            uniform float _ruanying;
            uniform float _zifaguang_liangdu;
            uniform sampler2D _diffuse; uniform float4 _diffuse_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 _diffuse_var = tex2D(_diffuse,TRANSFORM_TEX(i.uv0, _diffuse));
                float3 emissive = (_zifaguang_liangdu*(_diffuse_var.a*i.vertexColor.rgb));
                float3 finalColor = emissive;
                float4 _rongjie_T_var = tex2D(_rongjie_T,TRANSFORM_TEX(i.uv0, _rongjie_T));
                return fixed4(finalColor,(_diffuse_var.a*smoothstep( (1.0 - _ruanying), _ruanying, saturate((_rongjie_T_var.r+1.0+((1.0 - i.vertexColor.a)*(-2.0)))) )));
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles vulkan metal gles3
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
