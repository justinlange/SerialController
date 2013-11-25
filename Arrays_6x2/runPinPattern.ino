void runPinPattern(int nDelay, int nReps, int nPatternStart, int nPatternEnd){


  for(int reps = 0; reps < nReps; reps++){ 
    for (int thisPin = nPatternStart; thisPin < nPatternEnd; thisPin++) { 
      digitalWrite(stringPos[thisPin], HIGH);
      delay(nDelay);
      digitalWrite(stringPos[thisPin], LOW);
      delay(nDelay);
    } 
  } 
}



void runPercus(int millisBetween[], int pinStrikes[], int writeHighLength[], int phraseLength) {
  
  Serial.println("inside of runPercus!");

  
  int lastMillis[18];
  int phraseLastMillis = millis();
  
  /*
  for(int i=0;i<18;i++){
   lastMillis[i] = millis(); 
   Serial.println("Running lastMillis!");

  }
  */

  //while(phraseLastMillis + phraseLength < millis() ){  

    for (int i = 0; i < 18; i++) { 
      if(pinStrikes[i] > 0){
        if(lastMillis[i] + millisBetween[i] > millis()) {
          digitalWrite(stringPos[i], HIGH);   
          }
          if(lastMillis[i] + millisBetween[i] > millis() + writeHighLength[i]){
            lastMillis[i] = millis();    
            digitalWrite(stringPos[i], LOW);   
          }
        }  
      }
   // }
  }

