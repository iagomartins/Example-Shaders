Shader "Iago/BumpMapping"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpTex ("Bump (RGB)", 2D) = "black" {}
        _Size ("Size", Range(-2,2)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert



        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpTex;
        };

        sampler2D _MainTex;
        sampler2D _BumpTex;
        half _Size;

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
            o.Normal *= float3(_Size, _Size, 1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
