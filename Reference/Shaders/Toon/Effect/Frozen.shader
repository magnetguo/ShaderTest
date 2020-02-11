Shader "Valkyrie/Toon/Effct/Frozen"
{
    Properties
    {
		_MatcapTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
			#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x vulkan
			#pragma target 3.0
            struct appdata
            {
                float4 vertex : POSITION;
				float4 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float2 matcapUV : TEXCOORD1;
            };

			sampler2D _MatcapTex;
			float4 _MatcapTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldNormal = normalize(UnityObjectToWorldNormal(v.normal));
				o.matcapUV = (mul(UNITY_MATRIX_V, float4(normalize(worldNormal), 0)).xy * 0.5 + 0.5);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				fixed4 col = tex2D(_MatcapTex, i.matcapUV);
                return col;
            }
            ENDCG
        }
    }
}
