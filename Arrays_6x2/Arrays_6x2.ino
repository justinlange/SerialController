

int mDelay = 200;   
int mDelayS = 20;
int pHigh = 255;
int pLow = 210;

const int switchPinCount = 12;
const int LedPinCount = 12; 
int brightPin = 0;
int strikingPin = 0;

boolean percusBool = false;

boolean dChordState, minChordState, allPwmState, aChordState, minChordBool, gChordState, percusState, hamState;
int minChordCount = 0;


const int switchPins[] = {
  24,22,44,46,50,48,40,42,34,38,30,26}; //on board
const int ledPins[] = { 
  23,25,49,47,27,51,45,43,39,41,31,35 };

const int stringPins[] = {
  2,3,4,5,6,7,8,9,10,11,12,13,28,29,32,33,36,37 };



int s1f1 = 33;
int s2f1 = 9;
int s3f1 = 2; //sometimes triggers reset
int s4f1 = 11;
int s5f1 = 32; 
int s6f1 = 7;

int s1f2 = 28;
int s2f2 = 10;
int s3f2 = 3;
int s4f2 = 29;
int s5f2 = 5;
int s6f2 = 37;


int s1f3 = 8;
int s2f3 = 6;
int s3f3 = 4; // sometimes triggers reset
int s4f3 = 12;
int s5f3 = 13;
int s6f3 = 36;


const int stringPos [] = {
  s1f1,s2f1,s3f1,s4f1,s5f1,s6f1,s1f2,s2f2,s3f2,s4f2,s5f2,s6f2,s1f3,s2f3,s3f3,s4f3,s5f3,s6f3};
//const int stringPos [] = {6,9,2,7,13,3,4,8,5,10,11,12,x1,x2,x3,x4,x5,x6 };

String oldNames[] = { 
  "s1f1","s2f1","s3f1","s4f1","s5f1","s6f1","s1f2","s2f2","s3f2","s4f2","s5f2","s6f2","s1f3","s2f3","s3f3","s4f3","s5f3","s6f3"};

String root[] = {
  "G", "Gflat", "F", "Fflat", "E", "Eflat", "D", "Dflat", "C", "Cflat", "B", "Bflat", "A", "AFlat"
};  

/*
String chordShapes[] = {
 "A#","A#m","A#sus2","A#sus4","A#add2","A#add9","A#add4","A#madd2","A#madd9","A#madd4","A#add2add4","A#madd2add4","A#aug","A#dim","A#dim7","A#5","A#6","A#m6","A#6/9","A#m6/9","A#6/7","A#m6/7","A#maj6/7","A#7","A#m7","A#maj7","A#7sus4","A#7sus2","A#7add4","A#m7add4","A#9","A#m9","A#maj9","A#9sus4","A#11","A#m11","A#maj11","A#13","A#m13","A#maj13","A#13sus4","A#mmaj7","A#mmaj9","A#7#9","A#7b9","A#7#5","A#7b5","A#m7#5","A#m7b5","A#maj7#5","A#maj7b5","A#9#5","A#9b5","A#/A","A#/B","A#/C","A#/C#","A#/D","A#/D#","A#/E","A#/F","A#/F#","A#/G","A#/G#","A#m/A","A#m/B","A#m/C","A#m/C#","A#m/D","A#m/D#","A#m/E","A#m/F","A#m/F#","A#m/G","A#m/G#"};
 
 */
boolean switchState = false;
boolean serialOn;

short millisBetween[18],lastMillis[18],pinStrikes[18],writeHighLength[18],repsCompleted[18];
short phraseLength = 1000;

void setup() {
  serialOn = true;

  if(serialOn == true){
    Serial.begin(9600);
  }


  for (int thisPin = 0; thisPin < LedPinCount; thisPin++)  {
    pinMode(ledPins[thisPin], OUTPUT);      
  }
  for (int thisPin = 0; thisPin < switchPinCount; thisPin++)  {
    pinMode(switchPins[thisPin], INPUT);      
  }

  for (int thisPin=0; thisPin < 18; thisPin++){
    pinMode(stringPos[thisPin], OUTPUT);
  }
  
  initPercusArrays();
}


void loop() {

  //runLeds();
  //runPins();
  //debugMode();
  //runPWMpins();
  //runPWMfade();
  //evalChords();
  //evalPercus();
  //readSerial();
  // readSerialNums();
  //delay(2);
  
  runPercusSimple(pinStrikes, phraseLength);

}

void serialEvent(){
  readSerialPhrase(); 
}

void initPercusArrays(){
   for (int i=0;i<18;i++){
      lastMillis[i] = millis(); 
      millisBetween[i] = 100;
      pinStrikes[i] = 0;
      writeHighLength[i] = 50; 
  } 
}

void readSerialPhrase(){

  if (Serial.find("p")) {
    Serial.println("found a p!");   
    
    int byteCounter = 0;
    
    for(int i=0;i<25;i++)   {
      if(Serial.peek()  > -1 ){
        byteCounter++;
        pinStrikes[i] = Serial.parseInt();
        repsCompleted[i] = pinStrikes[i]; 
        
        Serial.print("Adding data to pinStrikes array at position ");
        Serial.print(i);
        Serial.print("  at byteCounter: ");
        Serial.print(byteCounter);
        Serial.print(" with value: ");
        Serial.println(pinStrikes[i]);
      }else{
        Serial.print("no data at position ");
        Serial.println(i);
      } 
    }
  }   
}


void runPercusSimple(short _pinStrikes[], int _phraseLength) {


  //Serial.println("inside of runPercusSimple!");


  for (int i = 0; i < 18; i++) { 
    
    if(pinStrikes[i] > 0 && repsCompleted[i] > 0){
      debugTwo("lastMillis", lastMillis[i], "millis between", millisBetween[i]);
      if(millis() < lastMillis[i] + millisBetween[i] && millis() < lastMillis[i] + millisBetween[i] + writeHighLength[i]) {
        digitalWrite(stringPos[i], HIGH);  
        debugTwo("writing HIGH to pin", stringPos[i], "at rep", repsCompleted[i]);
      }else{
        lastMillis[i] = millis();    
        digitalWrite(stringPos[i], LOW);
        repsCompleted[i]--;   
        debugTwo("writing LOW to pin", stringPos[i], "at rep", repsCompleted[i]);
        
      }
    }  
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

void readSerial(){


  if (Serial.available()) {
    //int inByte = Serial.read();
    char val = Serial.read();
    if (val == 'H') { // If H was received
      runPins();  
    }
    //Serial.write(inByte); 
  }
  delay(2);

}




