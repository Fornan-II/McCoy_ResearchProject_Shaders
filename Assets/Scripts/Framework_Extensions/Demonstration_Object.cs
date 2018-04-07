using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Demonstration_Object : MonoBehaviour {

    SkinnedMeshRenderer _mr;
    

    private void Start()
    {
        _mr = GetComponent<SkinnedMeshRenderer>();
    }

    public void SetMaterial(Material m)
    {
        //Debug.Log("Material changed.");
        _mr.material = m;
    }
}
