using UnityEngine;
using System.Collections;


[RequireComponent (typeof(MeshFilter), typeof(MeshRenderer))]
public class PointCloud : MonoBehaviour
{

	public Mesh mesh, previousMesh;
	//int numPoints = 60000;

	// Use this for initialization
	void Start ()
	{
		
		mesh = GetComponent<MeshFilter> ().mesh;
		mesh.SetIndices (mesh.GetIndices (0), MeshTopology.Points, 0);
	}


}