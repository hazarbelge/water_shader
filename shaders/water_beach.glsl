uniform vec2 iResolution;
uniform float iTime;

out vec4 fragColor;

const int NUM_STEPS = 3;
const float PI = 3.1415;
#define EPSILON_NRM 0.1 / iResolution.x

const float SEA_HEIGHT = .6;
const float SEA_SPEED = 2.0;
const float SEA_CHOPPY = 3.0;
const int ITER_GEOMETRY = 1;
const int ITER_FRAGMENT = 4;
const float SEA_FREQ = .22;
const vec3 SEA_BASE = vec3(0.0, 0.25, 0.36);
const vec3 SEA_WATER_COLOR = vec3(0.0, 0.75, 1.0);
#define SEA_TIME 1.0 + iTime * SEA_SPEED

const mat2 octave_m = mat2(2, 1.2, -1.2, 1.6);

mat3 fromEuler(vec3 ang) {
    vec2 a1 = vec2(sin(ang.x), cos(ang.x));
    vec2 a2 = vec2(sin(ang.y), cos(ang.y));
    vec2 a3 = vec2(sin(ang.z), cos(ang.z));
    mat3 m;
    m[0] = vec3(a1.y * a3.y + a1.x * a2.x * a3.x, a1.y * a2.x * a3.x + a3.y * a1.x, -a2.y * a3.x);
    m[1] = vec3(-a2.y * a1.x, a1.y * a2.y, a2.x);
    m[2] = vec3(a3.y * a1.x * a2.x + a1.y * a3.x, a1.x * a3.x - a1.y * a3.y * a2.x, a2.y * a3.y);
    return m;
}
float hash(vec2 p) {
    float h = dot(p, vec2(90, 270));
    return fract(sin(h) * 20);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    return 2.0 * mix(
        mix(hash(i + vec2(0.0, 0.0)), hash(i + vec2(1.0, 0.0)), u.x),
        mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x),
        u.y
    );
}

float diffuse(vec3 n, vec3 l, float p) {
    return pow(dot(n, l) * 0.4 + 0.6, p);
}
float specular(vec3 n, vec3 l, vec3 e, float s) {
    float nrm = (s + 8.0) / (PI * 8.0);
    return pow(max(dot(reflect(e, n), l), 0.0), s) * nrm;
}

float sea_octave(vec2 uv, float choppy) {
    uv -= noise(uv);
    vec2 wv = 1.0 - abs(sin(uv));
    vec2 swv = abs(cos(uv));
    wv = mix(wv, swv, wv);
    return pow(1.0 - pow(wv.x * wv.y, 0.5), choppy);
}

float map(vec3 p) {
    float freq = SEA_FREQ;
    float amp = SEA_HEIGHT;
    float choppy = SEA_CHOPPY;
    vec2 uv = p.xz;
    uv.x *= 0.75;

    float angle = mix(PI / 2.0, PI / 4.0, smoothstep(-1.0, 1.0, p.x));
    mat2 rot = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
    uv *= rot;

    float d, h = 0.0;
    for (int i = 0; i < ITER_GEOMETRY; i++) {
        d = sea_octave((uv + SEA_TIME) * freq, choppy);
        d += sea_octave((uv - SEA_TIME) * freq, choppy);
        h += d * amp;
        uv *= octave_m;
        freq *= 1.9;
        amp *= 0.22;
        choppy = mix(choppy, 1.0, 0.2);
    }
    return p.y - h;
}

float map_detailed(vec3 p) {
    float freq = SEA_FREQ;
    float amp = SEA_HEIGHT;
    float choppy = SEA_CHOPPY;
    vec2 uv = p.xz;
    uv.x *= 0.75;

    float d, h = 0.0;
    for (int i = 0; i < ITER_FRAGMENT; i++) {
        d = sea_octave((uv + SEA_TIME) * freq, choppy);
        d += sea_octave((uv - SEA_TIME) * freq, choppy);
        h += d * amp;
        uv *= octave_m;
        freq *= 1.9;
        amp *= 0.22;
        choppy = mix(choppy, 1.0, 0.2);
    }
    return p.y - h;
}

vec3 getSeaAndBeachColor(vec3 p, vec3 n, vec3 l, vec3 eye, vec3 dist) {
    vec3 beachColor = vec3(0.95, 0.85, 0.45); // Kumsal rengi

    if (p.x >= .5) {
        return beachColor;
    }

    float fresnel = clamp(1.0 - dot(n, -eye), 0.0, 1.0);
    fresnel = pow(fresnel, 3.0) * .2;

    vec3 reflected = vec3(0.2, 0.5, 1);
    vec3 refracted = SEA_BASE + diffuse(n, l, 120.0) * SEA_WATER_COLOR * 0.2;
    float depthFactor = clamp(1.0 - (dist.y / SEA_HEIGHT), 0.0, 1.0);
    vec3 distantColor = mix(refracted, reflected, fresnel) * depthFactor;
    float atten = max(1.0 - dot(dist, dist) * 0.1, 0.0);
    vec3 color = distantColor + SEA_WATER_COLOR * (p.y - SEA_HEIGHT) * 0.95 * atten;

    color += vec3(specular(n, l, eye, 120.0));

    return color;
}

vec3 getNormal(vec3 p, float eps) {
    vec3 n;
    n.y = map_detailed(p);
    n.x = map_detailed(vec3(p.x + eps, p.y, p.z)) - n.y;
    n.z = map_detailed(vec3(p.x, p.y, p.z + eps)) - n.y;
    n.y = eps;
    return normalize(n);
}

float heightMapTracing(vec3 ori, vec3 dir, out vec3 p) {
    float tm = 0.0;
    float tx = 1000.0;
    float hx = map(ori + dir * tx);
    if (hx > 0.0) {
        p = ori + dir * tx;
        return tx;
    }
    float hm = map(ori + dir * tm);
    float tmid = 0.0;
    for (int i = 0; i < NUM_STEPS; i++) {
        tmid = mix(tm, tx, hm / (hm - hx));
        p = ori + dir * tmid;
        float hmid = map(p);
        if (hmid < 0.0) {
            tx = tmid;
            hx = hmid;
        } else {
            tm = tmid;
            hm = hmid;
        }
    }
    return tmid;
}

vec3 getPixel(vec2 coord) {
    vec2 uv = coord / iResolution.xy;
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    vec3 ang = vec3(0, 0, 0);
    vec3 ori = vec3(0, 10, 40);
    vec3 dir = normalize(vec3(uv.xy, -1.0));
    dir = normalize(dir) * fromEuler(ang);

    vec3 p;
    heightMapTracing(ori, dir, p);
    vec3 dist = p - ori;
    vec3 n = getNormal(p, dot(dist, dist) * EPSILON_NRM);
    vec3 light = normalize(vec3(0.0, 1.0, 0.8));

    return getSeaAndBeachColor(p, n, light, dir, dist);
}

void main() {
    vec3 color = getPixel(gl_FragCoord.xy);
    fragColor = vec4(pow(color, vec3(0.6)), 0.9);
}
