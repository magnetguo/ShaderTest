// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
// /*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.371702,fgcg:0.6246458,fgcb:0.9191176,fgca:1,fgde:0.02,fgrn:20,fgrf:35,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:34807,y:32403,varname:node_9361,prsc:2|custl-3340-OUT,alpha-9556-A;n:type:ShaderForge.SFN_NormalVector,id:3505,x:33288,y:32762,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:8346,x:33462,y:32762,varname:node_8346,prsc:2,tffrom:0,tfto:3|IN-3505-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2304,x:33661,y:32762,varname:node_2304,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8346-XYZ;n:type:ShaderForge.SFN_RemapRange,id:9314,x:33847,y:32762,varname:node_9314,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-2304-OUT;n:type:ShaderForge.SFN_Tex2d,id:9520,x:34032,y:32661,ptovrint:False,ptlb:Matcap,ptin:_Matcap,varname:_Matcap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9314-OUT;n:type:ShaderForge.SFN_Blend,id:8692,x:34291,y:32744,varname:node_8692,prsc:2,blmd:10,clmp:True|SRC-9520-RGB,DST-8671-RGB;n:type:ShaderForge.SFN_Tex2d,id:8671,x:34140,y:32856,ptovrint:False,ptlb:textrue,ptin:_textrue,varname:_node_8671,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:39e558a91954f6c4c82949fb3f7d25f7,ntxv:0,isnm:False;n:type:ShaderForge.SFN_VertexColor,id:9556,x:34292,y:32476,varname:node_9556,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3340,x:34416,y:32608,varname:node_3340,prsc:2|A-1104-RGB,B-8692-OUT;n:type:ShaderForge.SFN_Color,id:1104,x:34026,y:32355,ptovrint:False,ptlb:color,ptin:_color,varname:node_1104,prsc:2,glob:False,taghide:False,taghdr:True,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;proporder:9520-8671-1104;pass:END;sub:END;*/

Shader "Shader Forge/FX_bing_3" {
    Properties {
        _Matcap ("Matcap", 2D) = "white" {}
        _textrue ("textrue", 2D) = "white" {}
        [HDR]_color ("color", Color) = (1,1,1,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            // Name "FORWARD"
            // Tags {
            //     "LightMode"="ForwardBase"
            // }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
            #pragma target 3.0
            uniform sampler2D _Matcap; uniform half4 _Matcap_ST;
            uniform sampler2D _textrue; uniform half4 _textrue_ST;
            uniform half4 _color;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
                half4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                half4 vertexColor : COLOR;
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            half4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float2 node_9314 = (mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*0.5+0.5);
                half4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9314, _Matcap));
                half4 _textrue_var = tex2D(_textrue,TRANSFORM_TEX(i.uv0, _textrue));
                half3 finalColor = (_color.rgb*saturate(( _textrue_var.rgb > 0.5 ? (1.0-(1.0-2.0*(_textrue_var.rgb-0.5))*(1.0-_Matcap_var.rgb)) : (2.0*_textrue_var.rgb*_Matcap_var.rgb) )));
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
