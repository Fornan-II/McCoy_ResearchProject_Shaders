Shader "Custom/Overlay Shader" {
	Properties{
		_MainTex("Body Texture", 2D) = "white" {}
		_SecondTex("Overlay Texture", 2D) = "green" {}
		_GrassSpread("Grass Spread", Range(-1, 1)) = 0.5
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SecondTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
			float3 worldNormal;
		};

		half _Glossiness;
		half _Metallic;
		half _GrassSpread;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			float3 x = tex2D(_MainTex, IN.worldPos.zy);
			float3 y = tex2D(_MainTex, IN.worldPos.zx);
			float3 z = tex2D(_MainTex, IN.worldPos.xy);

			if (dot(o.Normal, IN.worldNormal.y >= _GrassSpread))
			{
				x = tex2D(_SecondTex, IN.worldPos.zy);
				y = tex2D(_SecondTex, IN.worldPos.zx);
				z = tex2D(_SecondTex, IN.worldPos.xy);
			}

			float3 blendNormal = saturate(pow(IN.worldNormal * 1.4, 4));
			float3 blendedTex = z;
			blendedTex = lerp(blendedTex, x, blendNormal.x);
			blendedTex = lerp(blendedTex, y, blendNormal.y);

			o.Albedo = blendedTex;

			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
