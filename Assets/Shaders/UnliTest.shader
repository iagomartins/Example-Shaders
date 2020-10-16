Shader "Unlit/UnliTest"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
                float3 normal : NORMAL;
                float4 texcoord1 : TEXCOORD1;
                fixed4 color : COLOR;
                float4 tangent : TANGENT;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal: NORMAL;
                float4 tangent: TANGENT;
                fixed4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.color = v.vertex.x;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //fixed4 col = fixed4(saturate(sin(i.uv.x * 20)) , 0, saturate(sin(i.uv.y * 20)), 1); //tex2D(_MainTex, i.uv);
                //fixed4 c = tex2D(_MainTex, i.uv);
                //fixed4 col = c;
                fixed4 col = i.color;
                return col;
            }
            ENDCG
        }
    }
}
