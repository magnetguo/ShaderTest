Shader "Valkyrie/Toon/Scene/AlphaTestWithShineReflect"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
		_AddTex("Shine (RGB) Trans (A)", 2D) = "white" {}
		_AddAlphaRatio("Shine Alpha Ratio", Range(0,1)) = 0
		_AddFlashSpeed("Shine Flash Speed", Range(0,5)) = 0
		//镜面反射 平面反射 倒影
		_ReflectionTex("Reflection Tex",2D) = "white" {}
		_ReflectionColor("Reflection Color", Color) = (1,1,1,1)
		_ReflectionIntensity("Reflection Intensity",Range(0.1,10)) = 1
		_LightmapLuminanceThreshold("Lightmap Luminance Threshold",Range(0.001,2)) = 1
		_RefectionBlendFactor("Reflection Blend Factor",Range(0,1)) = 0.7
	}
	SubShader
	{
		Tags{ "Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" }
		Lighting Off
		Pass {
			Tags {
                "LightMode"="ForwardBase"
            } 
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "Scene.cginc"

			#pragma multi_compile_fwdbase noshadow
			#pragma multi_compile_fog
			#pragma only_renderers d3d9 d3d11 glcore gles gles3 metal vulkan
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma target 3.0

			//#pragma surface surf Lambert alphatest:_Cutoff

			struct VertexInput {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 color : COLOR;
			};
			struct VertexOutput {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0; // _MainTex
				float4 color : COLOR;
				float3 worldNormal : TEXCOORD1;
				float4 worldPos : TEXCOORD2;
				#ifdef LIGHTPROBE_SH
					half3 sh : TEXCOORD3; // SH
				#endif
				#ifdef LIGHTMAP_ON
					float4 lmap : TEXCOORD4;
				#endif
				UNITY_FOG_COORDS(5)
				float4 screenUV : TEXCOORD6;
			};
			
			float4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed _AddAlphaRatio;
			fixed _AddFlashSpeed;
			sampler2D _AddTex;

			sampler2D _ReflectionTex;
			fixed4 _ReflectionColor;
			half _ReflectionIntensity;
			half _LightmapLuminanceThreshold;
			half _RefectionBlendFactor;

			VertexOutput vert (VertexInput v) {
				VertexOutput o;
				UNITY_INITIALIZE_OUTPUT(VertexOutput,o);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.worldPos.xyz = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.worldNormal = UnityObjectToWorldNormal(v.normal);

				//--因未使用宏 DIRLIGHTMAP_COMBINED DYNAMICLIGHTMAP_ON 省略部分代码--
				
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

					// SH/ambient and vertex lights
				#ifndef LIGHTMAP_ON
					//UNITY_SAMPLE_FULL_SH_PER_PIXEL 一般为false，因为LIGHTPROBE_SH和LIGHTMAP_ON不会同时存在
					#if UNITY_SHOULD_SAMPLE_SH
						o.sh = 0;
						// Approximated illumination from non-important point lights
						// 一般情况下，应该没有实时点光源，但保守起见，还是加上了
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, o.worldPos.xyz, o.worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (o.worldNormal, o.sh);
					#endif
				#endif // !LIGHTMAP_ON

				//--因未使用宏 shadow_mask烘焙， UNITY_TRANSFER_LIGHTING 省略部分代码--

				//雾效只使用Linear
                UNITY_TRANSFER_FOG(o,o.pos);

				o.screenUV = ComputeScreenPos(o.pos);
				return o;
			}
			fixed4 frag(VertexOutput i) : SV_Target {
				//默认只有平行光作为主光源
				fixed3 lightDir = _WorldSpaceLightPos0.xyz;

				//surface自定义部分
				fixed4 mainTexColor = SurfCalaShine(_MainTex, _AddTex, _AddAlphaRatio, _AddFlashSpeed, i.uv.xy, _Time.y);
				mainTexColor.rgb *= _Color.rgb;

				half3 ambient = 0;
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					ambient = i.sh;
				#endif

				float4 lightmapUV = 0;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					lightmapUV = i.lmap;
				#endif

				fixed3 indirectDiffuse = 0;
				#if UNITY_SHOULD_SAMPLE_SH
					indirectDiffuse = ShadeSHPerPixel(i.worldNormal, ambient, i.worldPos);
				#endif

				half LightmapLuminance = 0;
				#if defined(LIGHTMAP_ON)
					// Baked lightmaps
					half4 bakedColorTex = UNITY_SAMPLE_TEX2D(unity_Lightmap, lightmapUV.xy);
					half3 bakedColor = DecodeLightmap(bakedColorTex);					
					indirectDiffuse += bakedColor;
					LightmapLuminance = Luminance(bakedColor);
				#endif

				fixed diff = max (0, dot (i.worldNormal, lightDir));

				fixed4 finalColor;
				finalColor.rgb = mainTexColor.rgb * _LightColor0.rgb * diff;				
				finalColor.rgb += mainTexColor.rgb * indirectDiffuse;				

				//平面反射
				half2 reflectUV = i.screenUV.xy / i.screenUV.w;
                half3 reflectColor = tex2D(_ReflectionTex, reflectUV).rgb * _ReflectionColor.rgb * _ReflectionIntensity;
				fixed isReflect = step(LightmapLuminance,_LightmapLuminanceThreshold); // 亮度小于阈值才会反射

				finalColor.rgb = lerp(finalColor.rgb, reflectColor, isReflect * _RefectionBlendFactor);

				finalColor.a = mainTexColor.a;
				UNITY_APPLY_FOG(i.fogCoord, finalColor);
				return finalColor;
			}
			ENDCG
		}
	}

}
