using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeShader : MonoBehaviour {
    [Range (0.0f, 1.0f)]
    public float value;
    public float scaleOffset;
    public float timeOffset;
    Material material;
    // Start is called before the first frame update
    void Start () {
        material = GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update () {
        value = Mathf.PingPong(Time.time / timeOffset, 1);
        material.SetFloat("_Value", value);
        transform.localScale = new Vector3(value + scaleOffset, value + scaleOffset, value + scaleOffset);
    }
}