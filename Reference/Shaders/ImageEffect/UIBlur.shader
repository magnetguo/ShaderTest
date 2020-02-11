Shader "Valkyrie/ImageEffect/UIBlur"
{
	Properties
	{
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
        _Size ("Size", Range(0, 200)) = 100
	}
    SubShader {
		Tags 
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "True"
		}
        
        Cull Off
        Lighting Off
        ZWrite Off
  
        // Horizontal blur
        GrabPass {                      
            "_GrabTextureH"
        }
        Pass {
 
            Name "UIBlurHorizontal"
            CGPROGRAM  
            #pragma vertex vert  
            #pragma fragment frag  
            #pragma fragmentoption ARB_precision_hint_fastest  
            #include "UnityCG.cginc"
  
            struct appdata_t {  
                float4 vertex : POSITION;  
                float2 texcoord : TEXCOORD0;
            };  
  
            struct v2f {  
                float4 vertex : POSITION;  
                float4 uvgrab : TEXCOORD0;
            };
  
            v2f vert (appdata_t v) {  
                v2f o; 
                o.vertex = UnityObjectToClipPos(v.vertex);  
                o.uvgrab = ComputeGrabScreenPos(o.vertex); 
                return o;  
            }  
  
            sampler2D _GrabTextureH;  
            float4 _GrabTextureH_TexelSize;
            float _Size;
            uniform float4 _Color;            
 
            half4 GrabPixel(float4 uvgrab, float weight, float kernelx){
                uvgrab.x += _GrabTextureH_TexelSize.x*kernelx*_Size;
                return tex2Dproj(_GrabTextureH, uvgrab) * weight;
            }
            half4 frag( v2f i ) : COLOR {  
                half4 sum = half4(0,0,0,0);                    
                sum += GrabPixel(i.uvgrab, 0.05,-4.0);
                sum += GrabPixel(i.uvgrab, 0.09,-3.0);
                sum += GrabPixel(i.uvgrab, 0.12,-2.0);
                sum += GrabPixel(i.uvgrab, 0.15,-1.0);
                sum += GrabPixel(i.uvgrab, 0.18, 0.0);
                sum += GrabPixel(i.uvgrab, 0.15, 1.0);
                sum += GrabPixel(i.uvgrab, 0.12, 2.0);
                sum += GrabPixel(i.uvgrab, 0.09, 3.0);
                sum += GrabPixel(i.uvgrab, 0.05, 4.0);
				sum *=  _Color;                
                return sum;
            }  
            ENDCG  
        }

        // Vertical blur  
        GrabPass {
            "_GrabTextureV"
        }  
        Pass {  

            Name "UIBlurVertical"
            CGPROGRAM  
            #pragma vertex vert  
            #pragma fragment frag  
            #pragma fragmentoption ARB_precision_hint_fastest  
            #include "UnityCG.cginc"  
  
            struct appdata_t {  
                float4 vertex : POSITION;  
                float2 texcoord: TEXCOORD0;  
            };  
  
            struct v2f {  
                float4 vertex : POSITION;  
                float4 uvgrab : TEXCOORD0;  
            };  
  
            v2f vert (appdata_t v) {  
                v2f o;  
                o.vertex = UnityObjectToClipPos(v.vertex);  
                o.uvgrab = ComputeGrabScreenPos(o.vertex); 
                return o;  
            }  
  
            sampler2D _GrabTextureV;  
            float4 _GrabTextureV_TexelSize;  
            float _Size;
            float4 _Color;
 
            half4 GrabPixel(float4 uvgrab, float weight, float kernely){
                uvgrab.y += _GrabTextureV_TexelSize.y*kernely*_Size;
                return tex2Dproj( _GrabTextureV, uvgrab) * weight;
            }
  
            half4 frag( v2f i ) : COLOR {
                half4 sum = half4(0,0,0,0);
                sum += GrabPixel(i.uvgrab, 0.05, -4.0);
                sum += GrabPixel(i.uvgrab, 0.09, -3.0);
                sum += GrabPixel(i.uvgrab, 0.12, -2.0);
                sum += GrabPixel(i.uvgrab, 0.15, -1.0);
                sum += GrabPixel(i.uvgrab, 0.18,  0.0);
                sum += GrabPixel(i.uvgrab, 0.15, +1.0);
                sum += GrabPixel(i.uvgrab, 0.12, +2.0);
                sum += GrabPixel(i.uvgrab, 0.09, +3.0);
                sum += GrabPixel(i.uvgrab, 0.05, +4.0);
				sum *= _Color;  
                return sum;
            }
            ENDCG  
        }
    } 
}