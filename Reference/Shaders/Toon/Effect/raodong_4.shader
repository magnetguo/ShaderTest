// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
// /*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33863,y:32770,varname:node_9361,prsc:2|emission-3809-OUT,custl-2003-OUT,clip-7820-OUT;n:type:ShaderForge.SFN_Tex2d,id:7851,x:32529,y:32729,ptovrint:False,ptlb:texture1,ptin:_texture1,varname:node_7851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:82b282462242c7849a82aad383892ba1,ntxv:0,isnm:False|UVIN-1503-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:8423,x:32074,y:32954,varname:node_8423,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:8906,x:32313,y:32968,varname:node_8906,prsc:2,spu:0,spv:-1|UVIN-8423-UVOUT,DIST-5906-OUT;n:type:ShaderForge.SFN_Color,id:6803,x:32797,y:32295,ptovrint:False,ptlb:color,ptin:_color,varname:node_6803,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:4953,x:33172,y:32715,varname:node_4953,prsc:2|A-6803-RGB,B-7399-OUT;n:type:ShaderForge.SFN_Multiply,id:2759,x:33203,y:32527,varname:node_2759,prsc:2|A-6803-A,B-9119-A;n:type:ShaderForge.SFN_VertexColor,id:9119,x:32815,y:32510,varname:node_9119,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2003,x:33398,y:32768,varname:node_2003,prsc:2|A-2759-OUT,B-4953-OUT;n:type:ShaderForge.SFN_Tex2d,id:4118,x:32946,y:33076,ptovrint:False,ptlb:textuer2,ptin:_textuer2,varname:node_4118,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:61c0b9c0523734e0e91bc6043c72a490,ntxv:0,isnm:False|UVIN-2948-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:2393,x:32946,y:33269,ptovrint:False,ptlb:touming,ptin:_touming,varname:node_2393,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:561f570920f1c1e4cae727238192b940,ntxv:0,isnm:False|UVIN-656-UVOUT;n:type:ShaderForge.SFN_Multiply,id:2293,x:33257,y:33162,varname:node_2293,prsc:2|A-4118-R,B-2393-R;n:type:ShaderForge.SFN_Power,id:7399,x:32857,y:32746,varname:node_7399,prsc:2|VAL-7851-RGB,EXP-9789-OUT;n:type:ShaderForge.SFN_Slider,id:9789,x:32530,y:32935,ptovrint:False,ptlb:qd,ptin:_qd,varname:node_9789,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5413959,max:9;n:type:ShaderForge.SFN_Step,id:7820,x:33514,y:33231,varname:node_7820,prsc:2|A-3699-OUT,B-2293-OUT;n:type:ShaderForge.SFN_Slider,id:3699,x:33179,y:33375,ptovrint:False,ptlb:dx,ptin:_dx,varname:node_3699,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2206917,max:1;n:type:ShaderForge.SFN_Time,id:2375,x:31685,y:33021,varname:node_2375,prsc:2;n:type:ShaderForge.SFN_Multiply,id:5906,x:31999,y:33115,varname:node_5906,prsc:2|A-2375-T,B-464-OUT;n:type:ShaderForge.SFN_Slider,id:464,x:31587,y:33197,ptovrint:False,ptlb:2y,ptin:_2y,varname:node_464,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0.4312092,max:3;n:type:ShaderForge.SFN_Panner,id:2349,x:32103,y:32560,varname:node_2349,prsc:2,spu:0,spv:-1|UVIN-7634-UVOUT,DIST-611-OUT;n:type:ShaderForge.SFN_TexCoord,id:7634,x:31800,y:32532,varname:node_7634,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Step,id:4820,x:32887,y:32907,varname:node_4820,prsc:2|A-9789-OUT,B-7851-RGB;n:type:ShaderForge.SFN_Panner,id:1503,x:32318,y:32684,varname:node_1503,prsc:2,spu:-1,spv:0|UVIN-2349-UVOUT,DIST-6144-OUT;n:type:ShaderForge.SFN_Slider,id:2286,x:31531,y:32693,ptovrint:False,ptlb:1y,ptin:_1y,varname:node_2286,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0,max:3;n:type:ShaderForge.SFN_Slider,id:159,x:31613,y:32811,ptovrint:False,ptlb:1x,ptin:_1x,varname:node_159,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0.1788805,max:3;n:type:ShaderForge.SFN_Multiply,id:611,x:31914,y:32678,varname:node_611,prsc:2|A-2286-OUT,B-2375-T;n:type:ShaderForge.SFN_Multiply,id:6144,x:32073,y:32781,varname:node_6144,prsc:2|A-159-OUT,B-2375-T;n:type:ShaderForge.SFN_Panner,id:2948,x:32609,y:33097,varname:node_2948,prsc:2,spu:-1,spv:0|UVIN-8906-UVOUT,DIST-1197-OUT;n:type:ShaderForge.SFN_Slider,id:9011,x:31975,y:33278,ptovrint:False,ptlb:2x,ptin:_2x,varname:node_9011,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0,max:3;n:type:ShaderForge.SFN_Multiply,id:1197,x:32297,y:33170,varname:node_1197,prsc:2|A-2375-T,B-9011-OUT;n:type:ShaderForge.SFN_Multiply,id:3809,x:33593,y:32675,varname:node_3809,prsc:2|A-6803-RGB,B-9119-RGB;n:type:ShaderForge.SFN_TexCoord,id:7074,x:32254,y:33413,varname:node_7074,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:6999,x:32494,y:33413,varname:node_6999,prsc:2,spu:0,spv:1|UVIN-7074-UVOUT,DIST-8140-OUT;n:type:ShaderForge.SFN_Panner,id:656,x:32716,y:33402,varname:node_656,prsc:2,spu:1,spv:0|UVIN-6999-UVOUT,DIST-5276-OUT;n:type:ShaderForge.SFN_Slider,id:488,x:31868,y:33589,ptovrint:False,ptlb:3X,ptin:_3X,varname:node_488,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0,max:3;n:type:ShaderForge.SFN_Slider,id:9096,x:31953,y:33766,ptovrint:False,ptlb:3Y,ptin:_3Y,varname:node_9096,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-3,cur:0,max:3;n:type:ShaderForge.SFN_Multiply,id:5276,x:32556,y:33696,varname:node_5276,prsc:2|A-2375-T,B-9096-OUT;n:type:ShaderForge.SFN_Multiply,id:8140,x:32324,y:33600,varname:node_8140,prsc:2|A-2375-T,B-488-OUT;proporder:7851-6803-4118-2393-9789-3699-159-2286-9011-464-488-9096;pass:END;sub:END;*/

