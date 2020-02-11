// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.371702,fgcg:0.6246458,fgcb:0.9191176,fgca:1,fgde:0.02,fgrn:20,fgrf:35,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:34826,y:32629,varname:node_9361,prsc:2|custl-8692-OUT,alpha-4247-OUT,olwid-8574-OUT,olcol-5566-RGB;n:type:ShaderForge.SFN_NormalVector,id:3505,x:33288,y:32762,prsc:2,pt:True;n:type:ShaderForge.SFN_Transform,id:8346,x:33462,y:32762,varname:node_8346,prsc:2,tffrom:0,tfto:3|IN-3505-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2304,x:33661,y:32762,varname:node_2304,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-8346-XYZ;n:type:ShaderForge.SFN_RemapRange,id:9314,x:33847,y:32762,varname:node_9314,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-2304-OUT;n:type:ShaderForge.SFN_Tex2d,id:9520,x:34070,y:32701,ptovrint:False,ptlb:Matcap,ptin:_Matcap,varname:_Matcap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-9314-OUT;n:type:ShaderForge.SFN_Blend,id:8692,x:34325,y:32870,varname:node_8692,prsc:2,blmd:12,clmp:True|SRC-91-OUT,DST-8671-RGB;n:type:ShaderForge.SFN_Tex2d,id:8671,x:34073,y:32965,ptovrint:False,ptlb:TEX,ptin:_TEX,varname:_TEX,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_ValueProperty,id:8574,x:34245,y:33066,ptovrint:False,ptlb:OutlineW,ptin:_OutlineW,varname:_OutlineW,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Color,id:5566,x:34369,y:33172,ptovrint:False,ptlb:Outlinecolor,ptin:_Outlinecolor,varname:_Outlinecolor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_VertexColor,id:9487,x:34577,y:32473,varname:node_9487,prsc:2;n:type:ShaderForge.SFN_Multiply,id:91,x:34331,y:32691,varname:node_91,prsc:2|A-4756-OUT,B-9520-RGB;n:type:ShaderForge.SFN_Slider,id:4756,x:33981,y:32544,ptovrint:False,ptlb:high_light,ptin:_high_light,varname:_high_light,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:4247,x:34640,y:32701,varname:node_4247,prsc:2|A-9487-A,B-1139-OUT;n:type:ShaderForge.SFN_Slider,id:1139,x:34252,y:32473,ptovrint:True,ptlb:opacity,ptin:_opacity,varname:_opacity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;proporder:9520-8671-8574-5566-4756-1139;pass:END;sub:END;*/

Shader "Shader Forge/zuanshi_faxian_superweapon" {
    Properties {
        _Matcap ("Matcap", 2D) = "white" {}
        _TEX ("TEX", 2D) = "white" {}
        _OutlineW ("OutlineW", Float ) = 0
        _Outlinecolor ("Outlinecolor", Color) = (0.5,0.5,0.5,1)
        _high_light ("high_light", Range(0, 1)) = 1
        _opacity ("opacity", Range(0, 1)) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform float _OutlineW;
            uniform float4 _Outlinecolor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*_OutlineW,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                return fixed4(_Outlinecolor.rgb,0);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            uniform sampler2D _TEX; uniform float4 _TEX_ST;
            uniform float _high_light;
            uniform float _opacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
                float2 node_9314 = (mul( UNITY_MATRIX_V, float4(normalDirection,0) ).xyz.rgb.rg*0.5+0.5);
                float4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9314, _Matcap));
                float4 _TEX_var = tex2D(_TEX,TRANSFORM_TEX(i.uv0, _TEX));
                float3 finalColor = saturate(((_high_light*_Matcap_var.rgb) > 0.5 ?  (1.0-(1.0-2.0*((_high_light*_Matcap_var.rgb)-0.5))*(1.0-_TEX_var.rgb)) : (2.0*(_high_light*_Matcap_var.rgb)*_TEX_var.rgb)) );
                return fixed4(finalColor,(i.vertexColor.a*_opacity));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
