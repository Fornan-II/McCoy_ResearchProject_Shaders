using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ResetFall : MonoBehaviour {

    public float YKillLevel = -128.0f;

    public SpawnPoint resetPoint;

	// Use this for initialization
	void Start () {
		
	}
	
	void FixedUpdate () {
		if(transform.position.y < YKillLevel)
        {
            if (!resetPoint)
            {
                resetPoint = FindObjectOfType<SpawnPoint>();
            }

            transform.position = resetPoint.transform.position;
        }
	}
}
