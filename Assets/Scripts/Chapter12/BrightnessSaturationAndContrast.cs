using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class BrightnessSaturationAndContrast : PostEffectBase
{
    [Range(0.0f, 3.0f)]
    public float brightness = 1.0f;

    [Range(0.0f, 3.0f)]
    public float saturation = 1.0f;

    [Range(0.0f, 3.0f)]
    public float contrast = 1.0f;

    override protected void SetProperties()
    {
        if (material == null)
            throw new NullReferenceException("");

        material.SetFloat("_Brightness", brightness);
        material.SetFloat("_Saturation", saturation);
        material.SetFloat("_Contrast", contrast);
    }
}
