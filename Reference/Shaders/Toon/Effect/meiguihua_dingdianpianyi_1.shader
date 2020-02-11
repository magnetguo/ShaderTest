// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
// /*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.2058824,fgcg:0.2058824,fgcb:0.2058824,fgca:1,fgde:0.01,fgrn:10,fgrf:20,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:34207,y:32489,varname:node_9361,prsc:2|emission-2012-OUT,custl-9685-OUT,clip-8569-OUT,voffset-6016-OUT;n:type:ShaderForge.SFN_Tex2d,id:851,x:33376,y:32429,ptovrint:False,ptlb:Diffuse,ptin:_Diffuse,varname:node_851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_TexCoord,id:2316,x:32502,y:32624,varname:node_2316,prsc:2,uv:1,uaff:False;n:type:ShaderForge.SFN_OneMinus,id:6589,x:32812,y:32643,varname:node_6589,prsc:2|IN-2316-V;n:type:ShaderForge.SFN_NormalVector,id:5123,x:32857,y:32934,prsc:2,pt:False;n:type:ShaderForge.SFN_Power,id:6016,x:33328,y:32673,varname:node_6016,prsc:2|VAL-6369-OUT,EXP-3905-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3905,x:33146,y:32786,ptovrint:False,ptlb:dx,ptin:_dx,varname:node_3905,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:122;n:type:ShaderForge.SFN_Subtract,id:6369,x:33115,y:32620,varname:node_6369,prsc:2|A-6589-OUT,B-4551-OUT;n:type:ShaderForge.SFN_Slider,id:4551,x:32794,y:32797,ptovrint:False,ptlb:tm,ptin:_tm,varname:node_4551,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Tex2d,id:1661,x:33377,y:32013,ptovrint:False,ptlb:mask,ptin:_mask,varname:node_1661,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_If,id:3065,x:33766,y:32261,varname:node_3065,prsc:2|A-1661-A,B-9405-A,GT-3479-OUT,EQ-3479-OUT,LT-8634-OUT;n:type:ShaderForge.SFN_Vector1,id:3479,x:33511,y:32348,varname:node_3479,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:8634,x:33543,y:32466,varname:node_8634,prsc:2,v1:0;n:type:ShaderForge.SFN_Color,id:9405,x:33356,y:32209,ptovrint:False,ptlb:ys,ptin:_ys,varname:node_9405,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_If,id:7055,x:33847,y:32085,varname:node_7055,prsc:2|A-1026-OUT,B-9405-A,GT-3479-OUT,EQ-3479-OUT,LT-8634-OUT;n:type:ShaderForge.SFN_Add,id:1026,x:33634,y:31989,varname:node_1026,prsc:2|A-1661-A,B-4993-OUT;n:type:ShaderForge.SFN_ValueProperty,id:4993,x:33553,y:32167,ptovrint:False,ptlb:kd,ptin:_kd,varname:node_4993,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Subtract,id:4260,x:34063,y:32138,varname:node_4260,prsc:2|A-7055-OUT,B-3065-OUT;n:type:ShaderForge.SFN_Add,id:8973,x:34337,y:32032,varname:node_8973,prsc:2|A-7055-OUT,B-4260-OUT;n:type:ShaderForge.SFN_Multiply,id:2012,x:34252,y:32201,varname:node_2012,prsc:2|A-4260-OUT,B-842-OUT,C-9405-RGB;n:type:ShaderForge.SFN_ValueProperty,id:842,x:33957,y:32302,ptovrint:False,ptlb:qd,ptin:_qd,varname:node_842,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:8569,x:34524,y:32068,varname:node_8569,prsc:2|A-8973-OUT,B-851-A;n:type:ShaderForge.SFN_Transform,id:2675,x:33055,y:32902,varname:node_2675,prsc:2,tffrom:0,tfto:3|IN-5123-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9203,x:33253,y:32872,varname:node_9203,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2675-XYZ;n:type:ShaderForge.SFN_RemapRange,id:1013,x:33474,y:32845,varname:node_1013,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-9203-OUT;n:type:ShaderForge.SFN_Tex2d,id:2776,x:33696,y:32778,ptovrint:False,ptlb:matcap,ptin:_matcap,varname:node_2776,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-1013-OUT;n:type:ShaderForge.SFN_Blend,id:9685,x:33897,y:32716,varname:node_9685,prsc:2,blmd:12,clmp:True|SRC-851-RGB,DST-2776-RGB;proporder:851-3905-4551-1661-9405-4993-842-2776;pass:END;sub:END;*/

