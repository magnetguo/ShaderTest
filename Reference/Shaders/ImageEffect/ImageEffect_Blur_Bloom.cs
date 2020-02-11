////////////////////////////////////////////
// from: CameraFilterPack - by VETASOFT 2016 /////
////////////////////////////////////////////

using System;
using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu ("Camera Filter Pack/Blur/Bloom")]
public class ImageEffect_Blur_Bloom : MonoBehaviour {
#region Variables
    public Shader SCShader;
    private Vector4 ScreenResolution;
    private Material SCMaterial;
    [Range(0, 10)]
    public float Amount = 2f;
    [Range(0, 1)]
    public float Glow = 0.25f;
    public Color ColorMix = Color.white;
    private float lastAmount = 0.0f;
    private float lastGlow = 0.0f;

#endregion

#region Properties
    Material material
    {
        get
        {
            if(SCMaterial == null && SCShader != null)
            {
                SCMaterial = new Material(SCShader);
                SCMaterial.hideFlags = HideFlags.HideAndDontSave;	
            }
            return SCMaterial;
        }
    }
#endregion
    void Start () 
    {
        
#if UNITY_EDITOR
        if (SCShader == null)
        {
            SCShader = Shader.Find("Valkyrie/ImageEffect/Unlit/Blur_Bloom");
        }
#else
        SCShader = ShaderManager.Find("Valkyrie/ImageEffect/Unlit/Blur_Bloom");
#endif
        if (!SystemInfo.supportsImageEffects)
        {
            enabled = false;
        }
    }

    void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
    {
        if(SCShader != null)
        {
            material.SetColor("_ColorMix", ColorMix);
            Graphics.Blit(sourceTexture, destTexture, material);
        }
        else
        {
            Graphics.Blit(sourceTexture, destTexture);	
        }
    }


    void Update () 
    {
#if UNITY_EDITOR
        if (SCShader == null)
        {
            SCShader = Shader.Find("Valkyrie/ImageEffect/Unlit/Blur_Bloom");
        }
#endif
        bool changed = false;
        if (Mathf.Abs(lastAmount - Amount) > float.Epsilon)
        {
            changed = true;
            lastAmount = Amount;
        }
        if (Mathf.Abs(lastGlow - Glow) > float.Epsilon)
        {
            changed = true;
            lastGlow = Glow;
        }

        if (changed && material != null)
        {
            material.SetVector("_Params", new Vector4(Amount, Glow, Screen.width, Screen.height));
        }
    }

    void OnDisable ()
    {
        if(SCMaterial)
        {
            DestroyImmediate(SCMaterial);	
        }
    }

    void OnEnable()
    {
        lastAmount = 0.0f;
        lastGlow = 0.0f;
    }

    public void CopyBloom(ImageEffect_Blur_Bloom bloom)
    {
        if (bloom == null)
            return;
        Glow = bloom.Glow;
        Amount = bloom.Amount;
        ColorMix = bloom.ColorMix;
    }
}