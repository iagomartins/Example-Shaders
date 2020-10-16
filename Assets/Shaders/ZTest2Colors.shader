Shader "BehindColor" 
{     
    Properties 
                {
                    _ColorBase ("Cor Base", Color) = (1,0,0,1)         
                    _ColorBehind ("Cor Atrás", Color) = (1,0,0,1)     
                }     
                SubShader 
                {         
                    Pass {             
                        ZTest LEqual             
                        Material { Diffuse [_ColorBase] }             
                        Lighting On         
                        }         
                    Pass {             
                        ZTest Greater             
                        Material { Diffuse [_ColorBehind] }             
                        Lighting On         
                        }     
                } 
}