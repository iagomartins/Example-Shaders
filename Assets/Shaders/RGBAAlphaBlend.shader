Shader "Custom/RGBAAlphaBlend"
{
    Properties
    {
        _AlphaTexture ("Alpha Texture (RGB)", 2D) = "white" {}
        _RedTexture ("Red Texture (RGB)", 2D) = "white" {}
        _GreenTexture ("Green Texture (RGB)", 2D) = "white" {}
        _BlueTexture ("Blue Texture (RGB)", 2D) = "white" {}
        _BlendTexture ("Blend Texture (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM

        #pragma surface surf Standard fullforwardshadows alpha:blend
        #pragma target 4.0

        sampler2D _AlphaTexture;
        sampler2D _RedTexture;
        sampler2D _GreenTexture;
        sampler2D _BlueTexture;
        sampler2D _BlendTexture;

        struct Input
        {
            float2 uv_AlphaTexture;
            float2 uv_RedTexture;
            float2 uv_GreenTexture;
            float2 uv_BlueTexture;
            float2 uv_BlendTexture;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half4 alphaData = tex2D(_AlphaTexture, IN.uv_AlphaTexture);
            half4 blendData = tex2D (_BlendTexture, IN.uv_BlendTexture);
            half4 redData = tex2D (_RedTexture, IN.uv_RedTexture);
            half4 greenData = tex2D (_GreenTexture, IN.uv_GreenTexture);
            half4 blueData = tex2D (_BlueTexture, IN.uv_BlueTexture);
            float4 finalColor = alphaData.rgba * (1-blendData.a);
            finalColor += redData.rgba * blendData.r*(blendData.a);
            finalColor += greenData.rgba * blendData.r*(blendData.a);
            finalColor += blueData.rgba * blendData.r*(blendData.a);
            o.Albedo = saturate(finalColor.rgb);
            o.Alpha = 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
