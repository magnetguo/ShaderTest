// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
// /*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:True,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33619,y:32683,varname:node_9361,prsc:2|emission-2607-OUT,alpha-8015-OUT;n:type:ShaderForge.SFN_Tex2d,id:1924,x:32828,y:32832,ptovrint:False,ptlb:diffuse,ptin:_diffuse,varname:node_1924,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a65aaa1a1d71c2840bc906fd4c0ec905,ntxv:0,isnm:False|UVIN-7861-OUT;n:type:ShaderForge.SFN_Multiply,id:2607,x:33100,y:32702,varname:node_2607,prsc:2|A-4823-RGB,B-1924-RGB,C-2026-RGB;n:type:ShaderForge.SFN_Multiply,id:9348,x:33085,y:32933,varname:node_9348,prsc:2|A-1924-A,B-4823-A,C-2026-A;n:type:ShaderForge.SFN_VertexColor,id:4823,x:32774,y:32628,varname:node_4823,prsc:2;n:type:ShaderForge.SFN_Panner,id:9230,x:31892,y:33077,varname:node_9230,prsc:2,spu:0.1,spv:-0.1|UVIN-8947-UVOUT,DIST-9957-OUT;n:type:ShaderForge.SFN_Tex2d,id:5000,x:32047,y:32941,ptovrint:False,ptlb:niose1,ptin:_niose1,varname:node_5000,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:54871d4dbec96b242beabc83865be179,ntxv:0,isnm:False|UVIN-9230-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:8947,x:31715,y:32933,varname:node_8947,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:4211,x:32416,y:32831,varname:node_4211,prsc:2|A-5783-OUT,B-3321-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3321,x:32182,y:32812,ptovrint:False,ptlb:qiangdu,ptin:_qiangdu,varname:node_3321,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0.01;n:type:ShaderForge.SFN_Add,id:7861,x:32631,y:32791,varname:node_7861,prsc:2|A-4468-UVOUT,B-4211-OUT;n:type:ShaderForge.SFN_TexCoord,id:4468,x:32359,y:32606,varname:node_4468,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:4779,x:31787,y:33287,varname:node_4779,prsc:2,spu:-0.1,spv:0.1|UVIN-3578-UVOUT,DIST-7025-OUT;n:type:ShaderForge.SFN_Tex2d,id:6423,x:32016,y:33266,ptovrint:False,ptlb:niose2,ptin:_niose2,varname:_node_5000_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b228de55718672e4ca1103c2e100d68b,ntxv:0,isnm:False|UVIN-4779-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:3578,x:31548,y:33287,varname:node_3578,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ComponentMask,id:5783,x:32390,y:33034,varname:node_5783,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-8656-OUT;n:type:ShaderForge.SFN_Add,id:8656,x:32212,y:33120,varname:node_8656,prsc:2|A-5000-RGB,B-6423-RGB;n:type:ShaderForge.SFN_ValueProperty,id:4338,x:31502,y:33459,ptovrint:False,ptlb:dusu2,ptin:_dusu2,varname:node_4338,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:7139,x:31517,y:33537,varname:node_7139,prsc:2;n:type:ShaderForge.SFN_Multiply,id:7025,x:31737,y:33474,varname:node_7025,prsc:2|A-4338-OUT,B-7139-T;n:type:ShaderForge.SFN_ValueProperty,id:6021,x:31479,y:33061,ptovrint:False,ptlb:dusu1,ptin:_dusu1,varname:_dusu_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Time,id:7971,x:31494,y:33140,varname:node_7971,prsc:2;n:type:ShaderForge.SFN_Multiply,id:9957,x:31715,y:33077,varname:node_9957,prsc:2|A-6021-OUT,B-7971-T;n:type:ShaderForge.SFN_Color,id:2026,x:32774,y:32459,ptovrint:False,ptlb:color,ptin:_color,varname:node_2026,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Tex2d,id:2621,x:33080,y:33152,ptovrint:False,ptlb:mask,ptin:_mask,varname:node_2621,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:8015,x:33297,y:33069,varname:node_8015,prsc:2|A-9348-OUT,B-2621-A;proporder:1924-5000-6423-3321-4338-6021-2026-2621;pass:END;sub:END;*/

Shader "Shader Forge/raodong_1" {
    Properties {
        _diffuse ("diffuse", 2D) = "white" {}
        _niose1 ("niose1", 2D) = "white" {}
        _niose2 ("niose2", 2D) = "white" {}
        _qiangdu ("qiangdu", Float ) = 0.01
        _dusu2 ("dusu2", Float ) = 0
        _dusu1 ("dusu1", Float ) = 0
        _color ("color", Color) = (0.5,0.5,0.5,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
        _mask ("mask", 2D) = "white" {}
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
            // Name "FORWARD"
            // Tags {
            //     "LightMode"="ForwardBase"
            // }
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
			#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
            #pragma target 3.0
            uniform sampler2D _diffuse; uniform half4 _diffuse_ST;
            uniform sampler2D _niose1; uniform half4 _niose1_ST;
            uniform half _qiangdu;
            uniform sampler2D _niose2; uniform half4 _niose2_ST;
            uniform half _dusu2;
            uniform half _dusu1;
            uniform half4 _color;
			fixed4 _WeatherColor;
            uniform sampler2D _mask; uniform half4 _mask_ST;
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
            half4 frag(VertexOutput i, half facing : VFACE) : COLOR {
                // half isFrontFace = ( facing >= 0 ? 1 : 0 );
                // half faceSign = ( facing >= 0 ? 1 : -1 );
////// Lighting:
////// Emissive:
                // float4 node_7971 = _Time;
                float2 node_9230 = (i.uv0+(_dusu1*_Time.g)*float2(0.1,-0.1));
                half4 _niose1_var = tex2D(_niose1,TRANSFORM_TEX(node_9230, _niose1));
                // float4 node_7139 = _Time;
                float2 node_4779 = (i.uv0+(_dusu2*_Time.g)*float2(-0.1,0.1));
                half4 _niose2_var = tex2D(_niose2,TRANSFORM_TEX(node_4779, _niose2));
                half2 node_7861 = (i.uv0+((_niose1_var.rgb+_niose2_var.rgb).r*_qiangdu));
                half4 _diffuse_var = tex2D(_diffuse,TRANSFORM_TEX(node_7861, _diffuse));
                half3 node_2607 = (i.vertexColor.rgb*_diffuse_var.rgb*_color.rgb);
                // half3 emissive = node_2607;
                half3 finalColor = node_2607;
                half4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                fixed4 finalRGBA = fixed4(finalColor,((_diffuse_var.a*i.vertexColor.a*_color.a)*_mask_var.a));
				APPLY_WEATHER(finalRGBA.rgb,_WeatherColor);
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
        //     #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
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
