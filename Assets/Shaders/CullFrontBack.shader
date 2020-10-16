Shader "Unlit/CullFrontBack"
{
    Properties
    {
        _ColorOutside ("Cor de Fora", Color) = (0, 0, 1, 1)
    }
    SubShader
    {
        Pass
        {
            Cull Back
            Material {
                Diffuse [_ColorOutside]
            }
            Lighting On
        }
    }
}
