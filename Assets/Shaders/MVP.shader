Shader "MVP"
{
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
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                half4 color : COLOR;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                // o.vertex = v.vertex; //MODEL
                o.color = half4(UnityObjectToViewPos(v.vertex), 1); //Model * View
                // o.color = UnityObjectToClipPos(v.vertex); //Model*View*Projection
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return i.color.r;
            }
            ENDCG
        }
    }
}
