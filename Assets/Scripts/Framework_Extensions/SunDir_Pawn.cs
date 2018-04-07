using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SunDir_Pawn : Pawn {

    protected bool doFastSpeed = false;
    protected bool respondToInput = true;
    protected bool Fire2PreviouslyTrue = false;

    protected Transform _camera;
    protected Vector3 rotation = Vector3.zero;

    public float baseSpeed = 0.0f;
    public float fastSpeed = 0.0f;

    public Demonstration_Object demoObject;

    // Use this for initialization
    protected void Start()
    {
        _camera = FindObjectOfType<Camera>().transform;
    }

    // Update is called once per frame
    protected void Update()
    {
        transform.Rotate(rotation * Time.deltaTime);
    }

    public virtual void Horizontal(float value)
    {
        if (respondToInput)
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
    }

    public virtual void Vertical(float value)
    {
        if (respondToInput)
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
    }

    public virtual void Fire1(bool value)
    {
        if(demoObject && value)
        {
            RaycastHit hitInfo;
            Ray mouseVector = Camera.main.ScreenPointToRay(Input.mousePosition);
            Physics.Raycast(mouseVector, out hitInfo, 100.0f);

            if(hitInfo.collider)
            {
                if(hitInfo.collider.CompareTag("Selectable"))
                {
                    demoObject.SetMaterial(hitInfo.collider.GetComponent<MeshRenderer>().material);
                }
            }
        }
    }

    public virtual void Fire2(bool value)
    {
        if(value && !Fire2PreviouslyTrue)
        {
            respondToInput = !respondToInput;
            Fire2PreviouslyTrue = true;
        }
        
        if(!value)
        {
            Fire2PreviouslyTrue = false;
        }
    }

    public virtual void Fire3(bool value)
    {
        if (respondToInput)
        {
            doFastSpeed = value;
        }
    }
}
