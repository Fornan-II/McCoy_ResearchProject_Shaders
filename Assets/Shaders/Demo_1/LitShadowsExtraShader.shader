Shader "Demo1/Lit_Shadows_Extra"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
	}
	SubShader
	{
		//This is why declaring a name for a pass is useful.
		UsePass "Demo1/Lit_Shadows/LIGHTINGPASS"

		UsePass "Demo1/Lit_Shadows/SHADOWCASTER"

		Pass
		{
			
		}
	}
}
