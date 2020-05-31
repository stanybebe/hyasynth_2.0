import controlP5.*;
import processing.video.*;
import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import themidibus.*;
import codeanticode.syphon.*;
ControlP5 cp5, cp5b, cp5c, cp5d, cp5f, cp5e, cp5g, cp5h, cp5i, cp5j, cp5k;
PostFX fx;
PImage knob, knobB, knobC, knobD, knobE, knobF, knobG, knobH, knobI, knobJ, knobK, sineh, sinev, squareh, squarev, noiseh, noisev, sawh, sawv, sinehB, sinevB, squarehB, squarevB, noisehB, noisevB, sawhB, sawvB;
PImage eyeOpen, eyeClosed, bwmodeOn, colormodeOn, bkgImg;
PImage img;
Knob myKnobA;
Knob myKnobB;
Knob myKnobC;
Knob myKnobD;
Knob myKnobE;
Knob myKnobF;
Knob myKnobG;
Knob myKnobH;
Knob myKnobI;
Knob myKnobJ;
Knob myKnobK;
MidiBus myBus;
Capture cam;
SyphonServer server;
SyphonClient client;
PShader bkg, bkg2, bw;
PShader noise, ving, chrm, hue;
PGraphics bk, c;
PGraphics knbS, knbSb, knbSc, knbSd, knbSe, knbSf, knbSg, knbSh, knbSi, knbSj, knbSk;
//Spout spout;
float t, feedbackAmt, ampA, ampB, speedA, speedB, noiseAmt, offsetA, offsetB, valfour, kampA, kampB, kampC, kspeedA, kspeedB, koffsetA, koffsetB, knoise, kcolor, kmoveA, kmoveB ;
float mOffsetA, mOffsetB, mMoveA, mMoveB, mFeedback;
float cc[] = new float[256];
float rot, rotB, rotC, rotD, rotE, rotF, rotG, rotH, rotI, rotJ, rotK;
int hit, oscA = 0, oscB, boscA, boscB;
int tik1 = 10;
int cameraOn =0, bwOn =0;
int x = 776, y=43, w =30, h = 30;
int x2 = 834, y2=43, w2 =30, h2 = 30;
int x3 = 828, y3=418, w3 =50, h3 = 50;
int x4 = 762, y4=418, w4 =50, h4 = 50;


