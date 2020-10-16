Shader "Iago/DissolveShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Effect", 2D) = "white" {}
        _Slider ("Transition", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:blend



        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        half _Slider;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex).r;
            o.Albedo = _Color;
            o.Alpha = saturate(((c < _Slider) ? 0 : 1));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
