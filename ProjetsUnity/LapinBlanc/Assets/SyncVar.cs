using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Mirror;


public class SyncVar : NetworkBehaviour
{

    [SyncVar(hook = nameof(SetColor))]
    Color32 _color = Color.red;

    //[SyncVar(hook = nameof(SetPosition))]
    //Vector3 _position;

    // Start is called before the first frame update
    public override void OnStartServer()
    {
        base.OnStartServer();
        //_position = new Vector3(Random.Range(-2f, 2f), 0, 0);
        StartCoroutine(_RandomizeColor());
    }

    // Update is called once per frame
    void SetColor(Color32 oldColor, Color32 newColor)
    {

        MeshRenderer renderer = GetComponent<MeshRenderer>();
        renderer.materials[0].color = newColor;

    }

    /*void SetPosition(Vector3 oldPosition, Vector3 newPosition)
    {
        GetComponent<Transform>().position = newPosition;
    }*/

    private IEnumerator _RandomizeColor()
    {
        WaitForSeconds wait = new WaitForSeconds(2f);

        while(true)
        {
            yield return wait;
            _color = Random.ColorHSV(0f, 1f, 1f, 1f, 0f, 1f, 1f, 1f);
        }
    }

}
