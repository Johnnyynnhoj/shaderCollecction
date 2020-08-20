// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/surfaceDoublePass"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
		        _OutlineColor("Outline Color", Color) = (0,1,0,1)
        _Outline("Outline width", Range(0.002, 1)) = 0.01
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
		Cull off


	




        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

		
        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG



			Pass {
			            Name "OUTLINE"
            Tags{ "LightMode" = "Always" }

            Cull Front
            ZWrite On
            ColorMask RGB
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            uniform float _Outline;
            uniform float4 _OutlineColor;

            struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            float4 vert(appdata v) : SV_POSITION{
                float4 pos = UnityObjectToClipPos(v.vertex);
                float3 norm = mul((float3x3)UNITY_MATRIX_MV, v.normal);
                norm.x *= UNITY_MATRIX_P[0][0];
                norm.y *= UNITY_MATRIX_P[1][1];
                pos.xy += norm.xy * pos.z * _Outline;
                return pos;
            }

            float4 frag() : SV_TARGET{
                return  _OutlineColor;
            }
            ENDCG
		
		}
    }
    FallBack "Diffuse"
}
