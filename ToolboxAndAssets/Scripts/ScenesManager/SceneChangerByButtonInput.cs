using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

// Ajouté par Rémi
// Provient du projet Buster
// Charge une scène affectée à un bouton. Possibilité de déterminer le temps avant le changement.

//Important : 
// il faut penser à charger les différentes scènes dans les Build Settings du projet (Add open scene)
// les bouttons sont définis dans project settings -> input manager. C'est le nom qu'il faut indiquer dans la variable.

public class SceneChangerByButtonInput : MonoBehaviour
{
    public string[] Button;

    public string[] sceneToLoad;

    public float secToChange;



    void Update()
    {
        for (int i = 0; i < Button.Length; i++)
        {


            if (Input.GetButtonDown(Button[i]))
            {

                //SceneManager.LoadSceneAsync(sceneToLoad[i]);
                StartCoroutine(SceneChange(i));
                

            }

        }

    }

    IEnumerator SceneChange(int j)
    {
        yield return new WaitForSeconds(secToChange);
        SceneManager.LoadSceneAsync(sceneToLoad[j]);
        Debug.Log("Load scene " + j);

    }
}
