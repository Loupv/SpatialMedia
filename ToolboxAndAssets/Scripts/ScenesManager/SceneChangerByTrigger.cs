using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

// Ajouté par Rémi
// Provient du projet Buster
// Charge une scène lorsqu'un Gameobject entre dans un trigger. Possibilité de déterminer le temps entre la collision et le changement.

//Important : 
// il faut penser à charger les différentes scènes dans les Build Settings du projet (Add open scene)

public class SceneChangerByTrigger : MonoBehaviour
{

    public string sceneToLoad;
    public float secToChange;

    public GameObject Trigger;

    void OnTriggerEnter(Collider other)
    {

        if (other == Trigger.GetComponent<Collider>())
        {
            Debug.Log("object in trigger");
            Invoke("SceneChange", secToChange);


        }
    }

    private void Start()
    {
        Debug.Log("trigger script loaded");

    }
    void SceneChange()
    {
        SceneManager.LoadSceneAsync(sceneToLoad);
        Debug.Log("loading next scene");
    }

}