void setup() {

  size(920, 480, P3D);
  smooth();

  bkg= loadShader("eyesynth.glsl");
  bw= loadShader("bw.glsl");
  bkg2= loadShader("eyesynthCAM.glsl");
  chrm =loadShader("chromaticAberrationFrag.glsl");
  noise =loadShader("noiseFrag.glsl");
  hue= loadShader("hueadj.glsl");


  knob = loadImage("knobtest.png");
  knobB = loadImage("knobtest.png");
  knobC = loadImage("knobtest.png");
  knobD = loadImage("knobtest.png");
  knobE = loadImage("knobtest.png");
  knobF = loadImage("knobtest.png");
  knobG = loadImage("knobtest.png");
  knobH = loadImage("knobcolor.png");
  knobI = loadImage("knobtest.png");
  knobJ = loadImage("knobtest.png");
  knobK = loadImage("knobtest.png");
  sineh = loadImage("sineh.png");
  sinev = loadImage("sinev.png");
  squareh = loadImage("squareh.png");
  squarev = loadImage("squarev.png");
  noiseh = loadImage("noiseh.png");
  noisev = loadImage("noisev.png");
  sawh = loadImage("sawh.png");
  sawv = loadImage("sawv.png");
  sinehB = loadImage("sineh.png");
  sinevB = loadImage("sinev.png");
  squarevB = loadImage("squarev.png");
  squarehB = loadImage("squareh.png");
  noisehB = loadImage("noiseh.png");
  noisevB = loadImage("noisev.png");
  sawhB = loadImage("sawh.png");
  sawvB = loadImage("sawv.png");
  eyeClosed = loadImage("eyeClosed.png");
  eyeOpen = loadImage("eyeOpen.png");
  bwmodeOn = loadImage("bwmodeOn.png");
  colormodeOn = loadImage("colormodeOn.png");
  bkgImg = loadImage("bkg.png");
  
  bw.set("vertTexCoord", float(width), float(height));
  bkg.set("u_resolution", float(width), float(height));
  bkg2.set("u_resolution", float(width), float(height));
  chrm.set("u_resolution", float(width), float(height));

  bk = createGraphics(720, 480, P3D);
  c = createGraphics(720, 480, P3D);
  knbS = createGraphics(790, 113, P3D);
  knbSb = createGraphics(848, 113, P3D);
  knbSc = createGraphics(790, 163, P3D);
  knbSd = createGraphics(848, 163, P3D);
  knbSe = createGraphics(790, 239, P3D);
  knbSf = createGraphics(849, 239, P3D);
  knbSg = createGraphics(790, 289, P3D);
  knbSh = createGraphics(820, 389, P3D);
  knbSi = createGraphics(890, 289, P3D);
  knbSj = createGraphics(790, 336, P3D);
  knbSk = createGraphics(849, 336, P3D);


  fx = new PostFX(this); 
  // spout = new Spout(this);
  server = new SyphonServer(this, "Processing Syphon");
  //spout.createSender("Spout Processing");
  MidiBus.list();
  myBus= new MidiBus(this, 5, 0);

  cp5 = new ControlP5(this);
  cp5b = new ControlP5(this);
  cp5c = new ControlP5(this);
  cp5d = new ControlP5(this);
  cp5e = new ControlP5(this);
  cp5f = new ControlP5(this);
  cp5g = new ControlP5(this);
  cp5h = new ControlP5(this);
  cp5i = new ControlP5(this);
  cp5j = new ControlP5(this);
  cp5k = new ControlP5(this);
  cp5.setGraphics(knbS, 15/2, 15/2);
  cp5b.setGraphics(knbSb, 15/2, 15/2);
  cp5c.setGraphics(knbSc, 15/2, 15/2);
  cp5d.setGraphics(knbSd, 15/2, 15/2);
  cp5e.setGraphics(knbSe, 15/2, 15/2);
  cp5f.setGraphics(knbSf, 15/2, 15/2);
  cp5g.setGraphics(knbSg, 15/2, 15/2);
  cp5h.setGraphics(knbSh, 25/2, 25/2);
  cp5i.setGraphics(knbSi, 15/2, 15/2);
  cp5j.setGraphics(knbSj, 15/2, 15/2);
  cp5k.setGraphics(knbSk, 15/2, 15/2);

  myKnobA = cp5.addKnob("knob")
    .setRange(0, 50)
    .setValue(50)
    .setPosition(789.7-15, 112.5-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;

  myKnobB = cp5b.addKnob("knobB")
    .setRange(0, 50)
    .setValue(50)
    .setPosition(847.8-15, 112.5-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;



  myKnobC = cp5c.addKnob("knobC")
    .setRange(0, 200)
    .setValue(1)
    .setPosition(789.7-15, 163-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;


  myKnobD = cp5d.addKnob("knobD")
    .setRange(0, 200)
    .setValue(1)
    .setPosition(847.8-15, 163-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;

  myKnobE = cp5e.addKnob("knobE")
    .setRange(0, 200)
    .setValue(50)
    .setPosition(789.7-15, 239.2-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;


  myKnobF = cp5f.addKnob("knobF")
    .setRange(0, 200)
    .setValue(100)
    .setPosition(848.8-15, 239.2-15)
    .setRadius(25)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;


  myKnobG = cp5g.addKnob("knobG")
    .setRange(0, 200)
    .setValue(100)
    .setPosition(790.4-15, 289-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;

  myKnobH = cp5h.addKnob("knobH")
    .setRange(0, 200)
    .setValue(100)
    .setPosition(819.2-25, 388.9-25)
    .setRadius(25)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;

  myKnobI = cp5i.addKnob("knobI")
    .setRange(0, 200)
    .setValue(100)
    .setPosition(848.5-15, 289.1-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;

  myKnobJ = cp5j.addKnob("knobJ")
    .setRange(0, 200)
    .setValue(100)
    .setPosition(790.4-15, 335.8-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;




  myKnobK = cp5k.addKnob("knobK")
    .setRange(0, 200)
    .setValue(100)
    .setPosition(848.5-15, 335.8-15)
    .setRadius(15)
    .setDragDirection(Knob.HORIZONTAL)
    .setColorActive(color(0, 0, 0, 1))
    .setColorBackground(color(0, 0, 0, 1))
    .setColorForeground(color(0, 0, 0, 1))
    .setColorValueLabel(color(0, 0, 0, 1))
    .setColorCaptionLabel(color(0, 0, 0, 1))

    ;
    
  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 920, 480);
  } else if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);
    cam = new Capture(this, cameras[0]);
    cam.start();
  }

  fill(0);
  client = new SyphonClient(this);
}


void draw() {

  background(155);
  t=t+.03;
  if (client.newFrame()) {
    img = client.getImage(img); 
  }
  if (img != null) {
    image(img, 0, 0, width, height);
  }

  ampA=map(cc[1], 0, 127, 0, 200);
  ampB=map(cc[2], 0, 127, 0, 200);
  speedA=map(cc[3], 0, 127, 0, 1);
  speedB=map(cc[4], 0, 127, 0, 1);
  oscA=int(map(cc[5], 0, 127, 0, 7));
  oscB=int(map(cc[6], 0, 127, 0, 7));
  noiseAmt=map(cc[7], 0, 127, 0, 10);
  valfour=map(cc[8], 0, 127, 0, 10);
  mOffsetA=map(cc[9], 0, 127, 0, .2);
  mOffsetB=map(cc[10], 0, 127, 0, .2);
  mMoveA=map(cc[11], 0, 127, 1.5, 5);
  mMoveB=map(cc[12], 0, 127, .0, 1.0);
  mFeedback=map(cc[13], 0, 127, .0, 2.0);

  ampA = kampA;
  ampB = kampB;
  oscA = oscA +boscA;
  if (oscA > 7) {
    oscA=0;
  }

  oscB = oscB +boscB;
  if (oscB > 7) {
    oscB=0;
  }
  speedA = speedA+kspeedA;
  speedB = speedB+kspeedB;
  //offsetA = offsetA+mOffsetA;
  //offsetB = offsetB+mOffsetB;
  //kmoveA = kmoveA + mMoveA;
  //kmoveB = kmoveB + mMoveB;
  //feedbackAmt = feedbackAmt + mFeedback;
  noiseAmt = noiseAmt + knoise;
  valfour = valfour + kcolor;
  
  noise.set("u_time", millis() / 1000.0);
  bkg.set("u_time", millis() / 1000.0);
  bkg.set("ampA", ampA);
  bkg.set("ampB", ampB);
  bkg.set("offsetA", offsetA);
  bkg.set("offsetB", offsetB);
  bkg.set("speedA", speedA);
  bkg.set("speedB", speedB);
  bkg.set("oscillatorA", oscA);
  bkg.set("oscillatorB", oscB);
  bkg.set("noiseAmt", noiseAmt);
  bkg.set("moverA", kmoveA);
  bkg.set("moverB", kmoveB);
  bkg.set("feedbackAmt", feedbackAmt);


  bkg2.set("u_time", millis() / 1000.0);
  bkg2.set("ampA", ampA);
  bkg2.set("ampB", ampB);
  bkg2.set("offsetA", offsetA);
  bkg2.set("offsetB", offsetB);
  bkg2.set("speedA", speedA);
  bkg2.set("speedB", speedB);
  bkg2.set("oscillatorA", oscA);
  bkg2.set("oscillatorB", oscB);
  bkg2.set("noiseAmt", noiseAmt);
  bkg2.set("moverA", kmoveA);
  bkg2.set("moverB", kmoveB);
  
  imageMode(CORNER);
  image(bkgImg, 720, 0, 200, 480);
  hue.set("hueAdjust", valfour);
  
  if (bwOn ==1) {

    c.shader(bw);
    image(bwmodeOn, 761.7, 417.5, 50, 50);
  } else {
    image(colormodeOn, 761.7, 417.5, 50, 50);
  }


  if (cameraOn ==0) {
    image(eyeClosed, 827.8, 418, 50, 50);
    bk.shader(bkg);
    bk.beginDraw();
    bk.rect(0, 0, width, height);
    bk.image(bk, 0, 0);
    bk.filter(bkg);
    bk.filter(hue);
    if ( bwOn ==1) {
      bk.filter(bw);
    } else {
      bk.filter(hue);
    }
    bk.endDraw();
    noStroke();
    image(bk, 0, 0, 720, 480);
  }

  //cam.read();
  if (cameraOn ==1) {
    image(eyeOpen, 827.8, 418, 50, 50);
    c.beginDraw();
    c.image(img, 0, 0, 720, 480);
    c.filter(bkg2);
    c.filter(hue);
    if ( bwOn ==1) {
      c.filter(bw);
    }

    c.endDraw();
    image(c, 0, 0, 720, 480);
  }


  imageMode(CENTER);
  //knobA
  pushMatrix();

  translate(789.7, 112.5);
  rotate(rot);
  image(knob, 0, 0, 30, 30);

  popMatrix();

  //knobB

  pushMatrix();

  translate(847.8, 112.5);
  rotate(rotB);
  image(knobB, 0, 0, 30, 30);

  popMatrix();

  //knobC

  pushMatrix();

  translate(789.7, 163);
  rotate(rotC);
  image(knobC, 0, 0, 30, 30);

  popMatrix();


  //knobD

  pushMatrix();

  translate(847.8, 163);
  rotate(rotD);
  image(knobD, 0, 0, 30, 30);

  popMatrix();


  //knobE

  pushMatrix();

  translate(789.7, 239.2);
  rotate(rotE);
  image(knobE, 0, 0, 30, 30);

  popMatrix();

  //knobF
  pushMatrix();

  translate(848.8, 239.2);
  rotate(rotF);
  image(knobF, 0, 0, 30, 30);

  popMatrix();


  //knobG
  pushMatrix();

  translate(790.4, 289);
  rotate(rotG);
  image(knobG, 0, 0, 30, 30);

  popMatrix();


  //knobH
  pushMatrix();

  translate(819.2, 388.9);
  rotate(rotH);
  image(knobH, 0, 0, 50, 50);

  popMatrix();

  //knobI
  pushMatrix();

  translate(848.5, 289.1);
  rotate(rotI);
  image(knobI, 0, 0, 30, 30);

  popMatrix();


  //knobJ
  pushMatrix();

  translate(790.4, 335.8);
  rotate(rotJ);
  image(knobJ, 0, 0, 30, 30);

  popMatrix();

  //knobK
  pushMatrix();

  translate(848.5, 335.8);
  rotate(rotK);
  image(knobK, 0, 0, 30, 30);

  popMatrix();


  imageMode(CORNER);
  //int x = 776, y=43, w =30, h = 30;


  if (oscA ==0) {
    image(squarev, 776.8, 43.1, 30, 30);
  }

  if (oscA ==1) {
    image(squareh, 776.8, 43.1, 30, 30);
  }
  if (oscA ==2) {
    image(sinev, 776.8, 43.1, 30, 30);
  }

  if (oscA ==3) {
    image(sineh, 776.8, 43.1, 30, 30);
  }
  if (oscA ==4) {
    image(noisev, 776.8, 43.1, 30, 30);
  }

  if (oscA ==5) {
    image(noiseh, 776.8, 43.1, 30, 30);
  }
  if (oscA ==6) {
    image(sawv, 776.8, 43.1, 30, 30);
  }

  if (oscA ==7) {
    image(sawh, 776.8, 43.1, 30, 30);
  }
  //int x2 = 834, y2=43, w2 =30, h2 = 30;

  if (oscB ==0) {
    image(squarevB, 834.5, 43.7, 30, 30);
  }

  if (oscB ==1) {
    image(squarehB, 834.5, 43.7, 30, 30);
  }
  if (oscB ==2) {
    image(sinevB, 834.5, 43.7, 30, 30);
  }

  if (oscB ==3) {
    image(sinehB, 834.5, 43.7, 30, 30);
  }
  if (oscB ==4) {
    image(noisevB, 834.5, 43.7, 30, 30);
  }

  if (oscB ==5) {
    image(noisehB, 834.5, 43.7, 30, 30);
  }
  if (oscB ==6) {
    image(sawvB, 834.5, 43.7, 30, 30);
  }

  if (oscB ==7) {
    image(sawhB, 834.5, 43.7, 30, 30);
  }




  loadPixels();
  if (cameraOn ==1) {
    server.sendImage(c);
  } else {
    server.sendImage(bk);
  }
}


void mousePressed() {

  if (mouseX>x && mouseX <x+w && mouseY>y && mouseY <y+h) {
    boscA=boscA+1;
    print(boscA);
    println("hey");
    if (boscA > 7) {
      boscA=0;
    }
  }

  if (mouseX>x2 && mouseX <x2+w2 && mouseY>y2 && mouseY <y2+h2) {
    boscB=boscB+1;
    print(boscB);
    println("hey");
    if (boscB > 7) {
      boscB=0;
    }
  }

  if (mouseX>x3 && mouseX <x3+w3 && mouseY>y3 && mouseY <y3+h3) {

    cameraOn = cameraOn+1;
    if (cameraOn >1) {
      cameraOn =0;
    }
  }

  if (mouseX>x4 && mouseX <x4+w4 && mouseY>y4 && mouseY <y4+h4) {
    bwOn  = bwOn+1;
    if (bwOn >1) {
      bwOn =0;
    }
  }
}





void knob(int theValue) {
  kampA = theValue;
  rot = map(theValue, 0, 50, 0, 4.8);
  print(rot);
  println("a knob event. setting background to "+theValue);
}

void knobB(int theValue) {
  kampB = theValue;
  rotB = map(theValue, 0, 50, 0, 4.8);
  print(rotB);
  println("a knob b event. setting background to "+theValue);
}

void knobC(int theValue) {
  offsetA = theValue;
  float nuVal = map(theValue, 0, 200, 0, .2);
  rotC = map(nuVal, 0, .2, 0, 4.8);
  print(rotC);
  println("a knob c event. setting background to "+theValue);
}
void knobD(int theValue) {
  offsetB = theValue;
  float nuVal = map(theValue, 0, 200, 0, .2);
  rotD = map(nuVal, 0, .2, 0, 4.8);
  print(rotD);
  println("a knob d event. setting background to "+theValue);
}

void knobE(int theValue) {
  kspeedA = theValue;
  float nuVale = map(theValue, 0, 200, 0, .5);
  rotE = map(nuVale, 0, .5, 0, 4.8);
  print(rotE);
  println("a knob e event. setting background to "+theValue);
}
void knobF(int theValue) {
  kspeedB = theValue;
  float nuValf = map(theValue, 0, 200, 0, .5);
  rotF = map(nuValf, 0, .5, 0, 4.8);
  print(rotF);
  println("a knob f event. setting background to "+theValue);
}

void knobG(int theValue) {
  knoise = theValue;
  float nuValg = map(theValue, 0, 20, 0, 10);
  rotG = map(nuValg, 0, 10, 0, 4.8);
  print(rotG);
  println("a knob g event. setting background to "+theValue);
}
void knobH(int theValue) {
  kcolor= theValue;
  float nuValh = map(theValue, 0, 200, 0, 10);
  rotH = map(nuValh, 0, 10, 0, 4.8);
  print(rotH);
  println("a knob h event. setting background to "+theValue);
}
void knobI(int theValue) {

  float nuVali = map(theValue, 0, 200, 1.5, 5);
  kmoveA = nuVali;
  rotI = map(nuVali, 1.5, 5, 0, 4.8);
  print(rotI);
  println("a knob i event. setting background to "+theValue);
}
void knobJ(int theValue) {

  float nuValj = map(theValue, 0, 200, .0, 1.);
  kmoveB= nuValj;
  rotJ = map(nuValj, .0, 1., 0, 4.8);
  print(rotJ);
  println("a knob j event. setting background to "+theValue);
}

void knobK(int theValue) {

  float nuValk = map(theValue, 0, 200, .0, 2);
  feedbackAmt= nuValk;
  rotK = map(nuValk, .0, 2., 0, 4.8);
  print(rotK);
  println("a knob k event. setting background to "+theValue);
}


void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  cc[number] = value;
}
void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  hit=pitch;
}
