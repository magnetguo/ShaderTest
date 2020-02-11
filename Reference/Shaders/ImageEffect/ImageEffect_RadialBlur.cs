using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu ("Valkyrie/ImageEffect/RadialBlur")]
public class ImageEffect_RadialBlur : MonoBehaviour 
{
	
	#region Variables
	public Shader RadialBlurShader = null;
	private Material RadialBlurMaterial = null;

	[Range(0.0f, 1.0f)]
	public float SampleDist = 0.17f;

	[Range(1.0f, 5.0f)]
	public float SampleStrength = 2.09f;

	#endregion
	

void Start () {
		FindShaders ();
		CheckSupport ();
		CreateMaterials ();
	}

	void FindShaders () {
		if (!RadialBlurShader) {
			RadialBlurShader = ShaderManager.Find("Valkyrie/ImageEffect/Unlit/RadialBlur");
		}
	}

	void CreateMaterials() {
		if(!RadialBlurMaterial){
			RadialBlurMaterial = new Material(RadialBlurShader);
			RadialBlurMaterial.hideFlags = HideFlags.HideAndDontSave;	
		}
	}

	bool Supported(){
		return (SystemInfo.supportsImageEffects && RadialBlurShader.isSupported);
	}

	bool CheckSupport() {
		if(!Supported()) {
			enabled = false;
			return false;
		}
		return true;
	}

	void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
	{	
		#if UNITY_EDITOR
			FindShaders ();
			CheckSupport ();
			CreateMaterials ();	
		#endif

		if(SampleDist != 0 && SampleStrength != 0){

#if UNITY_EDITOR || UNITY_STANDALONE_WIN
            int rtW = sourceTexture.width/2;
	        int rtH = sourceTexture.height/2;
#else
            int rtW = sourceTexture.width/8;
	        int rtH = sourceTexture.height/8;
#endif


            RadialBlurMaterial.SetFloat ("_SampleDist", SampleDist);
	        RadialBlurMaterial.SetFloat ("_SampleStrength", SampleStrength);	


            RenderTexture rtTemp = RenderTexture.GetTemporary (rtW, rtH, 0,RenderTextureFormat.Default);
            rtTemp.filterMode = FilterMode.Bilinear;
            Graphics.Blit (sourceTexture, rtTemp, RadialBlurMaterial,0);

            RadialBlurMaterial.SetTexture ("_BlurTex", rtTemp);
       		Graphics.Blit (sourceTexture, destTexture, RadialBlurMaterial,1);

            RenderTexture.ReleaseTemporary(rtTemp);
 
		}

		else{
			Graphics.Blit(sourceTexture, destTexture);
			
		}
	}	

    void OnDestroy()
    {
        if (RadialBlurMaterial)
            DestroyImmediate(RadialBlurMaterial);
    }
}
