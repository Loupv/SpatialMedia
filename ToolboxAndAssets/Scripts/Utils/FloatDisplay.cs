using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

// Ajouté par Rémi
// Provient du projet Montage Spatial
// Affiche une variable.

public class FloatDisplay : MonoBehaviour
{
    public TextMeshPro textDisplayed;
    public float floatToDisplay;

    void Start()
    {
        textDisplayed.text = "Some text";
    }

    void Update()
    {
        textDisplayed.text = floatToDisplay.ToString();  // make it a string to output to the Text object
    }
}
