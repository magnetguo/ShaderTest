//角色卡通渲染 基本（不透明）
Shader "Valkyrie/Toon/Char/Basic"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_ColorParam("Main ColorParam", Color) = (1,1,1,1)
		[HDR]_Emission("Emission", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}

		_MaskTex("Mask", 2D) = "black" {}
		_LightMaskTex("LightMask", 2D) = "black" {}
		_LightMaskParam("_LightMaskParam", Range(0.0,1.0)) = 0.7
		_LightMaskBackParam("_LightMaskBackParam", Range(0.0,1.0)) = 0.7
		_RampTex("Ramp", 2D) = "white"{}
		_RampColor("Ramp Color", Color) = (1,1,1,1)

		_HighLight("HighLight",range(0,1)) = 0.9		// 高光范围
		_HighLightColor("HighLight Color", Color) = (1,1,1,1)
		_HighLightStrength("HighLightStrength", range(0,1000)) = 5

		_BrightnessFactor("MinBrightness", range(0, 1)) = 0

		_LightInfo("LightInfo", Vector) = (0.9, -1, 0.5, 0.005)
		_LightColor("LightColor",color) = (1,1,1,1)
		
		_BrightnessRatio("Brightness Ratio", range(0,10)) = 0
		_BrightnessIncrease("Brightness Increase", range(0,10)) = 4
		
		// UV动画/流光 + 闪烁(Shining) 闪光(Flash)
		_UVAniNoiseTex ("UVAni Noise Tex", 2D) = "black" {}
		_UVAniNoiseColor ("UVAni Noise Color", Color) = (0.5,0.5,0.5,1)
		_UVAniNoiseIntensity ("UVAni Noise Intensity", Range(0, 10)) = 1 //强度
		_USpeed ("U Speed", Float ) = 0
		_VSpeed ("V Speed", Float ) = 0
		_FresnelPower ("Fresnel Power", Range(0, 10)) = 1
		_ShiningSpeed ("Shining Speed", Range(0, 200)) = 0 //闪烁速度
		_CenterColor ("Center Color", Color) = (0,0,0,1) // 法线与视线一致的颜色，与边缘光颜色过渡
		_FlashTex("FlashTex", 2D) = "black" {}
		_FlashRange ("Flash Range", Range(0, 1)) = 0
		_FlashIntensity ("Flash Intensity", Range(0, 10)) = 0 //强度
		_FlashColor ("Flash Color", Color) = (0.5,0.5,0.5,1)

		_ShadowTex("Shadow (RGB) Trans (A)", 2D) = "white" {}
		_DirX("DirX", Range(0,5)) = 0.5
		_DirY("DirY", Range(0,5)) = 0.5
		_Speed("Speed", Range(-1,1)) = 0.1
		_ShadowAlphaRatio("ShadowAlphaRatio", Range(0.5,1.5)) = 1

		_Transparency("Transparency", range(0,1)) = 1
		[Toggle]_NewRamp("NewRamp", Range(0,1)) = 0

		[Toggle]_IsColoration("Is Coloration", Range(0,1)) = 0
		_Coloration("Coloration Color", color) = (1.1,1,1)

		_DissolveTex("DissolveTex", 2D) = "white" {}
		_DissolveFactor("DissolveFactor",Range(0, 1)) = 0
		_DissolveMin("DissolveMin",Range(-100, 100)) = -100
		_DissolveMax("DissolveMax",Range(-100, 100)) = 100

		_AddExposure("Add Exposure",Range(0,1)) = 0
	}
	SubShader
	{
		Tags
		{
			"IgnoreProjector" = "true"
			"RenderType"="Opaque"
			"Queue"="Geometry"
		}
		
		pass
		{
			Name "CHAR_BASIC"
			Tags{ "LightMode" = "ForwardBase" }
			Lighting Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex BasicVert
			#pragma fragment BasicFrag
			#include "UnityCG.cginc"
			#include "Toon.cginc"

			#pragma target 3.0 
			#pragma multi_compile __ SHADOW_SWITCH
			#pragma multi_compile __ FLASH_SWITCH
			

			ENDCG
		}
	}
	CustomEditor "Valkyrie.BasicShaderGUI"
}