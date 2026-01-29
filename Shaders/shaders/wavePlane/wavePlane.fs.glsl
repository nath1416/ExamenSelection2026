#version 330 core

in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoord;
in float WaveHeight;

out vec4 FragColor;

uniform vec3 viewPos;
uniform float time;

uniform vec3 waveColor1;
uniform vec3 waveColor2;
uniform float waveAmplitude;

void main() {
    float factor = clamp((-waveAmplitude / (WaveHeight - 2 * waveAmplitude)) - 0.5, 0.0, 1.0);

    vec3 result = mix(waveColor1, waveColor2, factor);

    FragColor = vec4(result, 0.9);
}
