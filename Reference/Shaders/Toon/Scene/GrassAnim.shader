// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33131,y:32142,varname:node_9361,prsc:2|emission-544-OUT,clip-851-A,voffset-325-OUT;n:type:ShaderForge.SFN_Tex2d,id:851,x:32065,y:32037,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:544,x:32277,y:32164,cmnt:Diffuse Color,varname:node_544,prsc:2|A-851-RGB,B-8399-RGB;n:type:ShaderForge.SFN_TexCoord,id:5700,x:31636,y:32573,varname:node_5700,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_Vector3,id:4795,x:32490,y:32587,varname:node_4795,prsc:2,v1:0,v2:0,v3:0.05;n:type:ShaderForge.SFN_FragmentPosition,id:9974,x:31880,y:32633,varname:node_9974,prsc:2;n:type:ShaderForge.SFN_Multiply,id:1102,x:32451,y:32815,varname:node_1102,prsc:2|A-9974-X,B-7669-OUT,C-8158-TSL,D-4479-OUT;n:type:ShaderForge.SFN_Vector1,id:7669,x:32152,y:32877,varname:node_7669,prsc:2,v1:4;n:type:ShaderForge.SFN_Sin,id:4430,x:32675,y:32802,varname:node_4430,prsc:2|IN-1102-OUT;n:type:ShaderForge.SFN_Time,id:8158,x:32137,y:32653,varname:node_8158,prsc:2;n:type:ShaderForge.SFN_Multiply,id:325,x:32723,y:32618,varname:node_325,prsc:2|A-4795-OUT,B-4430-OUT;n:type:ShaderForge.SFN_Vector1,id:6355,x:31861,y:33202,varname:node_6355,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Subtract,id:4479,x:32060,y:33083,varname:node_4479,prsc:2|A-5700-V,B-6355-OUT;n:type:ShaderForge.SFN_VertexColor,id:8399,x:32111,y:32296,varname:node_8399,prsc:2;proporder:851;pass:END;sub:END;*/

Shader "Valkyrie/Toon/Scene/GrassAnim" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.vertexColor = v.vertexColor;
                float4 node_8158 = _Time;
                v.vertex.xyz += (float3(0,0,0.05)*sin((mul(unity_ObjectToWorld, v.vertex).r*4.0*node_8158.r*(o.uv1.g-0.2))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                clip(_Diffuse_var.a - 0.5);
////// Lighting:
////// Emissive:
                float3 emissive = (_Diffuse_var.rgb*i.vertexColor.rgb);
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Back
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float2 uv1 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                float4 node_8158 = _Time;
                v.vertex.xyz += (float3(0,0,0.05)*sin((mul(unity_ObjectToWorld, v.vertex).r*4.0*node_8158.r*(o.uv1.g-0.2))));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                clip(_Diffuse_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
