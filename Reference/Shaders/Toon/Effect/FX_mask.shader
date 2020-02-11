// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:0,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:False,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33021,y:32690,varname:node_4013,prsc:2|emission-2885-OUT,alpha-713-OUT;n:type:ShaderForge.SFN_Tex2d,id:5613,x:32128,y:32692,ptovrint:False,ptlb:texture,ptin:_texture,varname:_node_5613,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Tex2d,id:6048,x:32102,y:32915,ptovrint:False,ptlb:mask,ptin:_mask,varname:_d,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-8033-UVOUT;n:type:ShaderForge.SFN_Multiply,id:2885,x:32495,y:32749,varname:node_2885,prsc:2|A-5613-RGB,B-2445-RGB;n:type:ShaderForge.SFN_VertexColor,id:2445,x:32133,y:33144,varname:node_2445,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:1315,x:31446,y:32670,varname:node_1315,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:8033,x:31819,y:32710,varname:node_8033,prsc:2,spu:1,spv:0|UVIN-3262-OUT,DIST-1579-OUT;n:type:ShaderForge.SFN_Multiply,id:713,x:32629,y:32890,varname:node_713,prsc:2|A-5613-A,B-176-OUT;n:type:ShaderForge.SFN_Multiply,id:3262,x:31646,y:32698,varname:node_3262,prsc:2|A-1315-UVOUT,B-6864-OUT;n:type:ShaderForge.SFN_Slider,id:6864,x:31265,y:32843,ptovrint:False,ptlb:about,ptin:_about,varname:_node_6864,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_Multiply,id:1579,x:31646,y:32948,varname:node_1579,prsc:2|A-8984-OUT,B-2871-T;n:type:ShaderForge.SFN_Time,id:2871,x:31329,y:33024,varname:node_2871,prsc:2;n:type:ShaderForge.SFN_Slider,id:8984,x:31215,y:32956,ptovrint:False,ptlb:speed,ptin:_speed,varname:_node_8984,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-6,cur:0,max:6;n:type:ShaderForge.SFN_Multiply,id:176,x:32401,y:33132,varname:node_176,prsc:2|A-6048-A,B-2445-A;proporder:5613-6048-6864-8984;pass:END;sub:END;*/

Shader "Shader Forge/FX_mask" {
    Properties {
        _texture ("texture", 2D) = "white" {}
        _mask ("mask", 2D) = "white" {}
        _about ("about", Range(-1, 1)) = 0
        _speed ("speed", Range(-6, 6)) = 0
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
            uniform sampler2D _texture; uniform float4 _texture_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform float _about;
            uniform float _speed;
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
                float4 _texture_var = tex2D(_texture,TRANSFORM_TEX(i.uv0, _texture));
                float3 emissive = (_texture_var.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive;
                float4 node_2871 = _Time;
                float2 node_8033 = ((i.uv0*_about)+(_speed*node_2871.g)*float2(1,0));
                float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(node_8033, _mask));
                return fixed4(finalColor,(_texture_var.a*(_mask_var.a*i.vertexColor.a)));
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
