// MESSAGE PROTOCOL OBJECT
#include <OscSerial.h>

// tile support libraries
#include <EthernetUdp.h>
#include <SPI.h>  

OscSerial oscSerial;
long timer;


int mDelay = 200;   
int mDelayS = 50;
int pHigh = 255;
int pLow = 210;

const int switchPinCount = 12;
const int LedPinCount = 12; 
int brightPin = 0;
int strikingPin = 0;

boolean percusBool = false;
boolean debugBool = false;
boolean firstCall = false;

boolean dChordState, minChordState, allPwmState, aChordState, minChordBool, gChordState, percusState, hamState;
int minChordCount = 0;

const int switchPins[] = {24,22,44,46,50,48,40,42,34,38,30,26}; //on board
const int ledPins[] = { 23,25,49,47,27,51,45,43,39,41,31,35 };
const int stringPins[] = {2,3,4,5,6,7,8,9,10,11,12,13,28,29,32,33,36,37 };
//int s1f1,s2f1,s3f1,s4f1,s5f1,s6f1,s1f2,s2f2,s3f2,s4f2,s5f2,s6f2,s1f3,s2f3,s3f3,s4f3,s5f3,s6f3;

int s1f1 = 33;
int s2f1 = 9;
int s3f1 = 2; 
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
int s3f3 = 4; 
int s4f3 = 12;
int s5f3 = 13;
int s6f3 = 36;



const int stringPos [] = {
  s1f1,s2f1,s3f1,s4f1,s5f1,s6f1,s1f2,s2f2,s3f2,s4f2,s5f2,s6f2,s1f3,s2f3,s3f3,s4f3,s5f3,s6f3};

String oldNames[] = { 
  "s1f1","s2f1","s3f1","s4f1","s5f1","s6f1","s1f2","s2f2","s3f2","s4f2","s5f2","s6f2","s1f3","s2f3","s3f3","s4f3","s5f3","s6f3"};


boolean switchState = false;
boolean serialOn;

short millisBetween[18],pinStrikes[18],writeHighLength[18],repsCompleted[18];
unsigned long lastMillis[18];
boolean highState[18];
short phraseLength = 1000;

//------ OSC -------- //



void setup() {
  
  //initPins();
  Serial.begin(115200);
  oscSerial.begin(Serial); 


  for (int thisPin = 0; thisPin < LedPinCount; thisPin++)  pinMode(ledPins[thisPin], OUTPUT);      
  for (int thisPin = 0; thisPin < switchPinCount; thisPin++)   pinMode(switchPins[thisPin], INPUT);      
  for (int thisPin=0; thisPin < 18; thisPin++) pinMode(stringPos[thisPin], OUTPUT);


  initPercusArrays();
}


void loop() {
/*
    long now = millis();
  if (now-timer > 100) {
    
    OscMessage msg("/helloFromArduino");
    msg.add("another string"); // <-- this could be any data 
    oscSerial.send(msg);       
    timer = now;
  }
  
  */
  
  // important! 
  oscSerial.listen();
 
 //debugString("inside of loop");
  
  //runLeds();
  //runPins();
  //debugMode();
  //runPWMpins();
  //runPWMfade();
  //evalChords();
  //evalPercus();
  //readSerial();
  // readSerialNums();
  delay(2);

  runPercusSimple(pinStrikes, phraseLength);

}

void oscEvent(OscMessage &m) { // *note the & before msg
  // receive a message 
  //Serial.print(m.getInt(0));
  m.plug("/rep", setReps); 
  m.plug("/pwm", sendOSCBack);
  m.plug("/write", setWriteHigh);

 //oscSerial.send(m);

}

void myFunction(OscMessage &m) {  // *note the & before msg
  // getting to the message data 
  int value = m.getInt(0); 
  if (value == 0) digitalWrite(13, LOW);
  if (value == 1) digitalWrite(13, HIGH);
}

void sendOSCBack(OscMessage &m) {
  oscSerial.send(m);
}

