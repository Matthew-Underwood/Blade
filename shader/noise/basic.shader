shader_type canvas_item;

float random(in vec2 st) {
	return fract(sin(dot(st.xy,vec2(12.9898,78.233))) * 43758.5453123);
}

float noise(in vec2 st) {
	vec2 i = floor(st);
	vec2 f = fract(st);
	
	float a = random(i);
	float b = random(i + vec2(1.0,0.0));
	float c = random(i  + vec2(0.0,1.0));
	float d = random(i  + vec2(1.0,1.0));
	
	//vec2 u = f*f*(3.0-2.0*f);
	vec2 u = step(1.0,f);
	return mix(a, b, u.x) + (c - a)* u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
	//Find a way to project this isometrically
	vec2 st = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE);
	 // Scale the coordinate system to see
    // some noise in action
    vec2 pos = vec2(st * 10.0);

    // Use the noise function
    float n = noise(pos);
	
	COLOR = texture(TEXTURE, UV);
	COLOR.rgb = vec3(n);
}