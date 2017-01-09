﻿Shader "Custom/First Lighting Shader"
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
				float2 uv : TEXCOORD0;
				float3 normal : TEXCOORD1;
			};

			struct VertexData {
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			Interpolators MyVertexProgram(VertexData v)
			{
				Interpolators i;
				i.normal = mul(unity_ObjectToWorld, float4(v.normal, 0));
				i.normal = normalize(i.normal); // normalize to make shaling work
				i.position = mul(UNITY_MATRIX_MVP, v.position);
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return i;
			}

			float4 MyFragmentProgram(Interpolators i) : SV_TARGET
			{
				return float4(i.normal * 0.5 + 0.5, 1);
			}

			ENDCG
		}
	}
}
