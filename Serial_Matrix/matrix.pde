Dong[][] d;
int nx = 32;
int ny = 18;

void setupMatrix(){
  
   cp5.printPublicMethodsFor(Matrix.class);

  
   cp5.addMatrix("myMatrix")
     .setPosition(800, 0)
     .setSize(320, 360)
     .setGrid(nx, ny)
     .setGap(1, 1)
     .setInterval(125)
     .setMode(ControlP5.MULTIPLES)
     .setColorBackground(color(120))
     .setBackground(color(40))
     ;
  
      d = new Dong[nx][ny];
  for (int x = 0;x<nx;x++) {
    for (int y = 0;y<ny;y++) {
      d[x][y] = new Dong();
    }
  }  
  noStroke();
  smooth();
  
  
}

void resetInterval(int interval){
  cp5.get(Matrix.class,"myMatrix").setInterval(interval);
}

void myMatrix(int theX, int theY) {
  int reps = int(cp5.get(Knob.class,"knob"+theY).getValue());
  flashKnob(theY);
  sendOSCMessage("/rep",theY, reps);
  println("got it: "+theX+", "+theY);
  d[theX][theY].update();
}

class Dong {
  float x, y;
  float s0, s1;

  Dong() {
    float f= random(-PI, PI);
    x = cos(f)*random(100, 150);
    y = sin(f)*random(100, 150);
    s0 = random(2, 10);
  }

  void display() {
    s1 += (s0-s1)*0.1;
    ellipse(x, y, s1, s1);
  }

  void update() {
    s1 = 50;
  }
}

