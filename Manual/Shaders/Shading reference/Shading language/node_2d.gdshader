shader_type canvas_item;

global uniform float my_global_uniform;

uniform float myvar;
uniform vec4 color : source_color;

group_uniforms MyGroup;
uniform float amount : hint_range(0, 1);
uniform vec4 other_color : source_color = vec4(1.0);
uniform sampler2D image : source_color;
group_uniforms;

/**
 * This is a documentation comment.
 * These lines will appear in the inspector when hovering the shader parameter
 * named "Something".
 * You can use [b]BBCode[/b] [i]formatting[/i] in the comment.
 */
uniform int something = 1;

/** This is a single-line documentation comment. */
uniform float something_else = 1.0;

const vec3 v[1] = vec3[1] (vec3(0, 0, 1));
uniform vec3 w[1];

struct PointLight {vec3 position; vec3 color; float intensity;};


void vertex() {
	// Called for every vertex the material is visible on.
	mat3 basis = mat3(MODEL_MATRIX);
	mat4 m4 = mat4(basis);
	mat2 m2 = mat2(m4);
	
	PointLight light = PointLight(vec3(0.0), vec3(1.0, 0.0, 0.0), 0.5);
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 a = vec4(0.0, 1.0, 2.0, 3.0);
	vec3 b = a.rgb; // Creates a vec3 with vec4 components.
	vec3 c = a.ggg; // Also valid; creates a vec3 and fills it with a single vec4 component.
	vec3 d = a.bgr; // "b" will be vec3(2.0, 1.0, 0.0).
	vec3 e = a.xyz; // Also rgba, xyzw are equivalent.
	vec3 f = a.stp; // And stpq (for texture coordinates).
	//float g = b.w; // Invalid, because "w" is not present in vec3 b.
	//vec3 h = b.xrt; // Invalid, mixing different styles is forbidden.
	//b.rrr = a.rgb; // Invalid, assignment with duplication.
	b.bgr = a.rgb; // Valid assignment. "b"'s "blue" component will be "a"'s "red" and vice versa.
	
	float arr[3];
    float float_arr[3] = float[3] (1.0, 0.5, 0.0);
    int int_arr[3] = int[] (2, 1, 0);
    vec2 vec2_arr[3] = { vec2(1.0, 1.0), vec2(0.5, 0.5), vec2(0.0, 0.0) };
    bool bool_arr[] = { true, true, false }; // size is defined automatically from the element count
	
	float aa[3] = float[3] (1.0, 0.5, 0.0), bb[2] = {1.0, 0.5}, cc[] = {0.7}, dd = 0.0, ee[5];
	
	float arr2[3];
	int n = arr2.length();
	
	//COLOR = vec4(v[0] + w[0], myvar);
	COLOR.r = my_global_uniform;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
