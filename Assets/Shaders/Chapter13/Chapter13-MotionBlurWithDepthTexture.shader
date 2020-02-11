Shader "UnityTest/Chapter13/MotionBlurWithDepthTexture"
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
		_BlurSize ("Blur Size", Float) = 1.0
    }
    SubShader
    {
        CGINCLUDE

        #include "UnityCG.cginc"
		
		sampler2D _MainTex;
		half4 _MainTex_TexelSize;
		sampler2D _CameraDepthTexture;
		float4x4 _CurrViewProjInv;
		float4x4 _PreviousViewProj;
		half _BlurSize;

        struct v2f 
        {
            float4 pos : SV_POSITION;
            half2 uv : TEXCOORD0;
            half2 uv_depth : TEXCOORD1;  
        };

        v2f vert(appdata_img v)
        {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);

            o.uv = v.texcoord;
            o.uv_depth = v.texcoord;

            #if UNITY_UV_STARTS_AT_TOP
            if (_MainTex_TexelSize.y < 0)
                o.uv_depth.y = 1 - o.uv_depth.y;
            #endif
            return o;
        }

        fixed4 frag(v2f i) : SV_TARGET
        {
            float d = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, i.uv_depth);
            float4 H = float4(i.uv.x * 2 - 1, i.uv.y * 2 - 1, d * 2 - 1, 1);
            float4 D = mul(_CurrViewProjInv, H);
            float4 worldPos = D / D.w;

            float4 prevPos = mul(_PreviousViewProj, worldPos);
            prevPos /= prevPos.w;

            float2 velocity = (H.xy - prevPos.xy) / 2.0f;

            float2 uv = i.uv;
            float4 c = tex2D(_MainTex, uv);
            uv += velocity * _BlurSize;

            for (int it = 1; it < 3; it++, uv += velocity * _BlurSize)
            {
                c += tex2D(_MainTex, uv);
            }

            c /= 3;

            return fixed4(c.rgb, 1.0);
        }

        ENDCG

        Pass
        {
            ZTest Always
            Cull Off
            ZWrite Off

            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            
            ENDCG
        }
    }
}
