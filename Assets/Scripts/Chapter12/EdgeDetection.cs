using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class EdgeDetection : PostEffectBase
{
    [Range(0.0f, 1.0f)]
    public float edgesOnly = 0.0f;

    public Color edgeColor = Color.black;

    public Color backgroundColor = Color.white;

    protected override void SetProperties()
    {
        if (material == null)
            throw new NullReferenceException("");

        material.SetFloat("_EdgeOnly", edgesOnly);
        material.SetColor("_EdgeColor", edgeColor);
        material.SetColor("_BackgroundColor", backgroundColor);
    }
}
