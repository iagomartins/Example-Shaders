Shader "Custom/CullFront"
{
    Properties
    {
        _Color ("Color", Color) = (1,0,0,1)
        _Color2 ("Color", Color) = (0,0,1,1)
    }
    SubShader
    {
        Pass 
        {
            ZWrite Off
            Cull Front
            Material
            {
                Diffuse [_Color]
            }
            Lighting On
        }

        Pass 
        {
            Cull Back
            Material
            {
                Diffuse [_Color2]
            }
            Lighting On
        }
    }
    FallBack "Diffuse"
}
