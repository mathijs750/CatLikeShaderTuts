﻿Shader "Custom/FirstShader"
{

	Properties {
		_Tint ("Tint", Color) = (1, 1, 1, 1)
		_MainTex("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"

			float4 _Tint;
			sampler2D _MainTex;
			float4  _MainTex_ST;

			struct Interpolators {
				float4 position : SV_POSITION;
				//float3 localPosition : TEXCOORD0;
				float2 uv : TEXCOORD0;
			};

			struct VertexData {
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			Interpolators MyVertexProgram(VertexData v)
			{
				Interpolators i;
				//i.localPosition = v.position.xyz;
				i.position = mul(UNITY_MATRIX_MVP, v.position);
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return i;
			}

			float4 MyFragmentProgram(Interpolators i) : SV_TARGET
			{
				return tex2D(_MainTex, i.uv)*_Tint;//return float4(i.uv,0,1); // 
			}

			ENDCG
		}
	}
}
