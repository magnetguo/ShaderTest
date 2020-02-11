using UnityEngine;
[ExecuteInEditMode]
public class Mirror : MonoBehaviour
{
    public Vector2 RTSize = new Vector2(512, 512);
    private Camera m_CurCamera = null;
    private Camera m_ReflectCamera = null;
    private RenderTexture m_ReflectRT = null;
    private bool m_IsCameraRendering = false;
    private Material m_ReflectMaterial = null;

    private void OnWillRenderObject()
    {
        if (m_IsCameraRendering)
            return;
        m_CurCamera = Camera.current;
        m_IsCameraRendering = true;
        if (m_ReflectCamera == null)
        {
            var go = new GameObject("Reflect Camera");
            m_ReflectCamera = go.AddComponent<Camera>();
            m_ReflectCamera.CopyFrom(m_CurCamera);
            m_ReflectCamera.hideFlags = HideFlags.HideAndDontSave;
        }

        if (m_ReflectRT == null)
            m_ReflectRT = RenderTexture.GetTemporary((int)RTSize.x, (int)RTSize.y, 24);

        SyncCamearaData(m_CurCamera, m_ReflectCamera);
        m_ReflectCamera.targetTexture = m_ReflectRT;
        m_ReflectCamera.enabled = false;

        var reflectM = SetReflectMatrix();
        m_ReflectCamera.worldToCameraMatrix = m_CurCamera.worldToCameraMatrix * reflectM;
        var normal = transform.up;
        var d = -Vector3.Dot(normal, transform.position);
        var plane = new Vector4(normal.x, normal.y, normal.z, d);
        var clipMatrix = SetObliqueMatrix(plane, m_ReflectCamera);
        m_ReflectCamera.projectionMatrix = clipMatrix;
        GL.invertCulling = true;
        m_ReflectCamera.Render();
        GL.invertCulling = false;
        if (m_ReflectMaterial == null)
        {
            var renderer = GetComponent<Renderer>();
            m_ReflectMaterial = renderer.sharedMaterial;
        }
        m_ReflectMaterial.SetTexture("_ReflectionTex", m_ReflectRT);
        m_IsCameraRendering = false;
    }

    private void OnDisable()
    {
        Release();
    }

    private void OnDestroy()
    {
        Release();
    }

    private void Release()
    {
        if (m_ReflectCamera != null)
            DestroyImmediate(m_ReflectCamera.gameObject);
        if (m_ReflectRT != null)
        {
            RenderTexture.ReleaseTemporary(m_ReflectRT);
            if (Application.isPlaying)
                Destroy(m_ReflectRT);
        }
        m_ReflectCamera = null;
        m_ReflectRT = null;
    }

    Matrix4x4 SetReflectMatrix()
    {
        var normal = transform.up;
        var d = -Vector3.Dot(normal, transform.position);
        var reflectM = new Matrix4x4();
        reflectM.m00 = 1 - 2 * normal.x * normal.x;
        reflectM.m01 = -2 * normal.x * normal.y;
        reflectM.m02 = -2 * normal.x * normal.z;
        reflectM.m03 = -2 * d * normal.x;
        reflectM.m10 = -2 * normal.x * normal.y;
        reflectM.m11 = 1 - 2 * normal.y * normal.y;
        reflectM.m12 = -2 * normal.y * normal.z;
        reflectM.m13 = -2 * d * normal.y;
        reflectM.m20 = -2 * normal.x * normal.z;
        reflectM.m21 = -2 * normal.y * normal.z;
        reflectM.m22 = 1 - 2 * normal.z * normal.z;
        reflectM.m23 = -2 * d * normal.z;
        reflectM.m30 = 0;
        reflectM.m31 = 0;
        reflectM.m32 = 0;
        reflectM.m33 = 1;
        return reflectM;
    }

    
    private void SyncCamearaData(Camera from, Camera to)
    {
        if (to == null || from == null)
            return;
        to.clearFlags = from.clearFlags;
        to.backgroundColor = from.backgroundColor;
        to.farClipPlane = from.farClipPlane;
        to.nearClipPlane = from.nearClipPlane;
        to.orthographic = from.orthographic;
        to.fieldOfView = from.fieldOfView;
        to.aspect = from.aspect;
        to.orthographicSize = from.orthographicSize;
    }

    private Matrix4x4 SetObliqueMatrix(Vector4 plane, Camera camera)
    {
        var viewSpacePlane = camera.worldToCameraMatrix.inverse.transpose * plane;
        var projMatrix = camera.projectionMatrix;

        var clipSpaceFarPanelBoundPoint = new Vector4(Mathf.Sign(viewSpacePlane.x), Mathf.Sign(viewSpacePlane.y), 1, 1);
        var viewSpaceFarPanelBoundPoint = camera.projectionMatrix.inverse * clipSpaceFarPanelBoundPoint;
        var m4 = new Vector4(projMatrix.m30, projMatrix.m31, projMatrix.m32, projMatrix.m33);
        var u = 2.0f / Vector4.Dot(viewSpaceFarPanelBoundPoint, viewSpacePlane);
        var newViewSpaceNearPlane = u * viewSpacePlane;
        var m3 = newViewSpaceNearPlane - m4;
        projMatrix.m20 = m3.x;
        projMatrix.m21 = m3.y;
        projMatrix.m22 = m3.z;
        projMatrix.m23 = m3.w;
        return projMatrix;
    }
}
