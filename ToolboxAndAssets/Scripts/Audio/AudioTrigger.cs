using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Ajouté par Rémi
// Provient du projet Buster
// Active une Audiosource lorsque qu'un GameObject entre en collision

public class AudioTrigger : MonoBehaviour
{


    public AudioSource _audioSource;

    public GameObject Trigger;


    void OnTriggerEnter(Collider other)
    {
        if (other == Trigger.GetComponent<Collider>())
        {
            Debug.Log("object in");
            _audioSource.Play();
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other == Trigger.GetComponent<Collider>())
        {
            Debug.Log("object out");
            _audioSource.Stop();
        }
    }



}
