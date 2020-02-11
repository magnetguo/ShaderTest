using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class PostEffectBase : MonoBehaviour
{
    public Shader shader;

    private Material _material;
    public Material material
    {
        get
        {
            _material = CheckShaderAndCreateMaterial(shader, _material);
            return _material;
        }
    }

    void CheckResources()
    {
        bool isSupported = CheckSupport();

        if (!isSupported)
            NotSupported();
    }

    bool CheckSupport()
    {
        /*
        if (SystemInfo.supportsImageEffects == false || SystemInfo.supportsRenderTextures == false)
        {
            Debug.LogWarning("This platform does not support image effects or render textures");
            return false;
        }
        */
        return true;
    }

    void NotSupported()
    {
        enabled = false;
    }

    // Start is called before the first frame update
    void Start()
    {
        CheckResources();
    }

    /// <summary>
    /// OnRenderImage is called after all rendering is complete to render image.
    /// </summary>
    /// <param name="src">The source RenderTexture.</param>
    /// <param name="dest">The destination RenderTexture.</param>
    protected virtual void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (material != null)
        {
            SetProperties();
            Graphics.Blit(src, dest, material);
        }
        else
        {
            Graphics.Blit(src, dest);
        }
    }

    protected virtual void SetProperties() {}

    private Material CheckShaderAndCreateMaterial(Shader shader, Material material)
    {
        if (shader == null)
            return null;
        
        if (shader.isSupported && material && material.shader == shader)
            return material;

        if (!shader.isSupported)
        {
            Debug.LogWarning("Shader not supported");
            return null;
        }
            
        else
        {
            material = new Material(shader);
            material.hideFlags = HideFlags.DontSave;
            return material;
        }
    }
}
