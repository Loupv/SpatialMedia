using UnityEngine;
 using System.Collections;
 
 [RequireComponent(typeof(MeshCollider))]
 
 public class GizmoController : MonoBehaviour 
 {

    public bool draggable;

    public Mirror.NetworkIdentity networkIdentity;


    private void Start()
    {
        networkIdentity = transform.parent.GetComponent<Mirror.NetworkIdentity>();
    }

    void OnMouseDrag()
         {
            if (draggable && networkIdentity.isLocalPlayer)
            {
                float distance_to_screen = Camera.main.WorldToScreenPoint(gameObject.transform.position).z;
                Vector3 pos_move = Camera.main.ScreenToWorldPoint(new Vector3(Input.mousePosition.x, Input.mousePosition.y, distance_to_screen));
                transform.position = new Vector3(pos_move.x, pos_move.y, transform.position.z);
            }
         }


 
 }