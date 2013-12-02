class FingerCatcher {

  ArrayList<PVector> fingerPositions;
  ArrayList<SerialValue> myVals;
  int stringNums[];
  int zVals[];
  long lastMillis;
  int pauseLength;
  boolean flipBool;

  FingerCatcher(LeapMotionP5 myLeap) {
      fingerPositions = new ArrayList<PVector>();
      myVals = new ArrayList<SerialValue>();
      stringNums = new int[18];
      zVals = new int[18];
      lastMillis = millis();
      pauseLength = 100;
      flipBool = false;

  }

  void getFingers() { 
    for (Finger finger : leap.getFingerList()) {
      PVector fingerPos = leap.getTip(finger);
      fingerPositions.add(fingerPos);
      //println("x: " + fingerPos.x + "  y:" + fingerPos.y + "  z: " + fingerPos.z);
    }
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

  void oldSerialString(int gridNumber, float playThresh) {
    //println("millis: " +millis());
    SerialValue newVal = new SerialValue(gridNumber, playThresh);
    myVals.add(newVal);
  
  if(myVals.size() > 17){  
      //println("calling oldSerialString, lastMillis is: " + lastMillis + " millis is: " + millis() + " pauseLength is " + pauseLength);
   
    if(millis() > pauseLength + lastMillis){
      println("millis check completed!");
      lastMillis = millis();
        for(int i=0;i<18;i++){
        stringNums[i] = myVals.get(i).gridNumber;
        zVals[i] = int(myVals.get(i).playThresh);
      }
    if(flipBool){  
      writeOldString(stringNums,zVals, 'd');  
      flipBool = !flipBool;
    }else{
      flipBool = !flipBool;
      writeOldString(stringNums,zVals, 'p');  
    } 
    }
    myVals.clear();

  }
}


  void serialString() {



    //every 30 milliseconds, send 18 bits

    //map hand z to counter -- each string has a counter

    //if hand hand is half way, counter value is


    //map z values to repetitions

    byte[] myBytes = new byte[3];

    for (int i=0;i<18;i++) {
      myBytes[i]=0; //set array to zero
    }

    //intermediate array of bools

    boolean[] iArray = new boolean[24];
    for (int i=0;i<18;i++) {
      iArray[i] = false;
    }

  int counter = 0;
  for(int i=0;i<3;i++){
    for (int j = 0;j<8;j++) {
      counter++;
      if(iArray[counter] == true){ 
        
        myBytes[i] += 1 << j;    //set the counter beat
      }
    }
  }
  
  //after I have 3 bytes, send to serial
  
  //send a byte that is all ones....
 // Serial.write(myBytes, 3);  //look up syntax

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
      float playThresh;

      for (int i=0;i<fingerPositions.size();i++) {
        PVector fingerPos = fingerPositions.get(i);

        counter = 0; 

        for (int j=0;j<gridCountX; j++) {
          for (int k=0;k<gridCountY;k++) {
            leftSide = j*gridSpacingX;
            rightSide = j*gridSpacingX + gridSpacingX;
            top = k*gridSpacingY;
            bottom = k*gridSpacingY+gridSpacingY;
            playThresh = int(fingerPos.z);
            playThresh = map(playThresh,1023,-1023,0,1023);
           // println(playThresh);

            fill(0); 
            
            if (fingerPos.x > leftSide && fingerPos.x < rightSide && fingerPos.y > top && fingerPos.y < bottom) {
                oldSerialString(counter, playThresh);
               
            }

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
              PVector textPos = new PVector(leftSide+gridSpacingX/2, top+gridSpacingY/2);
              translate(textPos.x, textPos.y); 
              //ellipse(textPos.x, textPos.y,50,50);
              rotate(radians(90));
              translate(-textPos.x, -textPos.y); 
              //rect(textPos.x,textPos.y,100,10);
              text(textString, textPos.x, textPos.y);
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

