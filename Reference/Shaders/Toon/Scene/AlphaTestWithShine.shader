Shader "Valkyrie/Toon/Scene/AlphaTestWithShine"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		_MainTex("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
		_AddTex("Shine (RGB) Trans (A)", 2D) = "white" {}
		_AddAlphaRatio("Shine Alpha Ratio", Range(0,1)) = 0
		_AddFlashSpeed("Shine Flash Speed", Range(0,5)) = 0
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
			};

			// struct appdata_t
			// {
			// 	float4 vertex : POSITION;
			// 	float2 texcoord : TEXCOORD0;
			// 	float4 color : COLOR;
			// };

			// struct v2f
			// {
			// 	float4 vertex : SV_POSITION;
			// 	half2 texcoord : TEXCOORD0;
			// 	float4 color : COLOR;
			// };

			// struct Input
			// {
			// 	float2 uv_MainTex;
			// };
			
			float4 _Color;
			sampler2D _MainTex;
			float4 _MainTex_ST;

			fixed _AddAlphaRatio;
			fixed _AddFlashSpeed;
			sampler2D _AddTex;

			// void surf(Input i, inout SurfaceOutput o)
			// {
			// 	fixed4 col = SurfCalaShine(_MainTex, _AddTex, _AddAlphaRatio, _AddFlashSpeed, i.uv_MainTex, _Time.y);
			// 	o.Albedo = col.rgb * _Color;
			// 	o.Alpha = col.a;
			// }

			VertexOutput vert (VertexInput v) {
				VertexOutput o;
				UNITY_INITIALIZE_OUTPUT(VertexOutput,o);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.worldPos.xyz = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.worldNormal = UnityObjectToWorldNormal(v.normal);

				//--��δʹ�ú� DIRLIGHTMAP_COMBINED DYNAMICLIGHTMAP_ON ʡ�Բ��ִ���--
				
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

					// SH/ambient and vertex lights
				#ifndef LIGHTMAP_ON
					//UNITY_SAMPLE_FULL_SH_PER_PIXEL һ��Ϊfalse����ΪLIGHTPROBE_SH��LIGHTMAP_ON����ͬʱ����
					#if UNITY_SHOULD_SAMPLE_SH
						o.sh = 0;
						// Approximated illumination from non-important point lights
						// һ������£�Ӧ��û��ʵʱ���Դ����������������Ǽ�����
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, o.worldPos.xyz, o.worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (o.worldNormal, o.sh);
					#endif
				#endif // !LIGHTMAP_ON

				//--��δʹ�ú� shadow_mask�決�� UNITY_TRANSFER_LIGHTING ʡ�Բ��ִ���--

				//��Чֻʹ��Linear
				UNITY_TRANSFER_FOG(o,o.pos);
				return o;
			}
			fixed4 frag(VertexOutput i) : SV_Target {
				//Ĭ��ֻ��ƽ�й���Ϊ����Դ
				fixed3 lightDir = _WorldSpaceLightPos0.xyz;

				//surface�Զ��岿��
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

				#if defined(LIGHTMAP_ON)
					// Baked lightmaps
					half4 bakedColorTex = UNITY_SAMPLE_TEX2D(unity_Lightmap, lightmapUV.xy);
					half3 bakedColor = DecodeLightmap(bakedColorTex);					
					indirectDiffuse += bakedColor;
				#endif

				fixed diff = max (0, dot (i.worldNormal, lightDir));

				fixed4 finalColor;
				finalColor.rgb = mainTexColor.rgb * _LightColor0.rgb * diff;				
				finalColor.rgb += mainTexColor.rgb * indirectDiffuse;

				finalColor.a = mainTexColor.a;

				UNITY_APPLY_FOG(i.fogCoord, finalColor);
				return finalColor;
			}
			ENDCG
		}
	}

}
