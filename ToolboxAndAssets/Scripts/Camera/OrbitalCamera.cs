using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Ajouté par Loup
// Vient d'Articulations
// Permet de faire tourner une caméra orbitale autour du barycentre de deux points (obj1 et 2)


public class OrbitalCamera : MonoBehaviour
{

    public float optimalHeight, optimalDistance, rotationSpeed;
    public GameObject obj1, obj2;

    // Update is called once per frame
    void Update()
    {
        
        if(obj1 == null || obj2 == null){
            UserData[] users = GameObject.FindObjectsOfType<UserData>();
            obj1 = GameObject.Find("PlaybackPlayer776").GetComponent<UserData>().head;
            obj2 = GameObject.Find("PlaybackPlayer777").GetComponent<UserData>().head;
        }

        Vector3 barycenter = new Vector3((obj1.transform.position.x+obj2.transform.position.x) /2, optimalHeight, 
            (obj1.transform.position.z+obj2.transform.position.z) /2);

        //transform.position = Vector3.MoveTowards(transform.position, barycenter, optimalDistance);
        transform.RotateAround(barycenter, Vector3.up, rotationSpeed*Time.deltaTime);
        transform.LookAt(barycenter);

        Vector3 delta = transform.position - barycenter;
        delta.y = 0; // Keep same Y level
        transform.position = barycenter + delta.normalized * optimalDistance;
    
    }
}
