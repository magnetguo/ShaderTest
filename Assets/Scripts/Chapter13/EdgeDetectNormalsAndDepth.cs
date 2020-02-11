using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class EdgeDetectNormalsAndDepth : PostEffectBase
{
    [Range(0.0f, 1.0f)]
    public float edgesOnly = 0.0f;

    public Color edgeColor = Color.black;

    public Color backgroundColor = Color.white;

    public float sampleDistance = 1.0f;

    public float sensitivityDepth = 1.0f;

    public float sensitivityNormals = 1.0f;

    /// <summary>
    /// This function is called when the object becomes enabled and active.
    /// </summary>
    void OnEnable()
    {
        GetComponent<Camera>().depthTextureMode |= DepthTextureMode.DepthNormals;
    }

    [ImageEffectOpaque]
    protected override void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        base.OnRenderImage(src, dest);
    }

    protected override void SetProperties()
    {
        if (material == null)
            throw new NullReferenceException();

        material.SetFloat("_EdgeOnly", edgesOnly);
        material.SetColor("_EdgeColor", edgeColor);
        material.SetColor("_BackgroundColor", backgroundColor);
        material.SetFloat("SampleDistance", sampleDistance);
        material.SetVector("_Sensitivity", new Vector4(sensitivityNormals, sensitivityDepth, 0.0f, 0.0f));
    }
}
