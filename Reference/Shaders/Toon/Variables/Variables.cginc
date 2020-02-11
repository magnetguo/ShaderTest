#ifndef SHADER_VARIABLES_INCLUDED
#define SHADER_VARIABLES_INCLUDED

CBUFFER_START(Weather)
    // x = ratio, Weather transition from orginal effect to target effect, according to mul color value
    float4 global_WeatherParams;
CBUFFER_END

#define APPLY_WEATHER(col,weatherCol) col.rgb *= lerp(1,weatherCol.rgb,global_WeatherParams.x)
#endif
