// UV动画 自发光
Shader "Valkyrie/Toon/Effect/UVAniEmi" 
{
    Properties 
    {
        _MainTex ("Main Tex", 2D) = "white" {}
        _MaskTex ("Mask Tex", 2D) = "white" {}
        _MainColor ("Main Color", Color) = (0.5,0.5,0.5,1)
        _USpeed ("U Speed", Float ) = 0
        _VSpeed ("V Speed", Float ) = 0
        _EmiIntensity ("Emissive Intensity", Range(0, 10)) = 1
    }
    SubShader 
    {
        Tags 
        {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }

        Pass 
        {
            Name "EFFECT_UVANIEMI"

            Blend One One
            Cull Off
            ZWrite Off
            
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"
                #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal            
                #pragma target 3.0            

                struct VertexInput 
                {
                    float4 vertex : POSITION;
                    float2 texcoord0 : TEXCOORD0;
                    fixed4 vertexColor : COLOR;
                };
                struct VertexOutput 
                {
                    float4 pos : SV_POSITION;
                    float2 uv : TEXCOORD0;
                    fixed4 vertexColor : COLOR;
                };
                VertexOutput vert (VertexInput v) 
                {
                    VertexOutput o = (VertexOutput)0;
                    o.uv = v.texcoord0;
                    o.vertexColor = v.vertexColor;
                    o.pos = UnityObjectToClipPos(v.vertex);
                    return o;
                }

                sampler2D _MainTex; 
                half4 _MainTex_ST;
                sampler2D _MaskTex; 
                half4 _MaskTex_ST;
                fixed4 _MainColor;
                half _USpeed;
                half _VSpeed;
                half _EmiIntensity;

                half4 frag(VertexOutput i):COLOR
                {
                    float2 uvOffset = i.uv + float2(_USpeed, _VSpeed) * _Time.x;
                    fixed4 mainTexColor = tex2D(_MainTex,TRANSFORM_TEX(uvOffset, _MainTex)) *_MainColor * i.vertexColor;
                    fixed3 maskTexColor = tex2D(_MaskTex,TRANSFORM_TEX(i.uv, _MaskTex)).rgb;
                    return half4(mainTexColor * maskTexColor * _EmiIntensity,mainTexColor.a);
                }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
