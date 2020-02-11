// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

// Unlit shader. Simplest possible textured shader.
// - no lighting
// - no lightmap support
// - no per-material color

Shader "Valkyrie/Toon/Scene/UnLit-TextureWithLightMap" {
Properties {
	_Color("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
	_LightTex("Light (RGB)", 2D) = "white" {}
	_WeatherColor("Weather Color",Color) = (1,1,1,1)
}

SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 100

    Pass {
        CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
			#include "Assets/LoadableResources/Shaders/Toon/Variables/Variables.cginc"

            struct appdata_t {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 texcoord : TEXCOORD0;
				float2 texcoord1 : TEXCOORD1;
                UNITY_FOG_COORDS(2)
                UNITY_VERTEX_OUTPUT_STEREO
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
			sampler2D _LightTex;
			float4 _LightTex_ST;
			fixed4 _Color;
			fixed4 _WeatherColor;

            v2f vert (appdata_t v)
            {
                v2f o;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.texcoord1 = TRANSFORM_TEX(v.texcoord1, _LightTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.texcoord);
				fixed4 col1 = tex2D(_LightTex, i.texcoord1);
				//col = 1 - 2 * ((1 - col)*(1 - col1));	
				col *= col1;				
				col *= _Color*2;
				APPLY_WEATHER(col.rgb,_WeatherColor);
                UNITY_APPLY_FOG(i.fogCoord, col);
                UNITY_OPAQUE_ALPHA(col.a);
				//return fixed4(1, 1, 1, 1);
                return col;
            }
        ENDCG
    }
}

}
