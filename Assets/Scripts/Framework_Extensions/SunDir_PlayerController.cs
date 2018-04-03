using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SunDir_PlayerController : PlayerController {

    public Pawn pawnToControl;

    // Use this for initialization
    protected override void Start()
    {
        doRequestSpawn = false;
        base.Start();
        LogInputStateInfo = false;
        IsHuman = true;
        if(pawnToControl)
        {
            PossesedPawn = pawnToControl;
        }
    }

    // Update is called once per frame
    protected void Update()
    {

    }

    public override void Horizontal(float value)
    {
        SunDir_Pawn SDP = (SunDir_Pawn)PossesedPawn;
        if(SDP)
        {
            SDP.Horizontal(value);
        }
    }

    public override void Vertical(float value)
    {
        SunDir_Pawn SDP = (SunDir_Pawn)PossesedPawn;
        if (SDP)
        {
            SDP.Vertical(value);
        }
    }

    public override void Fire1(bool value)
    {
        SunDir_Pawn SDP = (SunDir_Pawn)PossesedPawn;
        if (SDP)
        {
            SDP.Fire1(value);
        }
    }
}
