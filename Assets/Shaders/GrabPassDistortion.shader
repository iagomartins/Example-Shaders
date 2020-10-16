Shader "Unlit/GrabPassDistortion"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Intensity ("Intensity", Range(0, 50)) = 0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        GrabPass { "_BackgroundTexture" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex: POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _BackgroundTexture;
            half _Intensity;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = ComputeGrabScreenPos(o.pos);
                return o;
            }            

            half4 frag (v2f i) : SV_Target
            {
                i.uv.x += sin((_Time.y + i.uv.y) * _Intensity) / 20;
                half4 bgcolor = tex2Dproj(_BackgroundTexture, UNITY_PROJ_COORD(i.uv));
                return bgcolor;
            }
            ENDCG
        }
    }
}
