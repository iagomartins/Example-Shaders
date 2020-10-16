Shader "Iago/Explode" {
Properties {
_Slider ("Explosion", Range(0,1)) = 0.0
}
 
SubShader {
Tags{"Queue"="Transparent"}
CGPROGRAM
#pragma surface surf Standard vertex:vert alpha:blend
struct appdata {
float4 vertex: POSITION;
float3 normal: NORMAL;
};
struct Input{
float2 uv_MainTex;
};
sampler2D _MainTex;
float _Slider;
void vert(inout appdata v){
v.vertex.xyz += v.normal * 0.1 * _Slider;
}
void surf (Input IN, inout SurfaceOutputStandard o) {
o.Albedo = half3(1, 1, 1);
o.Alpha = saturate(1.0 - _Slider * 3);
}
ENDCG
}
}