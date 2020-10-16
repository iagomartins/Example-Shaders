Shader "Custom/TextureAnimation"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Speed ("Speed", Range(1,10)) = 1.0
        _Cols ("Columns", Range(1,10)) = 1.0
        _Rows ("Rows", Range(1,10)) = 1.0
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        half _Speed;
        half _Cols, _Rows;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half colsize = 1/_Cols;
            half rowsize = 1/_Rows;

            half t1 = _Time.y * _Speed;

            half px = floor(t1 % _Cols);
            half py = floor((t1 / _Cols) % _Rows);

            half x = (IN.uv_MainTex.x + px) * colsize;
            half y = (IN.uv_MainTex.y + py) * rowsize;
            half2 pos = half2(x, y);

            fixed4 c = tex2D(_MainTex, pos);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
