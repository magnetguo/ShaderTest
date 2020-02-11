// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:4013,x:33332,y:32669,varname:node_4013,prsc:2|diff-6321-OUT,emission-3824-OUT;n:type:ShaderForge.SFN_Color,id:1304,x:31569,y:32481,ptovrint:False,ptlb:Color_ren,ptin:_Color_ren,varname:_Color_ren,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Tex2d,id:4533,x:31613,y:32965,ptovrint:False,ptlb:node_4533,ptin:_node_4533,varname:_node_4533,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:03f2d13c2d1b1684bb055cc73cf8b983,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3160,x:31941,y:32654,varname:node_3160,prsc:2|A-1304-RGB,B-3578-OUT,C-4533-R,D-5485-RGB;n:type:ShaderForge.SFN_Vector1,id:3578,x:31581,y:32810,varname:node_3578,prsc:2,v1:1.5;n:type:ShaderForge.SFN_Color,id:8139,x:31803,y:33173,ptovrint:False,ptlb:Color_bing,ptin:_Color_bing,varname:_Color_bing,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Vector1,id:5490,x:31803,y:33371,varname:node_5490,prsc:2,v1:5;n:type:ShaderForge.SFN_Multiply,id:567,x:32065,y:33180,varname:node_567,prsc:2|A-4533-G,B-8139-G,C-5490-OUT;n:type:ShaderForge.SFN_Add,id:905,x:32284,y:32773,varname:node_905,prsc:2|A-6146-OUT,B-7353-OUT;n:type:ShaderForge.SFN_Power,id:6146,x:32284,y:32607,varname:node_6146,prsc:2|VAL-3334-OUT,EXP-5350-OUT;n:type:ShaderForge.SFN_Slider,id:5350,x:32002,y:32388,ptovrint:False,ptlb:power_ren,ptin:_power_ren,varname:_power_ren,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:2.4,max:10;n:type:ShaderForge.SFN_Power,id:7353,x:32233,y:33122,varname:node_7353,prsc:2|VAL-567-OUT,EXP-813-OUT;n:type:ShaderForge.SFN_Slider,id:813,x:31970,y:33052,ptovrint:False,ptlb:power_bing,ptin:_power_bing,varname:_power_bing,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:4.4,max:10;n:type:ShaderForge.SFN_Tex2d,id:5485,x:31251,y:32679,ptovrint:False,ptlb:node_5485,ptin:_node_5485,varname:_node_5485,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:61c0b9c0523734e0e91bc6043c72a490,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:4409,x:31480,y:32723,varname:node_4409,prsc:2|A-5485-RGB,B-4533-R;n:type:ShaderForge.SFN_Add,id:3334,x:32103,y:32557,varname:node_3334,prsc:2|A-3160-OUT,B-4409-OUT;n:type:ShaderForge.SFN_Multiply,id:3824,x:32694,y:32768,varname:node_3824,prsc:2|A-9796-OUT,B-905-OUT;n:type:ShaderForge.SFN_Tex2d,id:2196,x:32938,y:32528,ptovrint:False,ptlb:node_2196,ptin:_node_2196,varname:_node_2196,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:cc51773c9a307b645b5cc07dab36da7e,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6321,x:33121,y:32447,varname:node_6321,prsc:2|A-1625-OUT,B-2196-RGB;n:type:ShaderForge.SFN_Vector1,id:1625,x:32554,y:32331,varname:node_1625,prsc:2,v1:2.3;n:type:ShaderForge.SFN_Vector1,id:9796,x:32479,y:32510,varname:node_9796,prsc:2,v1:0.89;proporder:1304-4533-8139-5350-813-5485-2196;pass:END;sub:END;*/

Shader "Shader Forge/char_teleisha_weapon" {
    Properties {
        _Color_ren ("Color_ren", Color) = (1,1,1,1)
        _node_4533 ("node_4533", 2D) = "white" {}
        _Color_bing ("Color_bing", Color) = (1,1,1,1)
        _power_ren ("power_ren", Range(0, 10)) = 2.4
        _power_bing ("power_bing", Range(0, 10)) = 4.4
        _node_5485 ("node_5485", 2D) = "white" {}
        _node_2196 ("node_2196", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
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
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles vulkan metal gles3
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _Color_ren;
            uniform sampler2D _node_4533; uniform float4 _node_4533_ST;
            uniform float4 _Color_bing;
            uniform float _power_ren;
            uniform float _power_bing;
            uniform sampler2D _node_5485; uniform float4 _node_5485_ST;
            uniform sampler2D _node_2196; uniform float4 _node_2196_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation, i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float4 _node_2196_var = tex2D(_node_2196,TRANSFORM_TEX(i.uv0, _node_2196));
                float3 diffuseColor = (2.3*_node_2196_var.rgb);
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float4 _node_4533_var = tex2D(_node_4533,TRANSFORM_TEX(i.uv0, _node_4533));
                float4 _node_5485_var = tex2D(_node_5485,TRANSFORM_TEX(i.uv0, _node_5485));
                float3 emissive = (0.89*(pow(((_Color_ren.rgb*1.5*_node_4533_var.r*_node_5485_var.rgb)+(_node_5485_var.rgb*_node_4533_var.r)),_power_ren)+pow((_node_4533_var.g*_Color_bing.g*5.0),_power_bing)));
/// Final Color:
                float3 finalColor = diffuse + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles vulkan metal gles3
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform float4 _Color_ren;
            uniform sampler2D _node_4533; uniform float4 _node_4533_ST;
            uniform float4 _Color_bing;
            uniform float _power_ren;
            uniform float _power_bing;
            uniform sampler2D _node_5485; uniform float4 _node_5485_ST;
            uniform sampler2D _node_2196; uniform float4 _node_2196_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
                UNITY_FOG_COORDS(5)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation, i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 _node_2196_var = tex2D(_node_2196,TRANSFORM_TEX(i.uv0, _node_2196));
                float3 diffuseColor = (2.3*_node_2196_var.rgb);
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
