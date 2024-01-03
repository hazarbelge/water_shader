out vec4 fragColor;

// Constants
const int QUALITY = 4;
const vec3 WATER_DEF_COLOR = vec3(0.0, 0.25, 0.36);
const vec3 WATER_COLOR = vec3(0.0, 0.75, 1.0);
const vec3 SKY_COLOR = vec3(0.2, 0.5, 1);
const mat2 OCTAVE_MATRIX = mat2(2, 1.2, -1.2, 1.6);

// Uniforms
uniform vec2 iResolution;
uniform float iTime;
uniform float iRotation;
uniform float SEA_HEIGHT;
uniform float SEA_SPEED;
uniform float SEA_CHOPPY;

float SEA_TIME() {
    return 1.0 + iTime * SEA_SPEED;
}

float calculateDiffuseLight(vec3 normal, vec3 lightDir, float power) {
    return pow(dot(normal, lightDir) * 0.4 + 0.6, power);
}

float calculateSpecularLight(vec3 normal, vec3 lightDir, vec3 eyeDir, float shininess) {
    return pow(max(dot(reflect(eyeDir, normal), lightDir), 0.0), shininess) * (shininess + 5.0) / (3.14 * 5.0);
}

float calculateSeaWave(vec2 position, float choppiness) {
    vec2 grid = floor(position);
    vec2 fractional = fract(position);
    vec2 smoothStep = fractional * fractional * (3.0 - 2.0 * fractional);

    float hash0 = fract(sin(dot(grid + vec2(0.0, 0.0), vec2(90, 270))) * 12345.67890);
    float hash1 = fract(sin(dot(grid + vec2(1.0, 0.0), vec2(90, 270))) * 12345.67890);
    float hash2 = fract(sin(dot(grid + vec2(0.0, 1.0), vec2(90, 270))) * 12345.67890);
    float hash3 = fract(sin(dot(grid + vec2(1.0, 1.0), vec2(90, 270))) * 12345.67890);

    float mix0 = mix(hash0, hash1, smoothStep.x);
    float mix1 = mix(hash2, hash3, smoothStep.x);

    position += mix(mix0, mix1, smoothStep.y) * 2.0;
    position -= 1.0;
    vec2 waveVector = 1.0 - abs(sin(position));
    vec2 swappedWaveVector = abs(cos(position));
    waveVector = mix(waveVector, swappedWaveVector, waveVector);
    return pow(1.0 - pow(waveVector.x * waveVector.y, 0.65), choppiness);
}

float calculateSeaHeight(vec3 point) {
    float frequency = .2;
    float amplitude = SEA_HEIGHT;
    float choppiness = SEA_CHOPPY;
    vec2 uv = point.xz;
    uv.x *= 0.75;

    float displacement, height = 0.0;
    displacement = calculateSeaWave((uv + SEA_TIME()) * frequency, choppiness);
    displacement += calculateSeaWave((uv - SEA_TIME()) * frequency, choppiness);
    height += displacement * amplitude;

    uv *= OCTAVE_MATRIX;
    frequency *= 1.9;
    amplitude *= 0.22;
    choppiness = mix(choppiness, 1.0, 0.2);

    return point.y - height;
}

float calculateDetailedSeaHeight(vec3 point) {
    float frequency = .2;
    float amplitude = SEA_HEIGHT;
    float choppiness = SEA_CHOPPY;
    vec2 uv = point.xz;
    uv.x *= 0.75;

    float displacement, height = 0.0;
    for (int i = 0; i < QUALITY; i++) {
        displacement = calculateSeaWave((uv + SEA_TIME()) * frequency, choppiness);
        displacement += calculateSeaWave((uv - SEA_TIME()) * frequency, choppiness);
        height += displacement * amplitude;

        uv *= OCTAVE_MATRIX;
        frequency *= 1.9;
        amplitude *= 0.22;
        choppiness = mix(choppiness, 1.0, 0.2);
    }
    return point.y - height;
}

