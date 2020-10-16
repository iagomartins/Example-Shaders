Shader "Iago/EmissionMap"
{
    Properties
    {       
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Emission ("Emission (RGB)", 2D) = "white" {}
        _Alpha ("Alpha (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (0, 0, 0, 0)
        _Intensity ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Emission;
        sampler2D _Alpha;
        half _Intensity;
        half4 _Color;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Emission;
            half _Intensity;
        };

         void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = tex2D (_MainTex, IN.uv_MainTex).a;
            half4 a = tex2D(_Alpha, IN.uv_MainTex);
            o.Emission = tex2D(_Emission, IN.uv_Emission) * _Intensity;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
