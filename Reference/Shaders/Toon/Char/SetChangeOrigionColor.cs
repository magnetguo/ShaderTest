using UnityEngine;
using System.Collections;
using System;

public class SetChangeOrigionColor : MonoBehaviour
{
    [HideInInspector]
    public Color TargetColor1 = Color.red;
    [HideInInspector]
    public Color TargetColor2 = Color.blue;
    [HideInInspector]
    public Color TargetColor3 = Color.green;

    public void Start()
    {
        var render = this.GetComponent<SkinnedMeshRenderer>();
        if (render != null)
        {
            var mat = render.materials;
            if(mat != null && mat.Length > 0)
            {
                var tex = mat[0].GetTexture("_MainTex");
                if (tex != null)
                {
                    var tex2d = tex as Texture2D;
                    if (tex2d != null)
                    {
                        //0-10 uv色值
                        mat[0].SetColor("_OrigionColor1", tex2d.GetPixel(5, 5));
                        mat[0].SetColor("_TargetColor1", TargetColor1);
                        //10-20 uv色值
                        mat[0].SetColor("_OrigionColor2", tex2d.GetPixel(15, 5));
                        mat[0].SetColor("_TargetColor2", TargetColor2);
                        //20-30 uv色值
                        mat[0].SetColor("_OrigionColor3", tex2d.GetPixel(25, 5));
                        mat[0].SetColor("_TargetColor3", TargetColor3);
                    }
                }
            }
        }
    }

}
