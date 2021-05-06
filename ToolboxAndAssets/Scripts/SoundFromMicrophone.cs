using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;

public class SoundFromMicrophone : MonoBehaviour
{

    public string selectedDevice { get; private set; }

    public int device = 1;

    private int m_device;

    private AudioSource audioSource;
    // Start recording with built-in Microphone and play the recorded audio right away
    void Start()
    {
        m_device = device;
        MicroLauncher(device);
    }

    void Update()
    {
        if (device != m_device)
        {
            MicroLauncher(device);
            m_device = device;

        }

    }

    void MicroLauncher(int j)
    {
        audioSource = GetComponent<AudioSource>();
        selectedDevice = Microphone.devices[j].ToString();
        Debug.Log(selectedDevice);
        audioSource.clip = Microphone.Start(Microphone.devices[j], true, 1, 44100);
        audioSource.Play();

    }

}
