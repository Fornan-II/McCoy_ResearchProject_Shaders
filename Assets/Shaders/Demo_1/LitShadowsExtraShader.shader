// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Demo1/Lit_Shadows_Extra"
{
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		_RimTint("Rim Color", Color) = (0, 0, 0, 0)
		_RimIntensity("Rim Intensity", range(0,10)) = 1
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
			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
			#include "AutoLight.cginc"

			struct v2f
			{
				float2 uv : TEXCOORD0;
				SHADOW_COORDS(1)
				float4 posWorld : TEXCOORD2;											//This is new
				float3 normal : NORMAL;													//This is new
				fixed3 diff : COLOR0;
				fixed3 ambient : COLOR1;
				float4 pos : SV_POSITION;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.posWorld = mul(unity_ObjectToWorld, v.vertex);						//This is new
				o.normal = mul(float4(v.normal, 0.0), unity_ObjectToWorld);				//This is new
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
			fixed4 _RimTint;
			float _RimIntensity;

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed shadow = SHADOW_ATTENUATION(i);
				fixed3 lighting = i.diff * shadow + i.ambient;
				col.rgb *= _Color * lighting;

				float3 viewDirection = normalize(_WorldSpaceCameraPos - i.posWorld);	//This is new
				half rim = 1.0 - saturate(dot(viewDirection, i.normal));				//This is new
				
				col += rim * _RimTint * _RimIntensity;

				return col;
			}
			ENDCG
		}
		
		//This is why declaring a name for a pass is useful.
		UsePass "Demo1/Lit_Shadows/SHADOWCASTER"
	}
}
