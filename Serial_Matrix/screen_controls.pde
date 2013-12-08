class Dot {
  
  int xPos;
  int yPos;
  int size;
  boolean isActive;
  int fillc, fillo;
    
   Dot(int _xPos, int _yPos, int _size) {
     xPos = _xPos;
     yPos = _yPos;
     size = _size;
     isActive = false;
     fillc = 50;
     fillo = 200; 
   }
    
   void drawDot(){
     fill(fillc,fillo);
     ellipse(xPos,yPos,size,size);
   }
   
   void on(){
     fillc=255;
     fillo = 200; 
   }
   
   void off(){
     fillc=50;
     fillo=200;   
   }
}

//--------end class----------//

void createDots() {
  
 int hSpacing = 30;
 int numFrets = 5;
 int vSpacing = hSpacing*4;
 int offset = hSpacing;
 
  for(int i=0;i<6;i++){
    for(int j=0;j<3;j++){
      Dot tempDot = new Dot(i*hSpacing,vSpacing/3+j*vSpacing+(i%2)*hSpacing,hSpacing);
      fretArray.add(tempDot);
    }
  }
}

void drawDots(){
  for(int i=0; i<fretArray.size();i++){
   fretArray.get(i).drawDot(); 
  } 
}

void drawFrets() {
 stroke(200);
 strokeWeight(2); 
 
 int hSpacing = 30;
 int numFrets = 5;
 int vSpacing = hSpacing*4;
 int offset = hSpacing;
 
 pushMatrix();
 translate(600,50);
 
 for(int i=0;i<6;i++)line(i*hSpacing,0,i*hSpacing,vSpacing*4);
 for(int i=0;i<2;i++) line(0,i*(hSpacing/7),hSpacing*5,i*(hSpacing/7));
 for(int i=0;i<numFrets;i++) line(0,i*vSpacing,hSpacing*5,i*vSpacing);

  drawDots();
  popMatrix();
}

void flashKnob(int theY) {
  cp5.get(Knob.class,"knob"+theY).setColorBackground(highlight);
  resetKnob =  theY;
  knobTimer[theY] = millis();
  fretArray.get(theY-1).on();
}

long[] knobTimer = new long[20];

void resetKnobColor() {
  
 for(int i=1;i<19;i++){   
  if(millis() > knobTimer[i] + 100) {
      cp5.get(Knob.class,"knob"+i).setColorBackground(darkBlue);
      fretArray.get(i-1).off();

    }    
  }
}







