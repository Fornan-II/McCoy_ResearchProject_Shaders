Shader "Demo1/Lit_Shadows"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			Name "LightingPass"	//Declaring a name for a pass is not necessary, but useful. Will return to this later.
			Tags {"LightMode" = "ForwardBase"}

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
				SHADOW_COORDS(1)	//puts shadows data into TEXCOORD1
				fixed3 diff : COLOR0;
				fixed3 ambient : COLOR1;
				float4 pos : SV_POSITION;	//Sometimes variable naming does need to be specific. TRANSFER_SHADOW needs this to be called "pos", not something like "vertex".
			};

			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = nl * _LightColor0;
				
				//Code that starts to look different from basic Lit shader. Slightly different way of applying illumination from ambient or light probes. Important in this particular frag shader implementation.
				o.ambient = ShadeSH9(half4(worldNormal, 1));
				//compute shadows data
				TRANSFER_SHADOW(o)

				return o;
			}

			fixed4 _Color;
			sampler2D _MainTex;
			
			fixed4 frag (v2f i) : SV_Target
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

		//Second pass to allow object to cast and recieve shadows. A "shadow pass".
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			//We’ve used the #pragma multi_compile_shadowcaster directive.
			//This causes the shader to be compiled into several variants with different
			//preprocessor macros defined for each. When rendering into the shadowmap, the
			//cases of point lights vs other light types need slightly different shader code,
			//that’s why this directive is needed.
			//(Taken from the Unity Manual Vertex and Fragment Shader Example Page)
			#include "UnityCG.cginc"

			struct v2f
			{
				V2F_SHADOW_CASTER;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				SHADOW_CASTER_FRAGMENT(i)
			}
				ENDCG
		}
	}
}
