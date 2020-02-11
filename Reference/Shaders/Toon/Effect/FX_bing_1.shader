 
Shader "Shader Forge/FX_bing_1" {
    Properties {
        _Matcap ("Matcap", 2D) = "white" {}
        _textrue ("textrue", 2D) = "white" {}
        _qd ("qd", Float ) = 12
        [HDR]_color ("color", Color) = (1,1,1,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
          
			 Blend SrcAlpha OneMinusSrcAlpha
            ZWrite On
            
            AlphaToMask On
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
            #pragma target 3.0
            uniform sampler2D _Matcap; uniform half4 _Matcap_ST;
            uniform sampler2D _textrue; uniform half4 _textrue_ST;
            uniform half4 _color;
            uniform half _qd;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
				 half4 vertexColor : COLOR;
                half2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                float3 viewDir : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
				  half4 vertexColor : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
				    o.vertexColor = v.vertexColor;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            half4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                // float3 viewDirection = i.viewDir;
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                half node_2707 = pow(1.0-max(0,dot(normalDirection, i.viewDir)),_qd);
                half3 emissive = half3(node_2707,node_2707,node_2707);
                half2 node_9314 = (mul( UNITY_MATRIX_V, half4(i.normalDir,0) ).xyz.rgb.rg*0.5+0.5);
                half4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9314, _Matcap));
                half4 _textrue_var = tex2D(_textrue,TRANSFORM_TEX(i.uv0, _textrue));
                half3 finalColor = emissive + (_color.rgb*saturate(( _textrue_var.rgb > 0.5 ? (1.0-(1.0-2.0*(_textrue_var.rgb-0.5))*(1.0-_Matcap_var.rgb)) : (2.0*_textrue_var.rgb*_Matcap_var.rgb) )));
                return fixed4(finalColor,i.vertexColor.a*_color.a);
            }
            ENDCG
        }
    }
 
}
