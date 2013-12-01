class Dot {
  
  int xPos;
  int yPos;
  int size;
  boolean isActive;
    
   Dot(int _xPos, int _yPos, int _size) {
     xPos = _xPos;
     yPos = _yPos;
     size = _size;
   }
    
   void drawCircle(){
     fill(50,200);
     ellipse(xPos,yPos,size,size);
   }
}
