// Outline勾边渲染

uniform float _Outline = 0.35;

v2f_basic OutlineVert(appdata v)
{
	v2f_basic o;
	UNITY_INITIALIZE_OUTPUT(v2f_basic, o);
	o.uv = v.uv;
	o.color = v.color;
	float3 pos = UnityObjectToViewPos(v.vertex);
	float3 normal = mul((float3x3)UNITY_MATRIX_IT_MV, v.normal);
	normal.z = -0.5;
	float distance = abs(pos.z);
	pos = pos + normalize(normal) * _Outline / 500 * distance * v.color.b;
	o.pos = UnityViewToClipPos(pos);

	half3 lightWorldDir = UnityWorldToObjectDir(-normalize(_LightInfo.xyz));
	o.params.x = dot(normalize(v.normal), normalize(lightWorldDir));
	float3 viewDir = ObjSpaceViewDir(v.vertex);
	o.params.y = 1 - dot(v.normal, normalize(viewDir));
	o.params.z = distance;
	return o;
}

half4 OutlineFrag(v2f_basic i) : COLOR
{
	clip(0.01 - _DissolveFactor);
	half4 final = BasicFrag(i);
	//final.rgb = final.rgb - 0.1;
	final.rgb *= final.rgb * 0.85;
	final.rgb = lerp(final.rgb,half3(1,1,1),_AddExposure);
	return final;
}