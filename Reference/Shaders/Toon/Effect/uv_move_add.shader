// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|emission-5331-OUT;n:type:ShaderForge.SFN_Tex2d,id:771,x:32724,y:32880,ptovrint:False,ptlb:node_771,ptin:_node_771,varname:_node_771,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1711-OUT;n:type:ShaderForge.SFN_Tex2d,id:6285,x:32724,y:32609,ptovrint:False,ptlb:mask,ptin:_mask,varname:_mask,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:6392,x:32708,y:33155,ptovrint:False,ptlb:node_6392,ptin:_node_6392,varname:_node_6392,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:4114,x:32951,y:32813,varname:node_4114,prsc:2|A-6285-RGB,B-771-RGB,C-6392-RGB,D-7701-RGB;n:type:ShaderForge.SFN_VertexColor,id:7701,x:32669,y:33437,varname:node_7701,prsc:2;n:type:ShaderForge.SFN_TexCoord,id:8755,x:32309,y:33090,varname:node_8755,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:1711,x:32342,y:33304,varname:node_1711,prsc:2|A-8755-UVOUT,B-8603-OUT;n:type:ShaderForge.SFN_ValueProperty,id:610,x:31802,y:32975,ptovrint:False,ptlb:u,ptin:_u,varname:_u,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:5330,x:31785,y:33490,ptovrint:False,ptlb:v,ptin:_v,varname:_v,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:6600,x:31973,y:33153,varname:node_6600,prsc:2|A-610-OUT,B-4725-TSL;n:type:ShaderForge.SFN_Multiply,id:185,x:31896,y:33318,varname:node_185,prsc:2|A-4725-TSL,B-5330-OUT;n:type:ShaderForge.SFN_Time,id:4725,x:31563,y:33350,varname:node_4725,prsc:2;n:type:ShaderForge.SFN_Append,id:8603,x:32135,y:33271,varname:node_8603,prsc:2|A-6600-OUT,B-185-OUT;n:type:ShaderForge.SFN_Multiply,id:5331,x:33071,y:32668,varname:node_5331,prsc:2|A-6415-OUT,B-4114-OUT;n:type:ShaderForge.SFN_Slider,id:6415,x:32791,y:32494,ptovrint:False,ptlb:zifaguangliangdu,ptin:_zifaguangliangdu,varname:_zifaguangliangdu,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;proporder:771-6285-6392-610-5330-6415;pass:END;sub:END;*/

Shader "Valkyrie/uv_move_add" {
    Properties {
        _node_771 ("node_771", 2D) = "white" {}
        _mask ("mask", 2D) = "white" {}
        _node_6392 ("node_6392", Color) = (0.5,0.5,0.5,1)
        _u ("u", Float ) = 0
        _v ("v", Float ) = 0
        _zifaguangliangdu ("zifaguangliangdu", Range(0, 10)) = 1
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
            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _node_771; uniform float4 _node_771_ST;
            uniform sampler2D _mask; uniform float4 _mask_ST;
            uniform float4 _node_6392;
            uniform float _u;
            uniform float _v;
            uniform float _zifaguangliangdu;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 vertexColor : COLOR;
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
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                float4 node_4725 = _Time;
                float2 node_1711 = (i.uv0+float2((_u*node_4725.r),(node_4725.r*_v)));
                float4 _node_771_var = tex2D(_node_771,TRANSFORM_TEX(node_1711, _node_771));
                float3 emissive = (_zifaguangliangdu*(_mask_var.rgb*_node_771_var.rgb*_node_6392.rgb*i.vertexColor.rgb));
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
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
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
