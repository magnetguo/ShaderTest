Shader "UnityTest/Chapter5/FalseColor"
{
    SubShader
    {
        pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct v2f
            {
                float4 pos : SV_POSITION;
                fixed4 color : COLOR0;
            };

            v2f vert(appdata_full v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);

                // visualize normal
                o.color = fixed4(v.normal * 0.5 + fixed3(0.5, 0.5, 0.5), 1.0);

                // other visualizations
                // ...
                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                return i.color;
            }
            ENDCG
        }
    }
}
