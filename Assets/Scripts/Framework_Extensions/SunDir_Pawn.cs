using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SunDir_Pawn : Pawn {

    protected bool doFastSpeed = false;
    public float baseSpeed = 0.0f;
    public float fastSpeed = 0.0f;
    protected Vector3 rotation = Vector3.zero;

    // Use this for initialization
    protected void Start()
    {

    }

    // Update is called once per frame
    protected void Update()
    {
        transform.Rotate(rotation * Time.deltaTime);
    }

    public virtual void Horizontal(float value)
    {
        if (doFastSpeed)
        {
            rotation.x = value * fastSpeed;
        }
        else
        {
            rotation.x = value * baseSpeed;
        }
    }

    public virtual void Vertical(float value)
    {
        if (doFastSpeed)
        {
            rotation.y = value * fastSpeed;
        }
        else
        {
            rotation.y = value * baseSpeed;
        }
    }

    public virtual void Fire1(bool value)
    {
        doFastSpeed = value;
    }
}
