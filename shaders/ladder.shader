shader_type canvas_item;

uniform vec3 color = vec3(.2, .2, .2);
//uniform vec3 color = vec3(1.0, 1.0, 1.0);
uniform int OCTAVES = 4;

void fragment(){
	vec2 coord = UV * 10.;

	COLOR = vec4(color, 1.);
}