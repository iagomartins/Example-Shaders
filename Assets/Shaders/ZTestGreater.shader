Shader "ZTest" 
{     
    Properties 
    {
            _Color ("Cor", Color) = (1,0,0,1)
            [Enum(UnityEngine.Rendering.CompareFunction)] _Mode("Cull", Float) = 0 
                }     
                SubShader 
                {
                            Pass 
                            {
                                    ZTest [_Mode]             
                                    Material { Diffuse [_Color] }             
                                    Lighting On         
                                    }
                        }
            }