using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractOrb : Interactable {

    public Material[] effects;
    protected int _effectIndex = 0;

    public override bool InteractWith(Actor source, Controller instigator = null)
    {
        ScreenEffect sc = source.GetComponentInChildren<ScreenEffect>();
        if (!sc)
        {
            return false;
        }

        sc.imageEffectMat = effects[_effectIndex];

        _effectIndex++;
        if(_effectIndex >= effects.Length)
        {
            _effectIndex = 0;
        }

        return true;
    }
}
