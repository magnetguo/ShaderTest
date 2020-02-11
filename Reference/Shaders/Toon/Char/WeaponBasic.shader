//角色卡通渲染 基本（不透明）
Shader "Valkyrie/Toon/Char/WeaponBasic"
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

		_FlashTex("FlashTex", 2D) = "black" {}
		_FlashFactor("FlashFactor", Vector) = (0, -2, 1, 1)
		_FlashMixedColor("FlashMixedColor",Color) = (0.4,0.2,0,1)
		_FlashStrength("FlashStrength", Range(0, 5)) = 1
		_FlashMixedColorAdd("FlashMixedColorAdd",Color) = (0.4,0.2,0,1)
		_FlashStrengthAdd("FlashStrengthAdd", Range(0, 5)) = 1
		_FlashSpeed("FlashSpeed", Range(0, 5)) = 0.2

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

		_Color_ren ("Color_ren", Color) = (0,0.4705882,1,1)
        _node_4533 ("node_4533", 2D) = "black" {}
        _Color_bing ("Color_bing", Color) = (1,0.2196078,0,1)
        _power_ren ("power_ren", Range(0, 10)) = 2.4
        _power_bing ("power_bing", Range(0, 10)) = 4.4
        _node_5485 ("node_5485", 2D) = "black" {}
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
			Name "WEAPON_BASIC"
			Tags{ "LightMode" = "ForwardBase" }
			Lighting Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex BasicVert
			#pragma fragment BasicFrag
			#include "UnityCG.cginc"
			#include "WeaponToon.cginc"

			#pragma target 3.0 
			#pragma multi_compile __ SHADOW_SWITCH
			#pragma multi_compile __ FLASH_SWITCH
			

			ENDCG
		}
	}
	CustomEditor "Valkyrie.WeaponBasicShaderGUI"
}