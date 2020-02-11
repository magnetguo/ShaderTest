// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:0,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.371702,fgcg:0.6246458,fgcb:0.9191176,fgca:1,fgde:0.02,fgrn:20,fgrf:35,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:33320,y:32675,varname:node_9361,prsc:2|emission-5714-OUT;n:type:ShaderForge.SFN_Fresnel,id:5223,x:31687,y:33090,varname:node_5223,prsc:2|EXP-6661-OUT;n:type:ShaderForge.SFN_Multiply,id:1205,x:32001,y:32977,varname:node_1205,prsc:2|A-6943-RGB,B-5223-OUT,C-7985-OUT,D-142-RGB,E-9811-OUT;n:type:ShaderForge.SFN_Tex2d,id:142,x:31483,y:32900,ptovrint:False,ptlb:diffuse,ptin:_diffuse,varname:_diffuse,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6ff6869c91012714e9e045835d3a53e9,ntxv:2,isnm:False|UVIN-5264-OUT;n:type:ShaderForge.SFN_Color,id:6943,x:31458,y:32652,ptovrint:False,ptlb:diffuse_color,ptin:_diffuse_color,varname:_diffuse_color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Slider,id:7985,x:31582,y:33337,ptovrint:False,ptlb:emmision_range,ptin:_emmision_range,varname:_emmision_range,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_TexCoord,id:1487,x:31188,y:32841,varname:node_1487,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Add,id:5264,x:31266,y:33014,varname:node_5264,prsc:2|A-1487-UVOUT,B-8608-OUT;n:type:ShaderForge.SFN_ValueProperty,id:5806,x:30659,y:32780,ptovrint:False,ptlb:speed_u,ptin:_speed_u,varname:_speed_u,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_ValueProperty,id:7272,x:30675,y:33143,ptovrint:False,ptlb:speed_v,ptin:_speed_v,varname:_speed_v,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Multiply,id:2050,x:30864,y:32861,varname:node_2050,prsc:2|A-5806-OUT,B-189-TSL;n:type:ShaderForge.SFN_Multiply,id:6048,x:30864,y:33030,varname:node_6048,prsc:2|A-189-TSL,B-7272-OUT;n:type:ShaderForge.SFN_Time,id:189,x:30604,y:32949,varname:node_189,prsc:2;n:type:ShaderForge.SFN_Append,id:8608,x:31049,y:32956,varname:node_8608,prsc:2|A-2050-OUT,B-6048-OUT;n:type:ShaderForge.SFN_Slider,id:6661,x:31368,y:33210,ptovrint:False,ptlb:fres_power,ptin:_fres_power,varname:_fres_power,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:5494,x:30868,y:33434,varname:node_5494,prsc:2|A-189-TSL,B-8783-OUT;n:type:ShaderForge.SFN_Slider,id:8783,x:30508,y:33548,ptovrint:False,ptlb:shinning_speed,ptin:_shinning_speed,varname:_shinning_speed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:200;n:type:ShaderForge.SFN_Cos,id:8789,x:31084,y:33470,varname:node_8789,prsc:2|IN-5494-OUT;n:type:ShaderForge.SFN_Abs,id:9811,x:31303,y:33504,varname:node_9811,prsc:2|IN-8789-OUT;n:type:ShaderForge.SFN_Lerp,id:2038,x:32062,y:33262,varname:node_2038,prsc:2|A-6999-RGB,B-1205-OUT,T-5223-OUT;n:type:ShaderForge.SFN_Color,id:6999,x:31812,y:33479,ptovrint:False,ptlb:zhongxin_color,ptin:_zhongxin_color,varname:_zhongxin_color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Tex2d,id:48,x:31851,y:32127,ptovrint:False,ptlb:flash,ptin:_flash,varname:_flash,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a5748992f45b38f4db9f292d68b65c0d,ntxv:0,isnm:False|UVIN-204-OUT;n:type:ShaderForge.SFN_NormalVector,id:6645,x:30969,y:32028,prsc:2,pt:False;n:type:ShaderForge.SFN_Transform,id:2870,x:31168,y:32028,varname:node_2870,prsc:2,tffrom:0,tfto:3|IN-6645-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2807,x:31344,y:32028,varname:node_2807,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-2870-XYZ;n:type:ShaderForge.SFN_RemapRange,id:2434,x:31530,y:32028,varname:node_2434,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-2807-OUT;n:type:ShaderForge.SFN_Add,id:5714,x:33071,y:32763,varname:node_5714,prsc:2|A-5504-OUT,B-2038-OUT;n:type:ShaderForge.SFN_Add,id:6195,x:31582,y:31797,varname:node_6195,prsc:2|A-9856-OUT,B-2222-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:2222,x:31416,y:31858,varname:node_2222,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_ValueProperty,id:5464,x:30676,y:31647,ptovrint:False,ptlb:u_copy,ptin:_u_copy,varname:_u_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0;n:type:ShaderForge.SFN_Append,id:9856,x:30965,y:31753,varname:node_9856,prsc:2|A-5464-OUT,B-7143-OUT;n:type:ShaderForge.SFN_Add,id:204,x:31720,y:31955,varname:node_204,prsc:2|A-6195-OUT,B-2434-OUT;n:type:ShaderForge.SFN_Slider,id:3735,x:31143,y:31536,ptovrint:False,ptlb:flash_range,ptin:_flash_range,varname:_flash_range,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Sin,id:5620,x:31837,y:31674,varname:node_5620,prsc:2|IN-2789-OUT;n:type:ShaderForge.SFN_Multiply,id:5504,x:32317,y:31921,varname:node_5504,prsc:2|A-5620-OUT,B-8953-OUT,C-8384-OUT,D-176-RGB;n:type:ShaderForge.SFN_Slider,id:8384,x:31904,y:31964,ptovrint:False,ptlb:flash_emmission,ptin:_flash_emmission,varname:_flash_emmission,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:10;n:type:ShaderForge.SFN_Color,id:176,x:32235,y:32409,ptovrint:False,ptlb:flashi_color,ptin:_flashi_color,varname:_flashi_color,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:2789,x:31582,y:31649,varname:node_2789,prsc:2|A-3735-OUT,B-4832-OUT;n:type:ShaderForge.SFN_Vector1,id:4832,x:31379,y:31693,varname:node_4832,prsc:2,v1:3.16;n:type:ShaderForge.SFN_Multiply,id:1995,x:31486,y:31358,varname:node_1995,prsc:2|A-4040-OUT,B-3735-OUT;n:type:ShaderForge.SFN_Vector1,id:4040,x:31280,y:31391,varname:node_4040,prsc:2,v1:5.2;n:type:ShaderForge.SFN_Subtract,id:7143,x:31703,y:31380,varname:node_7143,prsc:2|A-1995-OUT,B-2686-OUT;n:type:ShaderForge.SFN_Vector1,id:2686,x:31530,y:31523,varname:node_2686,prsc:2,v1:1.5;n:type:ShaderForge.SFN_Power,id:1290,x:31932,y:32373,varname:node_1290,prsc:2|VAL-48-RGB,EXP-614-OUT;n:type:ShaderForge.SFN_ValueProperty,id:614,x:31732,y:32420,ptovrint:False,ptlb:flash_power,ptin:_flash_power,varname:_flash_power,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Clamp01,id:8953,x:32095,y:32297,varname:node_8953,prsc:2|IN-1290-OUT;proporder:142-6943-7985-5806-7272-6661-8783-6999-48-5464-3735-8384-176-614;pass:END;sub:END;*/

