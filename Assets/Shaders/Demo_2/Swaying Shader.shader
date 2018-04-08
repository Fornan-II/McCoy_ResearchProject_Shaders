Shader "Demo2/Swaying"
{
	Properties
	{
		[NoScaleOffset] _MainTex("Texture", 2D) = "white" {}
		_Speed("Sway Speed",Range(20,50)) = 25
		_Rigidness("Rigidness",Range(1,50)) = 25
		_SwayMax("Sway Max",Range(0,0.1)) = 0.05
		_YOffset("Y Offset",float) = 0.5
	}
		SubShader
		{
			Pass
			{
				Name "LightingPass"
				Tags {"LightMode" = "ForwardBase"}

				CGPROGRAM

				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
				#include "AutoLight.cginc"

				float _Speed;
				float _Rigidness;
				float _SwayMax;
				float _YOffset;

			struct v2f
			{
				float2 uv : TEXCOORD0;
				SHADOW_COORDS(1)
				fixed3 diff : COLOR0;
				fixed3 ambient : COLOR1;
				float4 pos : SV_POSITION;
			};

			v2f vert (appdata_base v)
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
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed shadow = SHADOW_ATTENUATION(i);
				fixed3 lighting = i.diff * shadow + i.ambient;
				
				col.rgb *= _Color * lighting;
				
				return col;
			}
			ENDCG
		}

		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
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
