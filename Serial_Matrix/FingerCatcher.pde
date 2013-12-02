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

  void drawTriGrid() {
    int gridCountX = 6;
    int gridCountY = 3;
    int gridSpacingX = width/gridCountX; 
    int gridSpacingY = height/gridCountY;  
    int leftSide = 0;
    int rightSide = 0; 
    int top = 0;
    int bottom = 0;
    int counter =0;

    for (int i=0;i<fingerPositions.size();i++) {
      PVector fingerPos = fingerPositions.get(i);

      counter = 0; 
      
      for (int j=0;j<gridCountX; j++) {
        for (int k=0;k<gridCountY;k++) {
          leftSide = j*gridSpacingX;
          rightSide = j*gridSpacingX + gridSpacingX;
          top = k*gridSpacingY;
          bottom = k*gridSpacingY+gridSpacingY;
          fill(0); 

          if (fingerPos.x > leftSide && fingerPos.x < rightSide && fingerPos.y > top && fingerPos.y < bottom) {
              fill(0, 255, 0);
            if (fingerPos.z < 0) {
              fill(255, 0, 0);
            }
            rect(j*gridSpacingX, k*gridSpacingY, gridSpacingX, gridSpacingY);
            fill(255, 255, 255);
            //String textString = str(counter+1) + "  bottom: " + str(bottom) + " top: " + str(top) + " fingerPos.y " + str(fingerPos.y);
            String textString = str(counter+1);
            pushMatrix();
            PVector textPos = new PVector(leftSide+gridSpacingX/2,top+gridSpacingY/2);
            translate(textPos.x,textPos.y); 
            //ellipse(textPos.x, textPos.y,50,50);
            rotate(radians(90));
            translate(-textPos.x,-textPos.y); 
            //rect(textPos.x,textPos.y,100,10);
            text(textString, textPos.x,textPos.y);
            popMatrix();
          }
            counter++;

        }
      }
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

