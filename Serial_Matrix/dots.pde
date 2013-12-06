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
     fillc=200;
   }
   
   void off(){
     fillc=50;   
   }
}


