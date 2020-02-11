﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: commented out 'half4 unity_LightmapST', a built-in variable

Shader "ReplaceLightmap/ReplaceDiffuse"
 {
	Properties 
	{
		_Color("Main Color", Color) = (1.0,1.0,1.0,1.0)
		_MainTex("Base (RGB)", 2D) = "white" {}
	    _LightmapTex("Lightmap (RGBA)", 2D) = "white" {}
		[Toggle]_ChangeToGray("ChangeToGray", float) = 0
		_ChangeToGrayValue("ChangeToGrayValue", Range(0,5)) = 1
	}
    CGINCLUDE
    #include "UnityCG.cginc"

	uniform sampler2D _MainTex;
	uniform sampler2D _LightmapTex;

	// uniform half4 unity_LightmapST;
	uniform half4 _MainTex_ST;

	uniform fixed4 _Color;
	
	uniform fixed _ChangeToGray;
	uniform fixed _ChangeToGrayValue;
	
	struct VS_OUTPUT
    {
         float4 Position : SV_POSITION;
		 half2 vTexcoord0 : TEXCOORD0;
		 half2 vTexcoord1 : TEXCOORD1;
    };
            
    VS_OUTPUT MainVS(appdata_full input)
    {
          VS_OUTPUT output = (VS_OUTPUT)0;
                
          output.Position = UnityObjectToClipPos(input.vertex);
          output.vTexcoord0 = TRANSFORM_TEX(input.texcoord, _MainTex);
		  output.vTexcoord1 = input.texcoord1 * unity_LightmapST.xy + unity_LightmapST.zw;

          return output;
     }

	//LogLuv to FP32(RGB)
	fixed3 DecodeLogLuv(in fixed4 vLogLuv)
	{
		fixed3x3 InverseM = fixed3x3(
			6.0014, -2.7008, -1.7996,
			-1.3320, 3.1029, -5.7721,
			0.3008, -1.0882, 5.6268);

		fixed Le = vLogLuv.z * 255 + vLogLuv.w;
		fixed3 Xp_Y_XYZp;
		Xp_Y_XYZp.y = exp2((Le - 127) / 2);
		Xp_Y_XYZp.z = Xp_Y_XYZp.y / vLogLuv.y;
		Xp_Y_XYZp.x = vLogLuv.x * Xp_Y_XYZp.z;
		fixed3 vRGB = mul(Xp_Y_XYZp, InverseM);
		return max(vRGB, 0);
	}

     fixed4 MainPS(VS_OUTPUT input) : COLOR
     {
		  fixed4 baseColor = tex2D(_MainTex, input.vTexcoord0) * _Color;
	      fixed4 lightmapColor = tex2D(_LightmapTex, input.vTexcoord1);
          fixed4 decodeLightmapColor = fixed4(DecodeLogLuv(lightmapColor),1.0);
		  fixed4 ret = baseColor * decodeLightmapColor;
		  if(_ChangeToGray != 0)
		  {
			  ret.r = ret.b;
			  ret.g = ret.b;
			  ret *= _ChangeToGrayValue;
		  }
		  return  ret;
     }
     
    ENDCG
    SubShader 
	{
        Tags{ "RenderType" = "Opaque"}

		Pass
		{
        	Name "ReplaceDiffuse"
			//Lighting off
			//Fog { Mode off }
			CGPROGRAM

            #pragma vertex MainVS
            #pragma fragment MainPS
            #pragma target 3.0
           
            ENDCG
		}
    }
}
