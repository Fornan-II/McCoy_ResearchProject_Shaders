Shader "Demo1/Lit_Shadows_Extra"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		_RimTint("Rim Color", Color) = (0, 0, 0, 0)
		_RimIntensity("Rim Intensity", range(0,5)) = 1
	}
	SubShader
	{
		
		Pass
		{
			Name "LightingPass"
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight	//Unity compiles multiple shaders variants, w/ and w/o shadows. Extra parameters tell Unity to NOT compile the shaders for various lightmaps.
			#include "AutoLight.cginc"

			struct v2f
			{
				float2 uv : TEXCOORD0;
				SHADOW_COORDS(1)
				fixed3 diff : COLOR0;
				fixed3 ambient : COLOR1;
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = nl * _LightColor0;
				o.ambient = ShadeSH9(half4(worldNormal, 1));
				TRANSFER_SHADOW(o)

				return o;
			}

			fixed4 _Color;
			sampler2D _MainTex;

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				//compute shadow attenuation (1.0 = fully lit, 0.0 fully shadowed)
				fixed shadow = SHADOW_ATTENUATION(i);

				//darken light's illumination with shadow, without affecting ambient light.
				fixed3 lighting = i.diff * shadow + i.ambient;

				col.rgb *= _Color * lighting;

				return col;
			}
			ENDCG
		}
		
		//This is why declaring a name for a pass is useful.
		UsePass "Demo1/Lit_Shadows/SHADOWCASTER"
	}
}
