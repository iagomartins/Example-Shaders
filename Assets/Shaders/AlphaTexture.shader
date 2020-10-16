Shader "Iago/AlphaTexture"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Alpha ("Albedo (RGB)", 2D) = "white" {}
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
        sampler2D _Alpha;
        half3 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            float3 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            half3 a = tex2D (_Alpha, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = a.r;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
