Shader "Shader Forge/zuanshi_faxian" {
    Properties {
        _Matcap ("Matcap", 2D) = "white" {}
        _TEX ("TEX", 2D) = "white" {}
        _OutlineW ("OutlineW", Float ) = 0
        _Outlinecolor ("Outlinecolor", Color) = (0.5,0.5,0.5,1)
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
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
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
            half4 frag(VertexOutput i) : COLOR {
                return fixed4(_Outlinecolor.rgb,1);
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
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
            #pragma target 3.0
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            uniform sampler2D _TEX; uniform float4 _TEX_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
		fixed4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                fixed4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            half4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
     
                half2 uv = mul( UNITY_MATRIX_V, float4(i.normalDir,0) ) .rg*0.5+0.5;
                half4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(uv, _Matcap));
                half4 _TEX_var = tex2D(_TEX,TRANSFORM_TEX(i.uv0, _TEX));
                half3 finalColor = saturate((_Matcap_var.rgb > 0.5 ?  (1.0-(1.0-2.0*(_Matcap_var.rgb-0.5))*(1.0-_TEX_var.rgb)) : (2.0*_Matcap_var.rgb*_TEX_var.rgb)) );
                return half4(finalColor,i.vertexColor.a);                
            }
            ENDCG
        }
    }
 
}
