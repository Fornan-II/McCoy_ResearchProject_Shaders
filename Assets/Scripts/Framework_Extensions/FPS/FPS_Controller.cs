using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FPS_Controller : PlayerController {

	// Use this for initialization
	protected override void Start () {
        base.Start();
        LogInputStateInfo = false;
        LogHUDUpdateError = false;
	}

    public override void DefaultBinds()
    {
        AddAxis("LookHorizontal", LookHorizontal);
        AddAxis("LookVertical", LookVertical);
        AddAxis("MoveHorizontal", Horizontal);
        AddAxis("MoveVertical", Vertical);
        AddButton("Fire1", Fire1);
        AddButton("Fire2", Fire2);
        AddButton("Fire3", Fire3);
        AddButton("Fire4", Fire4);
        AddButton("Cancel", Cancel);
    }

    public virtual void LookHorizontal(float value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if(FPP)
        {
            FPP.LookHorizontal(value);
        }
    }

    public virtual void LookVertical(float value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.LookVertical(value);
        }
    }

    public override void Horizontal(float value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.MoveHorizontal(value);
        }
    }

    public override void Vertical(float value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.MoveVertical(value);
        }
    }

    public override void Fire1(bool value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.Fire1(value);
        }
    }

    public override void Fire2(bool value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.Fire2(value);
        }
    }

    public override void Fire3(bool value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.Fire3(value);
        }
    }

    public override void Fire4(bool value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP)
        {
            FPP.Fire4(value);
        }
    }

    public virtual void Cancel(bool value)
    {
        FPS_Pawn FPP = (FPS_Pawn)PossesedPawn;
        if (FPP && value)
        {
            FPP.SetCursorLock(false);
        }
    }
}
