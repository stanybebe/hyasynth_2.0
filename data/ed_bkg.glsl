
#ifdef GL_ES
precision mediump float;
#endif
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float valone;
uniform float valtwo;
uniform float valthree;

vec2 hash( vec2 x )
{
    const vec2 k = vec2( 0.3183099, 0.3678794 );
    x = x*k + k.yx;
    return -1.0 + 2.0*fract( 16.0 * k*fract( x.x*x.y*(x.x+x.y)) );
}

float noise( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );

	vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( hash( i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( hash( i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( hash( i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( hash( i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

void main() {

    vec2 uv = gl_FragCoord.xy/u_resolution.xy;
    vec2 r = vec2(gl_FragCoord.xy  - 0.520*u_resolution.xy );

   r = 3.0 * r.xy / u_resolution.xy;
    float colorwave=sin(valone * u_time)*4.0;
    vec3 col1 = vec3 (0.9*colorwave,0.0,.3);
    vec3 col2 = vec3 (0.4*colorwave,0.0,.9);
    vec3 col3 = vec3 (0.3,0.1*colorwave,.9);
    vec3 col4 = vec3 (0.0,0.0,.0*colorwave);

    vec3 pixi;
    float n = noise(valthree*uv);
    float width = (sin(.05 * u_time)*.60);

    float width2 = cos(sin(valone * u_time)*10.0);
    float mody = length(dot(width*width2,sin(cos(r.x+u_time)*valone)))*n;
    float mody2 =length(dot(width/width2,sin(cos(r.y+u_time*.5)*valone)))*n;
    if(tan(sin(u_time+length(r)*valone))*r.y> mody){

        pixi = col1;

    	}
    else {

        pixi = col1*col2;

        }
      if(sin(sin(u_time+length(r)*valtwo))*cos(length(r)+u_time*valtwo)/4.< mody2){

        pixi = col3;

    	}
     	if(sin(cos(u_time+length(r)*valtwo))*sin(length(r)+u_time*valtwo) < mody2){

        pixi = col4;

    	}


     gl_FragColor = vec4(pixi,1.0);
  }
