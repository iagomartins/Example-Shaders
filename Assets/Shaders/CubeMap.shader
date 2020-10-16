Shader "Iago/Cube Map"
{
    Properties
    {
        _ReflectionTex ("Cube Map", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard

        struct Input
        {
            float2 uv_MainTex;
            float3 worldRefl;
        };

        samplerCUBE _ReflectionTex;

        void surf (Input IN, inout SurfaceOutputStandard o)
        { 
            o.Emission = texCUBE(_ReflectionTex, IN.worldRefl).rgb;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
