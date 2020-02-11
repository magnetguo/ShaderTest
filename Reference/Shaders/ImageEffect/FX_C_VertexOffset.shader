Shader "Shader Forge/FX_C_VertexOffset" {
    Properties {
        _MainTex ("MainTex", 2D) = "white" {}
        _Strength ("_Strength", Range(0.1,10)) = 1
        _Offset ("_Offset", Vector) = (0,0,0)
    }
    SubShader {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" }
	    Blend SrcAlpha OneMinusSrcAlpha
	    ColorMask RGB
        Lighting Off 
        ZWrite Off

        Pass 
        {
            Name "FORWARD"
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
           
            fixed _Strength;
            fixed4 _Offset;
            struct VertexInput 
            {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };
            struct VertexOutput 
            {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) 
            {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.uv0;
                float4 posWorld = mul(unity_ObjectToWorld, v.vertex);
                fixed random = posWorld.y * posWorld.z;
                random = random + _Time.y * _Strength;
                v.vertex.xyz += _Offset.xyz * v.uv1.y * sin(random);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR 
            {
                return tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
