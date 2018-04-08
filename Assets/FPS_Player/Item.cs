using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Item : Interactable {

    protected virtual void Start()
    {
        verb = "picks up";
    }

    /// <summary>
    /// The basic interaction of an item while it's in the world is to have the FPS_Pawn equip it.
    /// </summary>
    /// <param name="source"></param>
    /// <param name="instigator"></param>
    /// <returns>Return true if the item is equipped</returns>
    protected override bool ProcessInteraction(Actor source, Controller instigator)
    {
        FPS_Pawn fpp = source.GetComponent<FPS_Pawn>();
        if(fpp)
        {
            return fpp.Equip(this);
        }
        return false;
    }

    /// <summary>
    /// The method meant to be called when player has equipped the item.
    /// This is the main function to override in inheriting classes.
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    public virtual bool Use(Actor user)
    {
        INTERACTLOG(user.name + " uses " + ActorName);
        return true;
    }
}
