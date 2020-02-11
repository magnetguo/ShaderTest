// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
// /*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:False,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:34819,y:32428,varname:node_9361,prsc:2|emission-2707-OUT,custl-3340-OUT,alpha-9556-A;n:type:ShaderForge.SFN_NormalVector,id:3505,x:33288,y:32762,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:8346,x:33462,y:32762,varname:node_8346,prsc:2,tffrom:0,tfto:3|IN-3505-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2304,x:33661,y:32762,varname:node_2304,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8346-XYZ;n:type:ShaderForge.SFN_RemapRange,id:9314,x:33847,y:32762,varname:node_9314,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-2304-OUT;n:type:ShaderForge.SFN_Tex2d,id:9520,x:34032,y:32661,ptovrint:False,ptlb:Matcap,ptin:_Matcap,varname:_Matcap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9314-OUT;n:type:ShaderForge.SFN_Blend,id:8692,x:34291,y:32744,varname:node_8692,prsc:2,blmd:10,clmp:True|SRC-9520-RGB,DST-8671-RGB;n:type:ShaderForge.SFN_Tex2d,id:8671,x:34140,y:32856,ptovrint:False,ptlb:textrue,ptin:_textrue,varname:_node_8671,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:39e558a91954f6c4c82949fb3f7d25f7,ntxv:0,isnm:False;n:type:ShaderForge.SFN_VertexColor,id:9556,x:34247,y:32335,varname:node_9556,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3340,x:34434,y:32596,varname:node_3340,prsc:2|A-1104-RGB,B-9520-RGB,C-9556-RGB,D-1104-RGB;n:type:ShaderForge.SFN_Color,id:1104,x:34032,y:32335,ptovrint:False,ptlb:color,ptin:_color,varname:node_1104,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Fresnel,id:2707,x:33945,y:32504,varname:node_2707,prsc:2|EXP-3293-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3293,x:33614,y:32583,ptovrint:False,ptlb:qd,ptin:_qd,varname:node_3293,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:12;proporder:9520-8671-3293-1104;pass:END;sub:END;*/

Shader "Shader Forge/FX_bing_2" {
    Properties {
        _Matcap ("Matcap", 2D) = "white" {}
        _textrue ("textrue", 2D) = "white" {}
        _qd ("qd", Float ) = 12
        [HDR]_color ("color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
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
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
            #pragma target 3.0
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            uniform float4 _color;
            uniform float _qd;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float3 viewDirection : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.viewDirection = normalize(_WorldSpaceCameraPos.xyz -  mul(unity_ObjectToWorld, v.vertex).xyz);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = i.viewDirection;
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float node_2707 = pow(1.0-max(0,dot(normalDirection, viewDirection)),_qd);
                float3 emissive = float3(node_2707,node_2707,node_2707);
                float2 node_9314 = (mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*0.5+0.5);
                float4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9314, _Matcap));
                float3 finalColor = emissive + (_color.rgb*_Matcap_var.rgb*i.vertexColor.rgb*_color.rgb);
                fixed4 finalRGBA = fixed4(finalColor,i.vertexColor.a);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    // FallBack "Diffuse"
    // CustomEditor "ShaderForgeMaterialInspector"
}
