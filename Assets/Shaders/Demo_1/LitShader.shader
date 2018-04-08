Shader "Demo1/Lit"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		_AmbientAmount("Ambient Lighting Percent", range(0,1)) = 1
	}
		SubShader
	{
		Pass
		{
			//Tell Unity's rendering pipeline the way we will be rendering. Here, using the default forward rendering.
			//Unity has been told to pass in directional light data via built-in variables such as _WorldSpaceLightPos0 and _LightColor0
			Tags {"LightMode"="ForwardBase"}

			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"	//for UnityObjectToWorldNormal and appdata_base
			#include "UnityLightingCommon.cginc"	//for _LightColor
			
			struct v2f
			{
				float2 uv : TEXCOORD0;
				fixed4 diff : COLOR0;	//Diffuse lighting color
				float4 vertex : SV_POSITION;
			};
			
			float _AmbientAmount; //Not important, I added this mainly for demonstration purposes.

			//appdata_base is a position, normal, and one texture coordinate.
			//this is found in "UnityCG.cginc"
			v2f vert (appdata_base v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;

				//Get vertex normal in world space
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);

				//Get dot product between normal and light direction
				//This is standard diffuse lighting
				half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));

				//apply light color
				o.diff = nl * _LightColor0;

				//Apply illumination from ambient or light probes.
				//ShadeSH9 is a function from "UnityCG.cginc"
				o.diff.rgb += _AmbientAmount * ShadeSH9(half4(worldNormal, 1));

				return o;
			}

			fixed4 _Color;
			sampler2D _MainTex;
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= _Color * i.diff;
				
				return col;
			}
			ENDCG
		}
	}
}
