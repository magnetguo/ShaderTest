Shader "Effect/Distort2"
{
    Properties
    {
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_MaskTex("Mask (R)", 2D) = "white" {} //可以考虑把_MaskTex和_NoiseTex合并
        _NoiseTex ("Noise (R)", 2D) = "white" {}
        _distortFactorTime("FactorTime",Range(0,0.4)) = 0.1
        _distortFactor("factor",Range(0.04,1)) = 0.04
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 100
        Cull Back
		Lighting Off 
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
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
                float4 vertex : SV_POSITION;
				half4 uv : TEXCOORD0; //uv.xy : MainTex; uv.zw : Noise and Mask Tex
				UNITY_FOG_COORDS(1)
            };
			sampler2D _MainTex;
			half4 _MainTex_ST;

			sampler2D _MaskTex;
            sampler2D _NoiseTex;
			half4 _NoiseTex_ST;

            fixed _distortFactorTime;
            fixed _distortFactor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv.xy = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv.zw = TRANSFORM_TEX(v.uv, _NoiseTex);
				UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {				
				fixed4 maskTexCol = tex2D(_MaskTex, i.uv.zw);
				i.uv.zw += _Time.xy *_distortFactorTime;
                fixed4 noiseTexCol = tex2D(_NoiseTex, i.uv.zw);
				i.uv.xy += (noiseTexCol.r - 0.5) * _distortFactor *maskTexCol.r;
				fixed4 mainTexCol = tex2D(_MainTex, i.uv.xy);
				UNITY_APPLY_FOG(i.fogCoord, mainTexCol);
                return mainTexCol;
            }
            ENDCG
        }
    }
}