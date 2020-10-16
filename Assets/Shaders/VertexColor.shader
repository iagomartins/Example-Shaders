Shader "Iago/VertexColor" {
Properties { _MainTex ("Albedo (RGB)", 2D) = "white" {} }
SubShader {
CGPROGRAM

#pragma surface surf Standard vertex:vert

struct appdata {
	float4 vertex:POSITION;
	float3 normal:NORMAL;
	float4 color: COLOR;
};

struct Input {
	float4 color; 
};

void vert(inout appdata v, out Input o){
	UNITY_INITIALIZE_OUTPUT(Input, o);
	o.color = v.color;
}

void surf (Input IN, inout SurfaceOutputStandard o) {
	o.Albedo = IN.color;
}

	ENDCG
	}
	FallBack "Diffuse"
}