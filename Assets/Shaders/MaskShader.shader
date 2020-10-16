Shader "Custom/MaskShader"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _SecondTex ("Secondary Texture", 2D) = "white" {}
        _Mask ("Mask", 2D) = "white" {}

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard

        sampler2D _MainTex;
        sampler2D _SecondTex;
        sampler2D _Mask;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SecondTex;
            float2 uv_Mask;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half4 MaskData = tex2D(_Mask, IN.uv_Mask);
            half4 FirstData = tex2D(_MainTex, IN.uv_MainTex);
            half4 SecondData = tex2D(_SecondTex, IN.uv_SecondTex);
            float4 finalColor;
            finalColor = FirstData.rgba * MaskData;
            finalColor += SecondData.rgba * (1 - MaskData);
            o.Albedo = saturate(finalColor.rgb);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
