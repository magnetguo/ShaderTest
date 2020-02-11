
float4 VertCalaShadow(float4 posW, half _DirX, half _DirY)
{
	posW.x = posW.x / 6000 * _DirX;
	posW.y = posW.z / 6000 * _DirY;
	return posW;
}
half4 FragCalaShadow(fixed4 col, fixed4 posW, fixed _Time_y, fixed _Speed, fixed _IsRotate, fixed _ShadowAlphaRatio, sampler2D _ShadowTex)
{
	float2 uv = float2(posW.x, posW.y);
	fixed s = _Time_y * _Speed;
	fixed2 offset1 = fixed2(uv.x*cos(s) - uv.y*sin(s), uv.y*cos(s) + uv.x*sin(s)) - uv;
	fixed2 offset2 = fixed2(s, s);
	uv += ((offset1 * _IsRotate) + offset2 * (1 - _IsRotate));
	fixed4 shadow = tex2D(_ShadowTex, float2(uv.x - 0.5, uv.y - 0.5));
	shadow.a *= _ShadowAlphaRatio;
	col.rgb *= (1 - shadow.a);
	shadow.rgb *= shadow.a;
	col.rgb += col.rgb * shadow.rgb / (1 - shadow.rgb);
	return col;
}

half4 SurfCalaShine(sampler2D _MainTex, sampler2D _AddTex, fixed _AddAlphaRatio, fixed _AddFlashSpeed, fixed2 uv_MainTex, fixed _Time_y)
{
	fixed4 col = tex2D(_MainTex, uv_MainTex);
	fixed4 add = tex2D(_AddTex, uv_MainTex);
	add *= (_AddAlphaRatio - 0.001) * abs(cos(_Time_y * _AddFlashSpeed)) * add.a;
	col.rgb += col.rgb * add.rgb / (1 - add.rgb);
	return col;
}
#define ARR_MAX_NUM  4
fixed4 projRect(sampler2D text, float3 pos, fixed4 col, float num, float3 angleArr[ARR_MAX_NUM], float3 offsetArr[ARR_MAX_NUM], float3 sizeArr[ARR_MAX_NUM])
{
	for (int k = 0; k < num; ++k)
	{
		fixed2 uv = fixed2(pos.x, pos.z) - offsetArr[k].xy;
		float angle = angleArr[k].y;
		fixed2 offset = fixed2(uv.x*cos(angle) - uv.y*sin(angle), uv.y*cos(angle) + uv.x*sin(angle));
		offset.x /= sizeArr[k].x;
		offset.y /= sizeArr[k].y;
		fixed4 pro = tex2D(text, float2(clamp(offset.x + 0.5, 0, 1), clamp(offset.y, 0, 1)));
		col = col * (1 - pro.a) + pro * pro.a;
	}

	return col;
}
fixed4 projRad(sampler2D text, float3 pos, fixed4 col, float num, float3 angleArr[ARR_MAX_NUM], float3 offsetArr[ARR_MAX_NUM], float3 sizeArr[ARR_MAX_NUM], float rangeArr[ARR_MAX_NUM])
{
	for (int k = 0; k < num; ++k)
	{
		fixed2 uv = fixed2(pos.x, pos.z) - offsetArr[k].xy;
		float angle = angleArr[k].y;
		fixed2 offset = fixed2(uv.x*cos(angle) - uv.y*sin(angle), uv.y*cos(angle) + uv.x*sin(angle));
		sizeArr[k] *= 0.5;
		offset.x /= sizeArr[k].x;
		offset.y /= sizeArr[k].y;
		fixed4 pro = tex2D(text, float2(clamp(offset.x + 0.5, 0, 1), clamp(offset.y + 0.5, 0, 1)));
		fixed draw = step(abs(offset.x) / tan(radians(rangeArr[k] / 2)), offset.y);
		col = draw * (col * (1 - pro.a) + pro * pro.a) + (1 - draw) * col;
	}
	return col;
}

fixed3 projPointLight(float3 pos, float num, float3 offsetArr[ARR_MAX_NUM], float3 sizeArr[ARR_MAX_NUM], float3 mixedcolArr[ARR_MAX_NUM])
{
	for (int k = 0; k < num; ++k)
	{
		float2 uv = fixed2(pos.x, pos.z) - offsetArr[k].xy;
		half radius = sizeArr[k];
		half decrease = 0.5;
		fixed3 mixedCol = mixedcolArr[k] / 2;
		float dis = uv.x * uv.x + uv.y * uv.y;
		if (dis < radius)
			return mixedCol * (pow(radius, decrease) - pow(dis, decrease));
	}
	return fixed3(0, 0, 0);
}
