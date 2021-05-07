using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Ajouté par Rémi
// Provient du projet Buster
// Pour qu'on objet ne se détruise pas lorsqu'on charge une nouvelle scène.

public class DontDestroy : MonoBehaviour {


	void Awake () {
		DontDestroyOnLoad (this);
	}

}
