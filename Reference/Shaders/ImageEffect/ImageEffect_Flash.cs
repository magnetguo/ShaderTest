////////////////////////////////////////////
// CameraFilterPack - by VETASOFT 2018 /////
////////////////////////////////////////////

using UnityEngine;
using System.Collections;
[ExecuteInEditMode]
[AddComponentMenu ("Valkyrie/ImageEffect/Flash")]
public class ImageEffect_Flash: MonoBehaviour {
#region Variables
public Shader SCShader;
private float TimeX = 1.0f;
 
private Material SCMaterial;
[Range(1f, 10f)]
public float Size = 1f;
public Color Color = new Color(0,0.7f,1,1);
[Range(0, 30)]
public int Speed = 5;
[Range(0f, 1f)]
public float PosX = 0.5f;
[Range(0f, 1f)]
public float PosY = 0.5f;
    [Range(0f, 1f)]
    public float Intensity = 1f;

    #endregion
    #region Properties
    Material material
{
get
{
if(SCMaterial == null)
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
SCShader = Shader.Find("Valkyrie/ImageEffect/Unlit/Flash");
if(!SystemInfo.supportsImageEffects)
{
enabled = false;
return;
}
}
void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
{
if(SCShader != null)
{
TimeX+=Time.deltaTime;
if (TimeX>100)  TimeX=0;
material.SetFloat("_TimeX", TimeX);
material.SetFloat("_Value", Size);
material.SetFloat("_Value2", (float)Speed);
material.SetFloat("_Value3", PosX);
material.SetFloat("_Value4", PosY);
            material.SetFloat("_Intensity", Intensity);

            material.SetColor("Color",Color);
material.SetVector("_ScreenResolution",new Vector4(sourceTexture.width,sourceTexture.height,0.0f,0.0f));
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
if (Application.isPlaying!=true)
{
SCShader = Shader.Find("Valkyrie/ImageEffect/Unlit/Flash");
}
#endif
    }
    void OnDisable ()
{
if(SCMaterial)
{
DestroyImmediate(SCMaterial);
}
}
}