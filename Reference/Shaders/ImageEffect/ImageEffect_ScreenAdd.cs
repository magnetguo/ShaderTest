using UnityEngine;
using System.Collections;
using UnityStandardAssets.ImageEffects;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Valkyrie/ImageEffect/ScreenAdd")]
public class ImageEffect_ScreenAdd : PostEffectsBase
{
    public Color m_Color;
    public float m_Intensity = 1.0f;
    public float m_Duration = 1.0f;
    public OverlyingMode m_Mode = OverlyingMode.FireSky;

    public Shader m_Shader;
    private Material m_Material = null;

    public void Awake()
    {
#if UNITY_EDITOR
        m_Shader = Shader.Find("Valkyrie/ImageEffect/ScreenAdd");
#else
        m_Shader = ShaderManager.Find("Valkyrie/ImageEffect/ScreenAdd");
#endif
    }

    public override bool CheckResources()
    {
        CheckSupport(false);

        if (m_Shader == null)
            return false;

        m_Material = CheckShaderAndCreateMaterial(m_Shader, m_Material);
        if (!isSupported)
            ReportAutoDisable();

        return isSupported;
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (CheckResources() == false)
        {
            Graphics.Blit(source, destination);
            return;
        }
        m_Material.SetColor("_MainColor", m_Color);
        m_Material.SetFloat("_Duration", m_Duration);
        m_Material.SetFloat("_Intensity", m_Intensity);
        Graphics.Blit(source, destination, m_Material, (int)m_Mode);
    }
}
public enum OverlyingMode
{
    FireSky = 0,            //火焰天空
    Exposure = 1,           //曝光
    Negate = 2,             //取反
    NegateToFireSky = 3,    //取反过度到火焰天空
    FireSkyToNormal = 4,    //火焰天空过度到正常
    Dark = 5,               //变暗
}
