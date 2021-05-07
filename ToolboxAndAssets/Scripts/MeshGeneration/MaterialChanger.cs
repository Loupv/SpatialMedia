using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Valve.VR;
using UnityEngine.SceneManagement;

// Ajouté par Rémi
// Provient du projet Montage Spatial
// Change le Material d'un objet lorsqu'un autre entre en collision.

public class MaterialChanger : MonoBehaviour
{

    public GameObject renderedObject;

    public Material newMaterial;
    public Material originalMaterial;

    public string colliderTag;




    void OnTriggerEnter(Collider other)
    {
        if (other.tag == colliderTag)
        {
            Debug.Log("object in");
            renderedObject.GetComponent<MeshRenderer>().material = newMaterial;
        }

        

    }

    void OnTriggerStay(Collider other)
    {

        if (other.tag == colliderTag)
        {
            Debug.Log("object in trigger");
            renderedObject.GetComponent<MeshRenderer>().material = newMaterial;
        }

    }

    void OnTriggerExit(Collider other)
    {
        if (other.tag == colliderTag)
        {
            Debug.Log("object out");
            renderedObject.GetComponent<MeshRenderer>().material = originalMaterial;
        }
    }



}