vec3 calculateSeaColor(vec3 point, vec3 normal, vec3 lightDir, vec3 viewDir, vec3 distance) {
    float fresnelEffect = clamp(1.0 - dot(normal, -viewDir), 0.0, 1.0);
    fresnelEffect = pow(fresnelEffect, 3.0) * 0.5;

    vec3 reflectedDir = reflect(viewDir, normal);
    reflectedDir.y = (max(reflectedDir.y, 0.0) * 0.8 + 0.2) * 0.9;
    vec3 skyReflection = mix(vec3(pow(1.0 - reflectedDir.y, 2.0), 1.0 - reflectedDir.y, 0.4 + (1.0 - reflectedDir.y) * 0.4), SKY_COLOR, reflectedDir.y);

    vec3 refractedColor = WATER_DEF_COLOR + calculateDiffuseLight(normal, lightDir, 50.0) * WATER_COLOR * 0.2;
    float depthAttenuation = clamp(1.0 - (distance.y / SEA_HEIGHT), 0.0, 1.0);
    vec3 finalColor = mix(refractedColor, skyReflection, fresnelEffect) * depthAttenuation;
    float attenuation = max(1.0 - dot(distance, distance) * 0.1, 0.0);
    finalColor += WATER_COLOR * (point.y - SEA_HEIGHT) * 0.95 * attenuation;

    finalColor += vec3(calculateSpecularLight(normal, lightDir, viewDir, 150.0));

    return finalColor;
}

vec3 calculateNormal(vec3 point, float epsilon) {
    vec3 normal;
    normal.y = calculateDetailedSeaHeight(point);
    normal.x = calculateDetailedSeaHeight(vec3(point.x + epsilon, point.y, point.z)) - normal.y;
    normal.z = calculateDetailedSeaHeight(vec3(point.x, point.y, point.z + epsilon)) - normal.y;
    normal.y = epsilon;
    return normalize(normal);
}

vec3 calculateHeightPosition(vec3 start, vec3 dir) {
    float near = 0.0;
    float far = 150.0;
    float seaLevelNear = calculateSeaHeight(start + dir * far);

    if (seaLevelNear > 0.0) {
        return start + dir * far;
    }

    float seaLevelFar = calculateSeaHeight(start);
    float mid = 0.0;

    for (int i = 0; i < 3; i++) {
        mid = mix(near, far, seaLevelFar / (seaLevelFar - seaLevelNear));
        float seaLevelMid = calculateSeaHeight(start + dir * mid);

        if (seaLevelMid < 0.0) {
            far = mid;
            seaLevelNear = seaLevelMid;
        } else {
            near = mid;
            seaLevelFar = seaLevelMid;
        }
    }
    return start + dir * mid;
}

vec3 renderScene(in vec2 screenCoord, float time) {
    vec2 uv = (screenCoord * 2.0 / iResolution.xy) - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    vec3 angle = vec3(0, .5, time + iRotation);
    vec3 origin = vec3(0.0, 5, 10);
    vec3 direction = normalize(vec3(uv.xy, -2.0));

    vec2 a1 = vec2(sin(angle.x), cos(angle.x));
    vec2 a2 = vec2(sin(angle.y), cos(angle.y));
    vec2 a3 = vec2(sin(angle.z), cos(angle.z));
    mat3 rotationMatrix;
    rotationMatrix[0] = vec3(a1.y * a3.y + a1.x * a2.x * a3.x, a1.y * a2.x * a3.x + a3.y * a1.x, -a2.y * a3.x);
    rotationMatrix[1] = vec3(-a2.y * a1.x, a1.y * a2.y, a2.x);
    rotationMatrix[2] = vec3(a3.y * a1.x * a2.x + a1.y * a3.x, a1.x * a3.x - a1.y * a3.y * a2.x, a2.y * a3.y);

    direction = normalize(direction) * rotationMatrix;

    vec3 hitPos = calculateHeightPosition(origin, direction);
    vec3 delta = hitPos - origin;
    vec3 normal = calculateNormal(hitPos, dot(delta, delta) * (0.1 / iResolution.x));
    vec3 lightDir = normalize(vec3(0.0, 2.0, 10.0));

    vec3 viewDir = direction;
    viewDir.y = (max(viewDir.y, 0.0) * 0.8 + 0.2) * 0.9;
    vec3 skyCol = mix(vec3(pow(1.0 - viewDir.y, 2.0), 1.0 - viewDir.y, 0.4 + (1.0 - viewDir.y) * 0.4) * 1, SKY_COLOR, viewDir.y);

    return mix(
        skyCol,
        calculateSeaColor(hitPos, normal, lightDir, direction, delta),
        pow(smoothstep(0.0, -0.02, direction.y), 0.2)
    );
}

void main() {
    vec3 color = renderScene(gl_FragCoord.xy, iTime * 0.1);
    fragColor = vec4(pow(color, vec3(0.6)), 1.0);
}
