Shader "Unlit/Explosion"
{
    Properties
    {
        _RampTex ("Color Ramp", 2D) = "white" {}
        _NoiseTex ("Color Ramp", 2D) = "white" {}
        _Amount("Amount", Range(0, 0.5)) = 0.2
        _Value("Value", Range(0, 1)) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal: NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _RampTex;
            float4 _RampTex_ST;
            sampler2D _NoiseTex;
            float4 _NoiseTex_ST;
            half _Amount;
            half _Value;

            v2f vert (appdata v)
            {
                v2f o;
                o.uv = TRANSFORM_TEX(v.uv, _NoiseTex);
                float3 disp = tex2Dlod(_NoiseTex, float4(o.uv.xy, 0, 0));
                float time = sin(_Time.x * disp.r * 10);
                v.vertex.xyz += v.normal * disp.r * _Amount * time;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 pos = half2(_Time.x, _Time.x/2);
                float3 noise = tex2D(_NoiseTex, i.uv + pos);
                float n = saturate(noise.r + _Value - 0.5);
                clip((1 - _Value) * 2 - n);
                return tex2D(_RampTex, float2(n, 0.5));
            }
            ENDCG
        }
    }
}
