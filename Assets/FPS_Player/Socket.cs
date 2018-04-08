using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Socket : MonoBehaviour {

    public virtual bool HasItem
    {
        get { return _equippedItem; }
    }

    public virtual Item EquippedItem
    {
        get { return _equippedItem; }
    }

    protected Item _equippedItem;
    protected Collider _itemCol;
    protected Rigidbody _itemRB;
    protected bool[] _rbSettings = { true, false, true };

    protected virtual void Update()
    {
        if (HasItem)
        {
            _equippedItem.transform.position = transform.position;
            _equippedItem.transform.rotation = transform.rotation;
        }
    }

    public virtual bool Equip(Item item)
    {
        if (HasItem || !item)
        {
            return false;
        }

        _equippedItem = item;

        //Check for and disable collision collider.
        Collider[] colliders = item.GetComponents<Collider>();
        foreach(Collider col in colliders)
        {
            if(!col.isTrigger)
            {
                _itemCol = col;
            }
        }
        if(_itemCol)
        {
            _itemCol.enabled = false;
        }

        //Check for and disable rigidbody physics
        _itemRB = item.GetComponent<Rigidbody>();
        if(_itemRB)
        {
            _rbSettings[0] = _itemRB.detectCollisions;
            _rbSettings[1] = _itemRB.freezeRotation;
            _rbSettings[2] = _itemRB.useGravity;

            _itemRB.detectCollisions = false;
            _itemRB.freezeRotation = true;
            _itemRB.useGravity = false;
        }
        
        return true;
    }

    public virtual bool Unequip()
    {
        if(!HasItem)
        {
            return false;
        }

        _equippedItem = null;

        //Re-enable collision collider if it exists
        if (_itemCol)
        {
            _itemCol.enabled = true;
        }
        _itemCol = null;

        //Re-enable rigidbody if it exists
        if (_itemRB)
        {
            _itemRB.detectCollisions = _rbSettings[0] ;
            _itemRB.freezeRotation = _rbSettings[1];
            _itemRB.useGravity = _rbSettings[2];
        }

        return true;
    }

    public virtual bool UseItem(Actor user)
    {
        if(!HasItem)
        {
            return false;
        }

        return _equippedItem.Use(user);
    }
}
