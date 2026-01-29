#version 330 core

layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aNormal;
layout(location = 2) in vec2 aTexCoord;

out vec3 FragPos;
out vec3 Normal;
out vec2 TexCoord;
out float WaveHeight;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform float time;

uniform float waveAmplitude;
uniform float waveFrequency;
uniform float waveSpeed;

const float PI = 3.14159265358979323826264;
const float G = 9.81;

float wave(vec2 direction) {
    float k = 2.0 * PI * waveFrequency;
    float angularFreq = sqrt(G * k);

    float phase = k * (dot(aPos.xz, direction)) - (angularFreq * waveSpeed * time);

    return waveAmplitude * sin(phase);
}

void main() {
    // You need to create a realistic wave effect on the plane

    float totalWave = (wave(vec2(0, cos(time))) +
        wave(vec2(cos(time), sin(time))) +
        wave(vec2(0.78, 0.2 * cos(time))));

    vec3 displacedPos = aPos;
    displacedPos.y += totalWave * 0.05;

    float dx = 1;

    float dz = 1;

    vec3 calculatedNormal = normalize(vec3(-dx, 1.0, -dz));

    FragPos = vec3(model * vec4(displacedPos, 1.0));
    Normal = mat3(transpose(inverse(model))) * calculatedNormal;
    TexCoord = aTexCoord;
    WaveHeight = totalWave;

    gl_Position = projection * view * model * vec4(displacedPos, 1.0);
}
