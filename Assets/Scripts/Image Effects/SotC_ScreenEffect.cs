using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SotC_ScreenEffect : MonoBehaviour {

    public Material imageEffectMat;

    //By nature of having this particular function, this script now functions as an image effect script.
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, imageEffectMat);
    }
}
