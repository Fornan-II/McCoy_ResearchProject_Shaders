// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Demo1/Unlit Texture"
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
			CGPROGRAM
			//vert is the name of the function that is used as the vertex shader
			#pragma vertex vert
			//frag is the name of the function that is used as the fragment shader
			#pragma fragment frag
			
			struct appdata
			{
				float4 vertex : POSITION;	//vertex position
				float2 uv : TEXCOORD0;		//texture coordinate
			};

			struct v2f
			{
				float2 uv: TEXCOORD0;
				float4 vertex : SV_POSITION;//clip space position
			};

			v2f vert (appdata v)
			{
				v2f output;
				//Multiplying v2f.vertex by "Model View Projection" matrix.
				output.vertex = UnityObjectToClipPos(v.vertex);
				output.uv = v.uv;
				return output;
			}

			sampler2D _MainTex;
			fixed4 _Color;
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				col *= _Color;
				return col;
			}
			ENDCG
		}
	}
}