Shader "Valkyrie/fresnel_buff" {
    Properties {
        _diffuse ("diffuse", 2D) = "black" {}
        _diffuse_color ("diffuse_color", Color) = (0.5,0.5,0.5,1)
        _emmision_range ("emmision_range", Range(0, 10)) = 1
        _speed_u ("speed_u", Float ) = 0
        _speed_v ("speed_v", Float ) = 0
        _fres_power ("fres_power", Range(0, 10)) = 1
        _shinning_speed ("shinning_speed", Range(0, 200)) = 0
        _zhongxin_color ("zhongxin_color", Color) = (0,0,0,1)
        _flash ("flash", 2D) = "white" {}
        _u_copy ("u_copy", Float ) = 0
        _flash_range ("flash_range", Range(0, 1)) = 0
        _flash_emmission ("flash_emmission", Range(0, 10)) = 0
        _flashi_color ("flashi_color", Color) = (0.5,0.5,0.5,1)
        _flash_power ("flash_power", Float ) = 1
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
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x 
            #pragma target 3.0
            uniform sampler2D _diffuse; uniform float4 _diffuse_ST;
            uniform float4 _diffuse_color;
            uniform float _emmision_range;
            uniform float _speed_u;
            uniform float _speed_v;
            uniform float _fres_power;
            uniform float _shinning_speed;
            uniform float4 _zhongxin_color;
            uniform sampler2D _flash; uniform float4 _flash_ST;
            uniform float _u_copy;
            uniform float _flash_range;
            uniform float _flash_emmission;
            uniform float4 _flashi_color;
            uniform float _flash_power;
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
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float2 node_204 = ((float2(_u_copy,((5.2*_flash_range)-1.5))+i.uv0)+(mul( UNITY_MATRIX_V, float4(i.normalDir,0) ).xyz.rgb.rg*2.0+-1.0));
                float4 _flash_var = tex2D(_flash,TRANSFORM_TEX(node_204, _flash));
                float node_5223 = pow(1.0-max(0,dot(normalDirection, viewDirection)),_fres_power);
                float4 node_189 = _Time;
                float2 node_5264 = (i.uv0+float2((_speed_u*node_189.r),(node_189.r*_speed_v)));
                float4 _diffuse_var = tex2D(_diffuse,TRANSFORM_TEX(node_5264, _diffuse));
                float3 emissive = ((sin((_flash_range*3.16))*saturate(pow(_flash_var.rgb,_flash_power))*_flash_emmission*_flashi_color.rgb)+lerp(_zhongxin_color.rgb,(_diffuse_color.rgb*node_5223*_emmision_range*_diffuse_var.rgb*abs(cos((node_189.r*_shinning_speed)))),node_5223));
                float3 finalColor = emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
