class FingerCatcher {

  ArrayList<PVector> fingerPositions;

  FingerCatcher(LeapMotionP5 myLeap) {
    fingerPositions = new ArrayList<PVector>();
  }

  void getFingers(boolean drawGrid, boolean drawFingers) { 

    for (Finger finger : leap.getFingerList()) {
      PVector fingerPos = leap.getTip(finger);
      //     checkRectSimple(fingerPos);
      fingerPositions.add(fingerPos);

      if (drawFingers) {
      }
      if (drawGrid) {
        //checkRectSimple(fingerPos);
      }
      //println("x: " + fingerPos.x + "  y:" + fingerPos.y + "  z: " + fingerPos.z);
    }

    println(fingerPositions.size());
  }

  void clearVector() {
    fingerPositions.clear();
  }  

  void drawFingerPoints() {
    for (int i=0;i<fingerPositions.size();i++) {
      fill(255);
      ellipse(fingerPositions.get(i).x, fingerPositions.get(i).y, 10, 10);
    }
  }

  void drawGrid() {

    final int gridCountX = 18;
    int gridSpacing = width/gridCountX;  
    int leftSide = 0;
    int rightSide = 0;

    for (int i=0;i<fingerPositions.size();i++) {
      PVector fingerPos = fingerPositions.get(i);

        for (int j=0;j<gridCountX; j++) {
          leftSide = j*gridSpacing;
          rightSide = j*gridSpacing + gridSpacing;
          fill(0); 

          if (fingerPos.x > leftSide && fingerPos.x < rightSide) {
            fill(0, 255, 0);
            if (fingerPos.z < 0) {
              fill(255, 0, 0);
            }
            rect(j*gridSpacing, 0, gridSpacing, height);
            fill(255, 255, 255);
            String textString = str(j+1);
            text(textString, leftSide, height/2);
          }
          /*
    if(fingerPos.z < 0){
           fill(255,0,0);    
           rect(i*gridSpacing,0,gridSpacing,height);
           }
           */
        }
      }
  }
}


