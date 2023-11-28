shader_type canvas_item;

uniform float wind_speed = 1.0;
uniform float wind_strength = 4.0;

void vertex()
{
	VERTEX.x += sin(TIME * wind_speed) * (1.0 - UV.y) * wind_strength;
}
