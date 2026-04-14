shader_type canvas_item;

uniform float blue;

void vertex() {
	VERTEX.y += VERTEX.x / 2.0;
}

void fragment() {
	//COLOR = vec4(0.4, 0.6, 0.9, 1.0);
	//COLOR = vec4(UV, 0.5, 1.0);
	COLOR.b = blue;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