void setReps(OscMessage &m){
  
  firstCall = true;

  
  int rPin = m.getInt(0);
  int rVal = m.getInt(1);
  pinStrikes[rPin] = rVal;
  millisBetween[rPin] = 100/rVal;
  repsCompleted[rPin] = pinStrikes[rPin];   
  
}

void setWriteHigh(OscMessage &m){
  
  //firstCall = true;

  int rPin = m.getInt(0);
  int rVal = m.getInt(1);
 
 for(int i=0;i<18;i++){ 
  writeHighLength[rPin] = max(rVal-millisBetween[i],1);
 }
}


/*
void serialEvent(){
  
  char evalChar = (char)Serial.read();
  
  if (evalChar == 'd'){
    readSerialData();
  }else if (evalChar == 'p'){
    readSerialPhrase(); 
  }else if (evalChar == 'l'){
    writeLow(); 
  }

}

void readSerialData(){

  debugString("found a d!");   

  int byteCounter = 0;
  
  for(int i=0;i<18;i++)   {
    if(Serial.peek()  > -1 ){
      byteCounter++;
      millisBetween[i] = Serial.parseInt();
      debugTwo("millisBetween at", stringPos[i], "is", millisBetween[i]);
    }
  }
}


void readSerialPhrase(){

  debugString("found a p!");    
  debugOne("millis at top of readSerialPhrase", millis());

  firstCall = true;

  int byteCounter = 0;

  for(int i=0;i<18;i++)   {
    if(Serial.peek()  > -1 ){
      byteCounter++;
      pinStrikes[i] = Serial.parseInt();
      repsCompleted[i] = pinStrikes[i]; 

      debugThree( "Adding data to pinStrikes array at position"
        ,i
        ,"at byteCounter"
        ,byteCounter
        ,"with value"
        ,pinStrikes[i]
        );
    }
    else{
      debugOne("no data at position",i);
    } 
  }
}   

*/


void writeLow(){
  debugString("found an l");
  
  for(int i=0;i<18;i++) { 
    digitalWrite(stringPos[i], LOW);   
  }
}


void initPercusArrays(){
  for (int i=0;i<18;i++){
    lastMillis[i] = millis(); 
    millisBetween[i] = 250;
    pinStrikes[i] = 0;
    writeHighLength[i] = 10; 
    highState[i] = false;
  } 
}



void runPercusSimple(short _pinStrikes[], int _phraseLength) {


  //Serial.println("inside of runPercusSimple!");

  if(firstCall){
    firstCall = false; 
    for(int i = 0; i < 18; i++){
      lastMillis[i] = millis();
    }
  }

  for (int i = 0; i < 18; i++) { 

    if(pinStrikes[i] > 0 && repsCompleted[i] > 0){
      if(millis() < lastMillis[i] + millisBetween[i] && millis() < lastMillis[i] + millisBetween[i] + writeHighLength[i]) {
        if(!highState[i]){
          digitalWrite(stringPos[i], HIGH);  
          debugTwo("writing HIGH to pin", stringPos[i], "at rep", repsCompleted[i]);
          highState[i] = true;
          debugThree(
          "millis", millis(),
          "lastMillis + millisBtween", lastMillis[i] + millisBetween[i],  
          "lastMillis + millisBetween + writeHighLength", lastMillis[i] + millisBetween[i] + writeHighLength[i] 
            );
        }
      }
      else{
        lastMillis[i] = millis();    
        digitalWrite(stringPos[i], LOW);
        repsCompleted[i]--;   
        debugTwo("writing LOW to pin", stringPos[i], "at rep", repsCompleted[i]);
        highState[i] = false;
        debugThree(
        "millis", millis(),
        "lastMillis + millisBtween", lastMillis[i] + millisBetween[i],  
        "lastMillis + millisBetween + writeHighLength", lastMillis[i] + millisBetween[i] + writeHighLength[i] 
          );

      }
    }  
  }
}

/*
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
 
 
 */


