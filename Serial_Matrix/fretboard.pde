//Dot[] dots;




void createDots() {
 // int counter = 0;
  
int hSpacing = 30;
 int numFrets = 5;
 int vSpacing = hSpacing*4;
 int offset = hSpacing;
  
  
 // myDot = new Dot(100,100,100);
  
  for(int i=0;i<6;i++){
    for(int j=0;j<3;j++){
      Dot tempDot = new Dot(i*hSpacing,vSpacing/3+j*vSpacing+(i%2)*hSpacing,hSpacing);
      fretArray.add(tempDot);
     // counter++;
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
 
 //draw the fretboard representation
 for(int i=0;i<6;i++)line(i*hSpacing,0,i*hSpacing,vSpacing*4);
 for(int i=0;i<2;i++) line(0,i*(hSpacing/7),hSpacing*5,i*(hSpacing/7));
 for(int i=0;i<numFrets;i++) line(0,i*vSpacing,hSpacing*5,i*vSpacing);

  drawDots();
/*

//draw the circles with information
fill(50,200);
for(int i=0;i<6;i++){
  for(int j=0;j<3;j++){
    
  // ellipse(i*hSpacing,vSpacing/3+j*vSpacing+(i%2)*hSpacing,hSpacing,hSpacing);
    
  }
}
*/
  popMatrix();
}





