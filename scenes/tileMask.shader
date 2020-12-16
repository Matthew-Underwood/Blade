shader_type canvas_item;
uniform sampler2D maskTexture;
uniform float flip;
uniform float offset;

void fragment() {
	vec2 uv = UV;
	vec4 mask = texture(maskTexture, uv);
	
	//vec4 tex = texture(TEXTURE,vec2(uv.x + flip, uv.y - flip));
	vec4 tex = texture(TEXTURE,uv);
	tex.a -= mask.a;
	COLOR = tex;
}