Shader "Effect/Distort"
{
    Properties
    {
		_Texture("_Texture", 2D) = "white" {}
        _Noise ("Noise", 2D) = "white" {}
        _distortFactorTime("FactorTime",Range(0,5)) = 0.5
        _distortFactor("factor",Range(0.04,1)) = 0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
        LOD 100
        Cull Off Lighting Off ZWrite Off
         GrabPass
        {
            "_BackgroundTexture"
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                half2 uv : TEXCOORD0;

            };

            struct v2f
            {
                half2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                half4 grabPos:TEXCOORD1;
            };
			sampler2D _Texture;
            sampler2D _Noise;
            half4 _Noise_ST;
            fixed _distortFactorTime;
            fixed _distortFactor;
            sampler2D _BackgroundTexture;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _Noise);
                o.grabPos = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
				fixed4 main = tex2D(_Texture, i.uv);
                fixed4 col = tex2D(_Noise, i.uv+=_Time.xy*_distortFactorTime);
				
				i.grabPos.xy += col.xy * _distortFactor * main;
                half4 bgcolor = tex2Dproj(_BackgroundTexture, i.grabPos);
                return bgcolor ;
            }
            ENDCG
        }
    }
}