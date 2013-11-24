int hamCounter = 0;
int interval = 200;

void evalChords(){
 
  /*
  if(digitalRead(switchPins[10]) == HIGH){
     interval = 100;
  }
    if(digitalRead(switchPins[9]) == HIGH){
    interval = 50;

  }
  
  */
  
  
  dChordState = digitalRead(switchPins[0]);
  aChordState = digitalRead(switchPins[1]);
  gChordState = digitalRead(switchPins[2]);
  minChordBool = digitalRead(switchPins[5]);
  //hamState = digitalRead(switchPins[11]);
  
  if(minChordBool == HIGH && millis() - minChordCount > 200 ){
    minChordCount = millis();
    minChordState =! minChordState;
  }
  
  if(hamState == true){
    if(millis() - hamCounter > interval){
      noChords();
      hamCounter = millis();
     delay(2); 
  }
  }
    
  
  if(minChordState == true){
        digitalWrite(ledPins[5], HIGH);
  }else{
        digitalWrite(ledPins[5], LOW);
  }
  
  if(aChordState == true){
    digitalWrite(ledPins[1], HIGH);
  } else{
    digitalWrite(ledPins[1], LOW);

  }
  
    if(dChordState == true){
    digitalWrite(ledPins[0], HIGH);
  } else{
    digitalWrite(ledPins[0], LOW);

  }
  
  if(gChordState == true){
    digitalWrite(ledPins[2], HIGH);
  } else{
    digitalWrite(ledPins[2], LOW);

  }

  
  
  

 if (aChordState == HIGH && minChordState == HIGH){
    a();
 }else if (aChordState == HIGH && minChordState == LOW){
    aMin();
 }else if (gChordState == HIGH && minChordState == LOW){
         g();
  }else if(gChordState == HIGH && minChordState == HIGH){
    gMin();    
 }else if (dChordState == HIGH && minChordState == LOW){
         d();
  }else if(dChordState == HIGH && minChordState == HIGH){
    dMin();
  }else if(percusBool == false){
    noChords();
}
}


void d() {
  analogWrite(s2f1, pLow);
  analogWrite(s1f3, pLow);
  analogWrite(s4f2, pHigh);
  analogWrite(s5f3, pHigh);
  analogWrite(s6f2, pHigh);
}  

void dMin() {
  analogWrite(s2f1, pLow);
  analogWrite(s1f3, pLow);
  digitalWrite(s4f2, pHigh);
  digitalWrite(s5f3, pHigh);
  digitalWrite(s6f1, pHigh);
}

void noChords() {
 for(int i=0; i<18; i++){
analogWrite(stringPos[i], 0);
//analogWrite(stringPos[i], LOW);
} 
}

void a() {
  analogWrite(s3f2, pHigh);
  analogWrite(s4f2, pHigh);
  analogWrite(s5f2, pHigh);    
}  

void aMin() {
  analogWrite(s3f2, pHigh);
  analogWrite(s4f2, pHigh);
  analogWrite(s5f1, pHigh);    
}

void g() {
  analogWrite(s2f2, pHigh);
  analogWrite(s1f3, pHigh);
  analogWrite(s6f3, pHigh);
}

void gMin(){
  digitalWrite(s1f3, pLow);
  digitalWrite(s2f3, pLow);
  digitalWrite(s4f3, pHigh);
  digitalWrite(s5f3, pHigh);
  digitalWrite(s6f3, pHigh);
}
  


void noLeds(){
   for (int thisPin = 0; thisPin < 12; thisPin++) { 
      digitalWrite(ledPins[thisPin], LOW);
    } 
}
