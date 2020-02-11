Shader "Valkyrie/ImageEffect/ScreenAdd" 
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "" {}
		_MainColor("Color", 2D) = "grey" {}
	}

	CGINCLUDE
	#include "UnityCG.cginc"
	struct v2f 
	{
		float4 pos : POSITION;
		float2 uv : TEXCOORD0;
	};

	half4 _MainColor;
	sampler2D _MainTex;

	half _Duration;
	half _Intensity;

	v2f vert(appdata_img v) 
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);
		o.uv = v.texcoord;
		return o;
	}

	half4 fragFireSky(v2f i) : COLOR
	{
		float4 add = _MainColor;
		float4 main = tex2D(_MainTex, i.uv);
		main.rgb = dot(main.rgb, float3(0.3, 0.59, 0.11))* _Intensity;
		half m = step(add.rgb, 0.5);
		float4 emissive = m * (1.0 - (1.0 - 2.0*(add - 0.5))*(1.0 - main));
		emissive += (1 - m)*(2.0*add*main);
		
		float offset = (1 - i.uv.y) * 0.4;// / 2 * 7 / 6 * 3 / 4 * 0.9 = 0.39375
		float4 finalColor = saturate(offset / (1.0 - offset));
		finalColor = emissive / (1 - finalColor) * (finalColor + 0.5);
		return fixed4(finalColor.rgb, 1);
	}
	half4 fragExposure(v2f i) : COLOR
	{
		return 0.5 + tex2D(_MainTex, i.uv);
	}
	half4 fragNegate(v2f i) : COLOR
	{
		return 0.5 - tex2D(_MainTex, i.uv);
	}

	half4 fragNegateToFireSky(v2f i) : COLOR
	{
		half4 fire = fragFireSky(i);
		half4 negate = fragNegate(i);
		return lerp(negate, fire, _Duration);
	}

	half4 fragFireSkyToNormal(v2f i) : COLOR
	{
		half4 fire = fragFireSky(i);
		half4 normal = tex2D(_MainTex, i.uv);
		return lerp(fire, normal, _Duration);
	}
	half4 fragDark(v2f i) : COLOR
	{
		fixed4 c = tex2D(_MainTex, i.uv);
		return lerp(c, _MainColor*c, _Duration);
	}
		
	ENDCG

	Subshader 
	{
		ZTest Always 
		Cull Off 
		ZWrite Off
		Fog{ Mode off }
		ColorMask RGB

		Pass
		{
			CGPROGRAM
			//#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment fragFireSky
			ENDCG
		}
		Pass
		{
			CGPROGRAM
			//#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment fragExposure
			ENDCG
		}
		Pass
		{
			CGPROGRAM
			//#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment fragNegate
			ENDCG
		}
		Pass
		{
			CGPROGRAM
			//#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment fragNegateToFireSky
			ENDCG
		}
		Pass
		{
			CGPROGRAM
			//#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment fragFireSkyToNormal
			ENDCG
		}
		Pass
		{
			CGPROGRAM
			//#pragma fragmentoption ARB_precision_hint_fastest
			#pragma vertex vert
			#pragma fragment fragDark
			ENDCG
		}
	}
	Fallback off
} // shader