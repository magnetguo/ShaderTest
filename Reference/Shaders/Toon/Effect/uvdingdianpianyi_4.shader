 
Shader "Shader Forge/uvdingdianpianyi_4" {
    Properties {
        _qd ("qd", Float ) = 0.02
        _fw ("fw", Float ) = 5
        [HDR]_uvcolor ("uvcolor", Color) = (0.5,0.5,0.5,1)
        _pos ("pos", Float ) = 0
        _speed ("speed", Float ) = 0.1
        _textrues ("textrues", 2D) = "white" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
       
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            //#pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _qd;
            uniform float _fw;
            uniform float4 _uvcolor;
            uniform float _pos;
            uniform float _speed;
            uniform sampler2D _textrues; uniform float4 _textrues_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                half2 texcoord0 : TEXCOORD0;
                half2 texcoord2 : TEXCOORD2;
                half4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                half2 uv0 : TEXCOORD0;
                half2 uv2 : TEXCOORD1;
                // float3 normalDir : TEXCOORD2;
                half4 vertexColor : COLOR;
                UNITY_FOG_COORDS(3)
            };

            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                // o.normalDir = UnityObjectToWorldNormal(v.normal);
                // float4 node_4398 = _Time;
                float node_7822 = abs((frac((o.uv2+(_Time.g*_speed)*float2(0.15,0)).r)-0.5));
                float node_7213 = pow((node_7822*2.0),_fw);
                float3 node_9156 = (node_7213*_qd*v.normal);
                v.vertex.xyz += ((o.vertexColor.rgb.r*(node_7213*_qd*(1.0 - v.normal)) + o.vertexColor.rgb.g*node_9156 + o.vertexColor.rgb.b*node_9156)+(node_7822*_pos));
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }

            half4 frag(VertexOutput i) : COLOR { 
                float node_7822 = abs((frac((i.uv2+(_Time.g*_speed)*float2(0.15,0)).r)-0.5));
                float node_7213 = pow((node_7822*2.0),_fw);
                float3 emissive = (_uvcolor.rgb*node_7213*5.0);
                half4 _textrues_var = tex2D(_textrues,TRANSFORM_TEX(i.uv0, _textrues));
                half3 finalColor = emissive + _textrues_var.rgb;
                half4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        
    }
  
}
