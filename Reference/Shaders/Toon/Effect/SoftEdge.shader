// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/SoftEdge"
{
    Properties
    {
        _RimColor("RimColor", Color) = (0, 0, 1, 1)
        _RimIntensity("Intensity", Range(0, 2)) = 1
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent" }

        LOD 200
        Pass
        {
            Blend SrcAlpha One
            ZWrite off
            Lighting off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                fixed4 color:COLOR;
            };

            fixed4 _RimColor;
            float _RimIntensity;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                float3 viewDir = normalize(ObjSpaceViewDir(v.vertex));
                float val = 1 - saturate(dot(v.normal, viewDir));
                o.color = _RimColor * val * (1 + _RimIntensity);
                return o;
            }

            fixed4 frag (v2f i) : COLOR
            {
                return i.color;
            }
            ENDCG
        }
    }
}