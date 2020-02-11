using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class FogWithNoise : PostEffectBase
{
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

    private Transform _trans_camera;
    public Transform trans_camera
    {
        get
        {
            if (_trans_camera == null)
                _trans_camera = camera.transform;
            return _trans_camera;   
        }
    }

    [Range(0.0f, 3.0f)]
    public float fogDensity = 1.0f;

    public Color fogColor = Color.white;

    public float fogStart = 0.0f;
    public float fogEnd = 2.0f;

    public Texture noiseTexture;

    [Range(-0.5f, 0.5f)]
    public float fogXSpeed = 0.1f;

    [Range(-0.5f, 0.5f)]
    public float fogYSpeed = 0.1f;

    [Range(0.0f, 3.0f)]
    public float noiseAmount = 1.0f;

    /// <summary>
    /// This function is called when the object becomes enabled and active.
    /// </summary>
    void OnEnable()
    {
        camera.depthTextureMode |= DepthTextureMode.Depth;
    }

    protected override void SetProperties()
    {
        if (material == null)
            throw new NullReferenceException();
        
        Matrix4x4 frustumCorners = Matrix4x4.identity;

        float halfHeight = camera.nearClipPlane * Mathf.Tan(camera.fieldOfView * 0.5f * Mathf.Deg2Rad);
        Vector3 toRight = trans_camera.right * halfHeight * camera.aspect;
        Vector3 toTop = trans_camera.up * halfHeight;

        Vector3 topLeft = trans_camera.forward * camera.nearClipPlane + toTop - toRight;
        float scale = topLeft.magnitude / camera.nearClipPlane;

        topLeft = topLeft.normalized * scale;

        Vector3 topRight = trans_camera.forward * camera.nearClipPlane + toTop + toRight;
        topRight = topRight.normalized * scale;

        Vector3 bottomLeft = trans_camera.forward * camera.nearClipPlane - toTop - toRight;
        bottomLeft = bottomLeft.normalized * scale;

        Vector3 bottomRight = trans_camera.forward * camera.nearClipPlane - toTop + toRight;
        bottomRight = bottomRight.normalized * scale;

        frustumCorners.SetRow(0, bottomLeft);
        frustumCorners.SetRow(1, bottomRight);
        frustumCorners.SetRow(2, topLeft);
        frustumCorners.SetRow(3, topRight);

        material.SetMatrix("_FrustumCornersRay", frustumCorners);
        material.SetMatrix("_ViewProjInv",(camera.projectionMatrix * camera.worldToCameraMatrix).inverse);

        material.SetFloat("_FogDensity", fogDensity);
        material.SetColor("_FogColor", fogColor);
        material.SetFloat("_FogStart", fogStart);
        material.SetFloat("_FogEnd", fogEnd);

        material.SetTexture("_NoiseTex", noiseTexture);
        material.SetFloat("_FogXSpeed", fogXSpeed);
        material.SetFloat("_FogYSpeed", fogYSpeed);
        material.SetFloat("-NoiseAmount", noiseAmount);
    }
}
