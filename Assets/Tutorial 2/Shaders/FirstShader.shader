Shader "Custom/FirstShader"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"

			float4  MyVertexProgram(float4 position : POSITION) : SV_POSITION
			{
				return mul(UNITY_MATRIX_MVP,position);
			}

			float4 MyFragmentProgram(float4 position : SV_POSITION) : SV_TARGET
			{
				return 0;
			}

			ENDCG
		}
	}
}