Shader "Effect/raodong_4" {
    Properties {
        _texture1 ("texture1", 2D) = "white" {}
        _color ("color", Color) = (0.5,0.5,0.5,1)
		_WeatherColor("Weather Color",Color) = (1,1,1,1)
        _textuer2 ("textuer2", 2D) = "white" {}
        _touming ("touming", 2D) = "white" {}
        _qd ("qd", Range(0, 9)) = 0.5413959
        _dx ("dx", Range(0, 1)) = 0.2206917
        _1x ("1x", Range(-3, 3)) = 0.1788805
        _1y ("1y", Range(-3, 3)) = 0
        _2x ("2x", Range(-3, 3)) = 0
        _2y ("2y", Range(-3, 3)) = 0.4312092
        _3X ("3X", Range(-3, 3)) = 0
        _3Y ("3Y", Range(-3, 3)) = 0
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            // Name "FORWARD"
            // Tags {
            //     "LightMode"="ForwardBase"
            // }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
			#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _texture1; uniform half4 _texture1_ST;
            uniform half4 _color;
			fixed4 _WeatherColor;
            uniform sampler2D _textuer2; uniform half4 _textuer2_ST;
            uniform sampler2D _touming; uniform half4 _touming_ST;
            uniform half _qd;
            uniform half _dx;
            uniform half _2y;
            uniform half _1y;
            uniform half _1x;
            uniform half _2x;
            uniform half _3X;
            uniform half _3Y;
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
            half4 frag(VertexOutput i) : COLOR {
                half4 node_2375 = _Time;
                float2 node_2948 = ((i.uv0+(node_2375.g*_2y)*half2(0,-1))+(node_2375.g*_2x)*half2(-1,0));
                half4 _textuer2_var = tex2D(_textuer2,TRANSFORM_TEX(node_2948, _textuer2));
                half2 node_656 = ((i.uv0+(node_2375.g*_3X)*half2(0,1))+(node_2375.g*_3Y)*half2(1,0));
                half4 _touming_var = tex2D(_touming,TRANSFORM_TEX(node_656, _touming));
                clip(step(_dx,(_textuer2_var.r*_touming_var.r)) - 0.5);
////// Lighting:
////// Emissive:
                half3 emissive = (_color.rgb*i.vertexColor.rgb);
                float2 node_1503 = ((i.uv0+(_1y*node_2375.g)*half2(0,-1))+(_1x*node_2375.g)*half2(-1,0));
                half4 _texture1_var = tex2D(_texture1,TRANSFORM_TEX(node_1503, _texture1));
                half3 finalColor = emissive + ((_color.a*i.vertexColor.a)*(_color.rgb*pow(_texture1_var.rgb,_qd)));
				APPLY_WEATHER(finalColor.rgb,_WeatherColor);
                half4 finalRGBA = half4(finalColor,1);
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
        //     Cull Back
            
        //     CGPROGRAM
        //     #pragma vertex vert
        //     #pragma fragment frag
        //     #define UNITY_PASS_SHADOWCASTER
        //     #include "UnityCG.cginc"
        //     #include "Lighting.cginc"
        //     #pragma fragmentoption ARB_precision_hint_fastest
        //     #pragma multi_compile_shadowcaster
        //     #pragma multi_compile_fog
        //     //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
        //     #pragma target 3.0
        //     uniform sampler2D _textuer2; uniform float4 _textuer2_ST;
        //     uniform sampler2D _touming; uniform float4 _touming_ST;
        //     uniform float _dx;
        //     uniform float _2y;
        //     uniform float _2x;
        //     uniform float _3X;
        //     uniform float _3Y;
        //     struct VertexInput {
        //         float4 vertex : POSITION;
        //         float2 texcoord0 : TEXCOORD0;
        //     };
        //     struct VertexOutput {
        //         V2F_SHADOW_CASTER;
        //         float2 uv0 : TEXCOORD1;
        //     };
        //     VertexOutput vert (VertexInput v) {
        //         VertexOutput o = (VertexOutput)0;
        //         o.uv0 = v.texcoord0;
        //         o.pos = UnityObjectToClipPos( v.vertex );
        //         TRANSFER_SHADOW_CASTER(o)
        //         return o;
        //     }
        //     float4 frag(VertexOutput i) : COLOR {
        //         float4 node_2375 = _Time;
        //         float2 node_2948 = ((i.uv0+(node_2375.g*_2y)*float2(0,-1))+(node_2375.g*_2x)*float2(-1,0));
        //         float4 _textuer2_var = tex2D(_textuer2,TRANSFORM_TEX(node_2948, _textuer2));
        //         float2 node_656 = ((i.uv0+(node_2375.g*_3X)*float2(0,1))+(node_2375.g*_3Y)*float2(1,0));
        //         float4 _touming_var = tex2D(_touming,TRANSFORM_TEX(node_656, _touming));
        //         clip(step(_dx,(_textuer2_var.r*_touming_var.r)) - 0.5);
        //         SHADOW_CASTER_FRAGMENT(i)
        //     }
        //     ENDCG
        // }
    }
    // FallBack "Diffuse"
    // CustomEditor "ShaderForgeMaterialInspector"
}
