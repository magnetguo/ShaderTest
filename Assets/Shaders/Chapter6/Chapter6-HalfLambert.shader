﻿Shader "UnityTest/Chapter6/DiffusePixelLevel"
{
    Properties
    {
        _Diffuse("Diffuse Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        pass
        {
            Tags
            {
                "LightMode" = "ForwardBase"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Lighting.cginc"

            fixed4 _Diffuse;

            struct a2v
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldNormal : TEXCOORD0;
            };

            v2f vert(a2v v)
            {
                v2f o;

                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);

                return o;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

                fixed3 worldNormal = normalize(i.worldNormal);

                fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

                fixed halfLambert = dot(worldNormal, worldLightDir) * 0.5 + 0.5;

                fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;

                return fixed4(ambient + diffuse, 1.0);
            }

            ENDCG
        }
    }

    Fallback "Diffuse"
}
