void debugString(String firstString){
  if(debugBool){
    Serial.println(firstString);
  }
}


void debugOne(String firstString, unsigned long firstInt){
    if(debugBool){

  Serial.print(firstString);
  Serial.print(": ");
  Serial.println(firstInt);
    }
}

void debugTwo(String firstString, unsigned long firstInt, String secondString, unsigned long secondInt){
    if(debugBool){

  Serial.print(firstString);
  Serial.print(": ");
  Serial.print(firstInt);
  Serial.print("  ");
  Serial.print(secondString);
  Serial.print(": ");
  Serial.println(secondInt);
    }
}

void debugThree(String firstString, unsigned long firstInt, String secondString, unsigned long secondInt, String thirdString, unsigned long thirdInt) {
    if(debugBool){

  Serial.print(firstString);
  Serial.print(": ");
  Serial.print(firstInt);
  Serial.print("  ");
  Serial.print(secondString);
  Serial.print(": ");
  Serial.print(secondInt);
  Serial.print("  ");
  Serial.print(thirdString);
  Serial.print(": ");
  Serial.println(thirdInt);
    }
}

void readSerialNums(){

  // Assumes a string in from the serial port like so:
  // s ledNumber, brightness \n
  // for example: "s5,200\n":

  int nDelay = 0;
  int nReps = 0;
  int nPatternStart = 0;
  int nPatternEnd = 0;

  if (Serial.find("s")) {
    nDelay = Serial.parseInt(); // parses numeric characters before the comma
    nReps = Serial.parseInt();// parses numeric characters after the comma
    nPatternStart = Serial.parseInt();// parses numeric characters after the comma
    nPatternEnd = Serial.parseInt();// parses numeric characters after the comma


    // print the results back to the sender:
    Serial.print("nDelay: " );
    Serial.print(nDelay);
    Serial.print(" reps ");
    Serial.print(nReps);
    Serial.print(" nPatternStart ");
    Serial.print(nPatternStart);
    Serial.print(" nPatternEnd ");
    Serial.print(nPatternEnd);
    Serial.println("  nReps");


    // run some pins:
    Serial.println("inside of readSerialNums");
    runPinPattern(nDelay,nReps,nPatternStart,nPatternEnd);
  }
}

void runPins(){
  
  debugString("inside of runPins");

  for (int thisPin = 0; thisPin < 18; thisPin++) { 
    digitalWrite(stringPos[thisPin], HIGH);
    delay(mDelay);
    digitalWrite(stringPos[thisPin], LOW);
  }
  delay(mDelay);

  for (int thisPin = 0; thisPin < 18; thisPin++) { 
    digitalWrite(stringPos[thisPin], LOW);
  }
}


void runLeds(){
  for (int thisPin = 0; thisPin < 12; thisPin++) { 
    digitalWrite(ledPins[thisPin], HIGH);
    delay(mDelayS);
    digitalWrite(ledPins[thisPin], LOW);
    delay(mDelay);
  }
}
boolean evalSwitches(){
  for(int thisPin = 0; thisPin < switchPinCount; thisPin ++ ){
    boolean mSwitchState = digitalRead(switchPins[thisPin]); 
    if(mSwitchState == true){ 
      return true;
    }
  }
  return false;
}

void debugMode( ){
  int offset = 0;

  for(int thisPin = 0; thisPin < switchPinCount; thisPin ++ ){
    switchState = digitalRead(switchPins[thisPin]); 
    if(switchState == true){

      if(serialOn == true){
        Serial.print("serial state: ");
        Serial.print(serialOn);
        Serial.print("thisPin: ");
        Serial.print(thisPin);
        Serial.print("  switch: ");
        Serial.print(switchPins[thisPin]);
        Serial.print("  led pin: ");
        Serial.print(ledPins[thisPin]);
        Serial.print("   stringPos:  ");
        Serial.println(stringPos[thisPin+offset]);
      }
      digitalWrite(ledPins[thisPin], HIGH);
      digitalWrite(stringPos[thisPin+offset], HIGH);
      brightPin = thisPin;
      strikingPin = thisPin+offset;
    }
  }

  switchState = evalSwitches();

  for (int thisPin = 0; thisPin < LedPinCount; thisPin++) { 
    if(switchState == false){
      digitalWrite(ledPins[thisPin], LOW);       
    }
  }   

  for (int thisPin=0; thisPin < 18; thisPin++){
    if(switchState == false){
      digitalWrite(stringPos[thisPin], LOW);
    }
  }   

  if(serialOn == true){
    delay(mDelay);
  } 
}
