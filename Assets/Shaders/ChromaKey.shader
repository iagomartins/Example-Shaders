Shader "ChromaKey"
{
    Properties
    {
        _FrontTex ("Image (RGB)", 2D) = "white" {}
        _BackTex ("Background (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1, 1, 0, 1)
    }
    SubShader
    {
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"

            uniform sampler2D _BackTex;

            fixed4 frag(v2f_img i):SV_Target 
            {
                return tex2D(_BackTex, i.uv);
            }

            ENDCG
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #include "UnityCG.cginc"

            fixed4 _Color;
            uniform sampler2D _FrontTex;

            fixed4 frag(v2f_img i):SV_Target 
            {
                fixed4 r = tex2D(_FrontTex, i.uv);
                if(r.g >= _Color.g)
                {
                    r.a = r.g = r.r = r.b = 0;
                }
                return r;
            }

            ENDCG
        }
    }
}
