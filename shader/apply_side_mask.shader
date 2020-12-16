shader_type canvas_item;
uniform vec3 colour;
uniform sampler2D tex;
uniform sampler2D mask;

void fragment() {
	vec4 textureColour = texture(TEXTURE, UV);
	vec4 maskColour = texture(mask, UV);
	textureColour.a -= maskColour.a;
	COLOR = textureColour;
}