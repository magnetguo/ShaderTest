using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class MotionBlurWithDepthTexture : PostEffectBase
{
    [Range(0.0f, 1.0f)]
    public float blurSize = 0.5f;

    private Camera _camera;
    new public Camera camera
    {
        get
        {
            if (_camera == null)
                _camera = GetComponent<Camera>();
            return _camera;
        }
    }

    private Matrix4x4 previousViewProj;

    /// <summary>
    /// This function is called when the object becomes enabled and active.
    /// </summary>
    void OnEnable()
    {
        camera.depthTextureMode |= DepthTextureMode.Depth;
        previousViewProj = camera.projectionMatrix * camera.worldToCameraMatrix;
    }

    protected override void SetProperties()
    {
        if (material == null)
            throw new NullReferenceException();

        material.SetFloat("_BlurSize", blurSize);
        material.SetMatrix("_PreviousViewProj", previousViewProj);

        Matrix4x4 currViewProj = camera.projectionMatrix * camera.worldToCameraMatrix;

        material.SetMatrix("_CurrViewProjInv", currViewProj.inverse);

        previousViewProj = currViewProj;
    }
}
