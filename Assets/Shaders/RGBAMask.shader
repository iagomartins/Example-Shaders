Shader "Iago/RGBAMask"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Color1 ("Color", Color) = (1,1,1,1)
        _Color2 ("Color", Color) = (1,1,1,1)
        _Color3 ("Color", Color) = (1,1,1,1)
        _Color4 ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        float4 _Color1;
        float4 _Color2;
        float4 _Color3;
        float4 _Color4;
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            float4 c = tex2D (_MainTex, IN.uv_MainTex);
            half a = (1 - c.a);
            o.Emission = c.r * _Color1 + c.g * _Color2 + c.b * _Color3 + a * _Color4;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
