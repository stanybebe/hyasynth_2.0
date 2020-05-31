
#ifdef GL_ES

precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float speedA;
uniform float speedB;
uniform float offsetA;
uniform float offsetB;
uniform float moverA;
uniform float moverB;
uniform float ampA;
uniform float ampB;
uniform sampler2D texture;
varying vec4 vertColor;
varying vec4 vertTexCoord;





uniform float noiseAmt;
uniform int oscillatorA;
uniform int oscillatorB;


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

void main()
{

    vec2 uv = gl_FragCoord.xy/u_resolution.xy;
    vec2 r = vec2( gl_FragCoord.xy -moverB*u_resolution.xy );
	  r = moverA * r.xy / u_resolution.xy;

    vec3 col1 = vec3 (0.3,0.6,.9);
    vec3 col2 = vec3  (0.0,0.9,.0);
    vec3 col3 = vec3(.9,.0,.3);


   vec3 pixi;
   vec3 pixi2;
   vec3 pixi3;
    float n = noise((noiseAmt)*uv);
  float width = sin(.03 * u_time)*speedA;

      vec4 color =texture2D(texture, vertTexCoord.xy);


    float squarev = sin(mod(width,r.x)*ampA*color.x);

    float squareh = sin(mod(width,r.y)*ampA*color.y);

    float sineh = sin(dot(width,r.x*ampB)*ampA*color.x);

    float sinev = sin(dot(width,r.y*ampB)*ampA*color.y);

    float noiseh = sin(dot(width,r.x*ampB)*ampA*n*color.x);

    float noisev = sin(dot(width,r.y*ampB)*ampA*n*color.y);

    float tv = (mod((width),r.y*ampB*color.x));

    float th = (mod((width),r.x*ampB*color.y));

    if (oscillatorA == 0){
     if(sin(u_time*speedB+offsetA)*r.x> squarev){

         pixi = col1;

     	}
     else{pixi = col3;}
     }
     if (oscillatorA == 1){
     if((sin(u_time*speedB+offsetA))*r.y> squareh){

         pixi = col2;

     	}
      else{pixi = col3;}
    }

    if (oscillatorA == 2){
     if(sin(u_time*speedB+offsetA)*r.x> sinev){

         pixi = col1;

     	}
     else{pixi = col3;}
     }
     if (oscillatorA == 3){
     if((sin(u_time*speedB+offsetA))*r.y> sineh){

         pixi = col2;

     	}
      else{pixi = col3;}
    }
    if (oscillatorA == 4){
     if(sin(u_time*speedB+offsetA)*r.x> noisev){

         pixi = col1;

      }
     else{pixi = col3;}
     }
     if (oscillatorA == 5){
     if((sin(u_time*speedB+offsetA))*r.y> noiseh){

         pixi = col2;

      }
      else{pixi = col3;}
    }
    if (oscillatorA == 6){
     if(sin(u_time*speedB+offsetA)*r.x> tv){

         pixi = col1;

      }
     else{pixi = col3;}
     }
     if (oscillatorA == 7){
     if((sin(u_time*speedB+offsetA))*r.y> th){

         pixi = col2;

      }
      else{pixi = col3;}
    }

    if (oscillatorB == 0){
     if(sin(u_time*speedB+offsetB)*r.x> squarev){

         pixi2 = col1;

      }
     else{pixi2 = col3;}
     }
     if (oscillatorB == 1){
     if((sin(u_time*speedB+offsetB))*r.y> squareh){

         pixi2 = col2;

      }
      else{pixi2 = col3;}
    }

    if (oscillatorB == 2){
     if(sin(u_time*speedB+offsetB)*r.x> sinev){

         pixi2 = col1;

      }
     else{pixi2 = col3;}
     }
     if (oscillatorB == 3){
     if((sin(u_time*speedB+offsetB))*r.y> sineh){

         pixi2 = col2;

      }
      else{pixi2 = col3;}
    }
    if (oscillatorB == 4){
     if(sin(u_time*speedB+offsetB)*r.x> noisev){

         pixi2 = col1;

      }
     else{pixi2 = col3;}
     }
     if (oscillatorB == 5){
     if((sin(u_time*speedB+offsetB))*r.y> noiseh){

         pixi2 = col2;

      }
      else{pixi2 = col3;}
    }
    if (oscillatorB == 6){
     if(sin(u_time*speedB+offsetB)*r.x> tv){

         pixi2 = col1;

      }
     else{pixi2 = col3;}
     }
     if (oscillatorB == 7){
     if((sin(u_time*speedB+offsetB))*r.y> th){

         pixi2 = col2;

      }
      else{pixi2 = col3;}
    }

      vec3 pixiNu = pixi + pixi2;



     gl_FragColor = vec4(pixiNu, 1.);
 }
