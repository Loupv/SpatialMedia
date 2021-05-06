using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VideoFromCamera : MonoBehaviour
{

    WebCamTexture webcamTexture;

    public int device;

    private int m_device;

    void Start()
    {

        WebCamDevice[] devices = WebCamTexture.devices;
        for (int i = 0; i < devices.Length; i++)
        {
            Debug.Log(devices[i].name);
        }
        CameraLauncher(device);
        m_device = device;

    }



    void Update()
    {
        if (device != m_device)
        {
            webcamTexture.Stop();
            CameraLauncher(device);
            m_device = device;

        }

    }



    void CameraLauncher(int j)
    {
        WebCamDevice[] devices = WebCamTexture.devices;
        webcamTexture = new WebCamTexture(devices[j].name);
        Debug.Log(webcamTexture.deviceName);

        Renderer renderer = GetComponent<Renderer>();
        renderer.material.mainTexture = webcamTexture;
        //webcamTexture.Stop();
        webcamTexture.Play();

    }


}
