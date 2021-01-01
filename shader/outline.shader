shader_type canvas_item;
uniform sampler2D outlineTexture;

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 outline = texture(outlineTexture, UV);
	tex.rgb -= outline.a;
	COLOR = tex;
}