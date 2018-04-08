using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FPS_InputPoller : InputPoller {

    public override InputState GetPlayer1Input()
    {
        // Example Input binding. 
        InputState IS = InputState.GetBlankState();
        IS.AddAxis("LookHorizontal", Input.GetAxis("Mouse Y"));
        IS.AddAxis("LookVertical", Input.GetAxis("Mouse X"));
        IS.AddAxis("MoveHorizontal", Input.GetAxis("Horizontal"));
        IS.AddAxis("MoveVertical", Input.GetAxis("Vertical"));
        IS.AddButton("Fire1", Input.GetButtonDown("Fire1"));
        IS.AddButton("Fire2", Input.GetButton("Fire2"));    //This will be changed to GetButtonDown when lighter is implimented
        IS.AddButton("Fire3", Input.GetButton("Fire3"));
        IS.AddButton("Fire4", Input.GetButtonDown("Fire4"));
        IS.AddButton("Cancel", Input.GetButtonDown("Cancel"));
        return IS;
    }
}
