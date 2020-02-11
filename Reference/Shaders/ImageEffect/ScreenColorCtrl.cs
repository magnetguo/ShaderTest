using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public delegate void OnFadeAutoFinished();
public class ScreenColorCtrl : MonoBehaviour
{
    
    public Camera m_CamSub;
    public Camera m_CamMain;
    public enum Type
    {
        Dark,
        FireSky,
    }

    public Dark m_Dark;
    public FireSky m_FireSky;

    public void Awake()
    {
        var add = GetComponent<ImageEffect_ScreenAdd>();
        m_Dark = new Dark(add);
        m_FireSky = new FireSky(add);

    }

    public void FadeIn(Type type)
    {
        switch (type)
        {
            case Type.Dark:
                m_Dark.FadeIn();
                break;
            case Type.FireSky:
                m_FireSky.FadeIn();
                break;
            default:
                break;
        }

    }

    public void FadeOut(Type type)
    {
        switch (type)
        {
            case Type.Dark:
                m_Dark.FadeOut();
                break;
            case Type.FireSky:
                m_FireSky.FadeOut();
                break;
            default:
                break;
        }
    }

    public void FadeAuto(OnFadeAutoFinished dele)
    {
        m_Dark.FadeAuto(dele);
    }

    public void SynCam(Camera sub,Camera main)
    {
        m_CamSub = sub;
        m_CamMain = main;
    }
    public void Update()
    {
        if (m_CamSub != null && m_CamMain != null)
            m_CamSub.fieldOfView = m_CamMain.fieldOfView;

        m_Dark.Tick();
        m_FireSky.Tick();
    }

    public class FireSky
    {
        private bool m_Start = false;
        private bool m_Revert = false;
        private float m_ETime = 0;
        private float m_NTime = 0;
        private float m_DTime = 0;
        private float m_RTime = 0;

        public float ETime = 0.1f;
        public float NTime = 0.1f;
        public float DTime = 0.5f;
        public float RTime = 0.5f;

        public ImageEffect_ScreenAdd m_ScreenAdd;

        public FireSky(ImageEffect_ScreenAdd add)
        {
            m_ScreenAdd = add;
        }

        public void FadeStart()
        {
            m_Start = true;
            m_ETime = 0;
            m_NTime = 0;
            m_DTime = 0;
            m_RTime = 0;

            if (m_ScreenAdd != null)
                m_ScreenAdd.enabled = true;
        }

        public void FadeIn()
        {
            FadeStart();
            m_Revert = false;
        }
        public void FadeOut()
        {
            FadeStart();
            m_Revert = true;
        }

        public void Tick()
        {
            if (m_ScreenAdd == null)
                return;

            if (m_Start)
            {
                if (m_Revert)
                {
                    m_RTime += Time.deltaTime;
                    if (m_RTime < RTime)
                    {
                        m_ScreenAdd.m_Mode = OverlyingMode.FireSkyToNormal;
                        m_ScreenAdd.m_Duration = Mathf.Min(m_RTime / RTime, 1);
                    }
                    else
                    {
                        m_Start = false;
                        m_ScreenAdd.enabled = false;
                    }
                }
                else
                {
                    if (m_ETime < ETime)
                    {
                        m_ETime += Time.deltaTime;
                        m_ScreenAdd.m_Mode = OverlyingMode.Exposure;
                    }
                    else
                    {
                        if (m_NTime < NTime)
                        {
                            m_NTime += Time.deltaTime;
                            m_ScreenAdd.m_Mode = OverlyingMode.Negate;
                        }
                        else
                        {

                            if (m_DTime < DTime)
                            {
                                m_DTime += Time.deltaTime;
                                m_ScreenAdd.m_Mode = OverlyingMode.NegateToFireSky;
                                m_ScreenAdd.m_Duration = Mathf.Min(m_DTime / DTime, 1);
                            }
                            else
                            {
                                m_Start = false;
                                m_ScreenAdd.m_Mode = OverlyingMode.FireSky;
                            }
                        }
                    }
                }
            }
        }
    }


    public class Dark
    {
        private bool m_Start = false;
        private bool m_Revert = false;
        private bool m_IsWaiting = false;

        private float m_In = 0f;
        private float m_Out = 0f;
        private float m_Stay = 0f;

        public float In = 0.5f;
        public float Out = 0.5f;
        public float Stay = 0.1f;
        public ImageEffect_ScreenAdd m_ScreenAdd;
        
        public OnFadeAutoFinished m_OnFadeAutoFinished;
        public Dark(ImageEffect_ScreenAdd add)
        {
            m_ScreenAdd = add;
        }
        public void FadeStart()
        {
            m_Start = true;
            m_In = 0f;
            m_Out = 0f;
            m_Stay = 0f;

            if (m_ScreenAdd != null)
            {
                m_ScreenAdd.enabled = true;
                m_ScreenAdd.m_Color = Color.gray;
                m_ScreenAdd.m_Mode = OverlyingMode.Dark;
            }
        }
        public void FadeIn()
        {
            FadeStart();
            m_Revert = false;
            m_IsWaiting = true;
        }
        public void FadeOut()
        {
            FadeStart();
            m_Revert = true;
            m_IsWaiting = true;
        }

        public void FadeAuto(OnFadeAutoFinished dele)
        {
            FadeStart();
            m_Revert = false;
            m_IsWaiting = false;
            m_OnFadeAutoFinished = dele;
        }

        public void Tick()
        {
            if (m_ScreenAdd == null)
                return;

            if (m_Start)
            {
                if (m_Revert)
                {
                    m_Out += Time.deltaTime;
                    if (m_Out < Out)
                    {
                        m_ScreenAdd.m_Duration = Mathf.Max(1 - m_Out / Out, 0);
                    }
                    else
                    {
                        m_Start = false;
                        m_ScreenAdd.enabled = false;
                        if (m_OnFadeAutoFinished != null)
                        {
                            m_OnFadeAutoFinished.Invoke();
                            m_OnFadeAutoFinished = null;
                        }
                    }
                }
                else
                {
                    m_In += Time.deltaTime;
                    if (m_In < In)
                    {
                        m_ScreenAdd.m_Duration = Mathf.Min(m_In / In, 1);
                    }
                    else
                    {
                        if (!m_IsWaiting)
                        {
                            m_Stay += Time.deltaTime;
                            if (m_Stay > Stay)
                                m_Revert = true;
                        }
                        else
                            m_Start = false;
                    }
                }
            }
        }
    }
}

