﻿using UnityEngine;
using System.Collections;
using System;

[ExecuteInEditMode]
[AddComponentMenu ("Valkyrie/ImageEffect/MoblieBloomWithMotionBlur")]

public class MoblieBloomWithMotionBlur : MonoBehaviour {

	#region Variables
	public Shader BloomShader = null;
	private Material BloomMaterial = null;
	private RenderTextureFormat rtFormat = RenderTextureFormat.Default;

	public Color BloomColorMix = new Color(1.0f, 1.0f, 1.0f, 1.0f);

	[Range(0.0f, 1.0f)]
    public float BloomThreshold = 0.25f;

    [Range(0.0f, 2.5f)]
    public float BloomIntensity = 0.75f;

    [Range(0.2f, 1.0f)]
    public float BloomBlurSize = 1.0f;
	#endregion


	// Use this for initialization
	void Start () {
		FindShaders ();
		CheckSupport ();
		CreateMaterials ();
	}

	void FindShaders () {
		if (!BloomShader) {
			BloomShader = ShaderManager.Find("Valkyrie/ImageEffect/Unlit/MobileBloom");
		}
	}

	void CreateMaterials() {
		if(!BloomMaterial){
			BloomMaterial = new Material(BloomShader);
			BloomMaterial.hideFlags = HideFlags.HideAndDontSave;	
		}
	}

	bool Supported(){
		return (SystemInfo.supportsImageEffects && SystemInfo.supportsRenderTextures && BloomShader.isSupported);
		// return true;
	}


	bool CheckSupport() {
		if(!Supported()) {
			enabled = false;
			return false;
		}
		rtFormat = SystemInfo.SupportsRenderTextureFormat (RenderTextureFormat.RGB565) ? RenderTextureFormat.RGB565 : RenderTextureFormat.Default;
		return true;
	}


	void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
	{	
		#if UNITY_EDITOR
			FindShaders ();
			CheckSupport ();
			CreateMaterials ();	
		#endif

		if(BloomThreshold != 0 && BloomIntensity != 0){

			int rtW = sourceTexture.width/4;
	        int rtH = sourceTexture.height/4;
	
	        BloomMaterial.SetColor ("_ColorMix", BloomColorMix);
	        BloomMaterial.SetVector ("_Parameter", new Vector4(BloomBlurSize*1.5f, 0.0f, BloomIntensity,0.8f - BloomThreshold));	
	        // material.SetFloat("_blurSize",BlurSize);

	        RenderTexture rtTempA = RenderTexture.GetTemporary (rtW, rtH, 0,rtFormat);
            rtTempA.filterMode = FilterMode.Bilinear;

            RenderTexture rtTempB = RenderTexture.GetTemporary (rtW, rtH, 0,rtFormat);
            rtTempA.filterMode = FilterMode.Bilinear;

            Graphics.Blit (sourceTexture, rtTempA,BloomMaterial,0);


            Graphics.Blit (rtTempA, rtTempB, BloomMaterial,1);
            RenderTexture.ReleaseTemporary(rtTempA);
 

            rtTempA = RenderTexture.GetTemporary (rtW, rtH, 0, rtFormat);
            rtTempB.filterMode = FilterMode.Bilinear;
            Graphics.Blit (rtTempB, rtTempA, BloomMaterial,2);


            BloomMaterial.SetTexture ("_Bloom", rtTempA);
            Graphics.Blit (sourceTexture, destTexture, BloomMaterial,3);
       

            RenderTexture.ReleaseTemporary(rtTempA);
            RenderTexture.ReleaseTemporary(rtTempB);
		}

		else{
			Graphics.Blit(sourceTexture, destTexture);
			
		}
	}

    public void OnDestroy()
    {
        if (BloomMaterial)
            DestroyImmediate(BloomMaterial);
    }
}