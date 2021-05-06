using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshCreator : MonoBehaviour
{


    public GameObject obj1, obj2, obj3, obj4;

    void Start()
    {

    }

    void Update()
    {
        /*Mesh mesh = GetComponent<MeshFilter>().mesh;

        mesh.Clear();
        mesh.vertices = new Vector3[] { obj1.transform.position, obj2.transform.position, obj3.transform.position };
        mesh.uv = new Vector2[] { new Vector2(0, 0), new Vector2(0, 1), new Vector2(1, 1)};
        mesh.quad = new int[] { 0, 1, 2};
        */

        //Mesh mesh = GetComponent<MeshFilter>().mesh;
        Mesh mesh = new Mesh();

        mesh.Clear();

        Vector3[] vertices = new Vector3[4]
        {
            obj1.transform.position, obj3.transform.position, obj2.transform.position,  obj4.transform.position
        };
        mesh.vertices = vertices;

        int[] tris = new int[6]
        {
            // lower left triangle
            0, 2, 1,
            // upper right triangle
            2, 3, 1
        };
        mesh.triangles = tris;

        Vector3[] normals = new Vector3[4]
        {
            -Vector3.forward,
            -Vector3.forward,
            -Vector3.forward,
            -Vector3.forward
        };
        mesh.normals = normals;

        Vector2[] uv = new Vector2[4]
        {
            new Vector2(0, 0),
            new Vector2(1, 0),
            new Vector2(0, 1),
            new Vector2(1, 1)
        };
        mesh.uv = uv;

        GetComponent<MeshFilter>().mesh = mesh;



    }

}