Shader "Shader Forge/meiguihua_dingdianpianyi_1" {
    Properties {
        _Diffuse ("Diffuse", 2D) = "white" {}
        _dx ("dx", Float ) = 122
        _tm ("tm", Range(0, 1)) = 1
        _mask ("mask", 2D) = "white" {}
        _ys ("ys", Color) = (0.5,0.5,0.5,1)
        _kd ("kd", Float ) = 0
        _qd ("qd", Float ) = 0
        _matcap ("matcap", 2D) = "white" {}
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Diffuse; uniform half4 _Diffuse_ST;
            uniform half _dx;
            uniform half _tm;
            uniform sampler2D _mask; uniform half4 _mask_ST;
            uniform half4 _ys;
            uniform half _kd;
            uniform half _qd;
            uniform sampler2D _matcap; uniform half4 _matcap_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
                half2 texcoord1 : TEXCOORD1;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half2 uv1 : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float node_6016 = pow(((1.0 - o.uv1.g)-_tm),_dx);
                v.vertex.xyz += float3(node_6016,node_6016,node_6016);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            half4 frag(VertexOutput i) : COLOR {
                // i.normalDir = normalize(i.normalDir);
                // float3 normalDirection = i.normalDir;
                half4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
                half node_7055_if_leA = step((_mask_var.a+_kd),_ys.a);
                half node_7055_if_leB = step(_ys.a,(_mask_var.a+_kd));
                // half node_8634 = 0.0;
                // half node_3479 = 1.0;
                half node_7055 = lerp( (node_7055_if_leB ),1,node_7055_if_leA*node_7055_if_leB);
                half node_3065_if_leA = step(_mask_var.a,_ys.a);
                half node_3065_if_leB = step(_ys.a,_mask_var.a);
                half node_4260 = (node_7055-lerp( (node_3065_if_leB*1),1,node_3065_if_leA*node_3065_if_leB));
                half4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
                clip(((node_7055+node_4260)*_Diffuse_var.a) - 0.5);
////// Lighting:
////// Emissive:
                half3 emissive = (node_4260*_qd*_ys.rgb);
                float2 node_1013 = (mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*0.5+0.5);
                half4 _matcap_var = tex2D(_matcap,TRANSFORM_TEX(node_1013, _matcap));
                half3 finalColor = emissive + saturate((_Diffuse_var.rgb > 0.5 ?  (1.0-(1.0-2.0*(_Diffuse_var.rgb-0.5))*(1.0-_matcap_var.rgb)) : (2.0*_Diffuse_var.rgb*_matcap_var.rgb)) );
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
        //     Cull Back
            
        //     CGPROGRAM
        //     #pragma vertex vert
        //     #pragma fragment frag
        //     #include "UnityCG.cginc"
        //     #include "Lighting.cginc"
        //     #pragma fragmentoption ARB_precision_hint_fastest
        //     #pragma multi_compile_shadowcaster
        //     #pragma multi_compile_fog
        //     //#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
        //     #pragma target 3.0
        //     uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
        //     uniform float _dx;
        //     uniform float _tm;
        //     uniform sampler2D _mask; uniform float4 _mask_ST;
        //     uniform float4 _ys;
        //     uniform float _kd;
        //     struct VertexInput {
        //         float4 vertex : POSITION;
        //         float2 texcoord0 : TEXCOORD0;
        //         float2 texcoord1 : TEXCOORD1;
        //     };
        //     struct VertexOutput {
        //         V2F_SHADOW_CASTER;
        //         float2 uv0 : TEXCOORD1;
        //         float2 uv1 : TEXCOORD2;
        //     };
        //     VertexOutput vert (VertexInput v) {
        //         VertexOutput o = (VertexOutput)0;
        //         o.uv0 = v.texcoord0;
        //         o.uv1 = v.texcoord1;
        //         float node_6016 = pow(((1.0 - o.uv1.g)-_tm),_dx);
        //         v.vertex.xyz += float3(node_6016,node_6016,node_6016);
        //         o.pos = UnityObjectToClipPos( v.vertex );
        //         TRANSFER_SHADOW_CASTER(o)
        //         return o;
        //     }
        //     float4 frag(VertexOutput i) : COLOR {
        //         float4 _mask_var = tex2D(_mask,TRANSFORM_TEX(i.uv0, _mask));
        //         float node_7055_if_leA = step((_mask_var.a+_kd),_ys.a);
        //         float node_7055_if_leB = step(_ys.a,(_mask_var.a+_kd));
        //         float node_8634 = 0.0;
        //         float node_3479 = 1.0;
        //         float node_7055 = lerp((node_7055_if_leA*node_8634)+(node_7055_if_leB*node_3479),node_3479,node_7055_if_leA*node_7055_if_leB);
        //         float node_3065_if_leA = step(_mask_var.a,_ys.a);
        //         float node_3065_if_leB = step(_ys.a,_mask_var.a);
        //         float node_4260 = (node_7055-lerp((node_3065_if_leA*node_8634)+(node_3065_if_leB*node_3479),node_3479,node_3065_if_leA*node_3065_if_leB));
        //         float4 _Diffuse_var = tex2D(_Diffuse,TRANSFORM_TEX(i.uv0, _Diffuse));
        //         clip(((node_7055+node_4260)*_Diffuse_var.a) - 0.5);
        //         SHADOW_CASTER_FRAGMENT(i)
        //     }
        //     ENDCG
        // }
    }
    // FallBack "Diffuse"
    // CustomEditor "ShaderForgeMaterialInspector"
}
