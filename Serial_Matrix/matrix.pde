int timeSignature = 4;
int gridLength = 16;
int startingInterval;


Dong[][] d;
int nx = 8;
int ny = 18;

void setupMatrix(){
  
  startingInterval = (60*1000)/bpm;
  
   cp5.printPublicMethodsFor(Matrix.class);
  
   cp5.addMatrix("myMatrix")
     .setPosition(700, 0)
     .setSize(300, 300)
     .setGrid(nx, ny)
     .setGap(1, 1)
     .setInterval(startingInterval)
     .setMax(270.0)
     .setMin(1.0)
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
boolean[] getMatrixValues() {
  
  int[][] tempInt = cp5.get(Matrix.class,"myMatrix").getCells();
  boolean[] tempArray = new boolean[nx*ny];
  int counter = 0;
 
  cp5.get(Matrix.class,"myMatrix").update(); 
 
  for (int x = 0;x<nx-1;x++) {
    for (int y = 0;y<ny-1;y++) {
      tempArray[counter] = cp5.get(Matrix.class,"myMatrix").get(x, y);
      //println("Matrix Cells: " + tempInt[nx-1][ny-1]);
      counter++;

    }
  }
  
  println("new batch: ");
  for(int i=0;i<(nx*ny)-1;i++){
    print(tempArray[i] + ","); 
  }  
  return tempArray;
}

void resetInterval(int _bpm){
  startingInterval = (60*1000)/_bpm;
  cp5.get(Matrix.class,"myMatrix").setInterval(startingInterval);
  println("bpm: " + _bpm + " new interval: "  +startingInterval);
}

void myMatrix(int theX, int theY) {
  
  try{
    int reps = int(cp5.get(Knob.class,"knob"+theY).getValue());
    //println("got it: "+theX+", "+theY);
    playNote(theY);
  }catch (RuntimeException e) {
   print("couldn't read matrix"); 
  }
  
  //println("osc message send: /rep " + theY + " , " + reps);
  
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

