int percusCount = 0;

void evalPercus(){
   percusState = digitalRead(switchPins[11]);

    
  if( percusState == true){
        percusCount = millis();
        percusBool == true; 
  }
  
  if(percusBool == true && millis() - percusCount > 100){
   percusBool = false; 
  }
    
  if(percusState == true){    
  analogWrite(s1f3, pHigh);
  analogWrite(s2f3, pHigh);
  analogWrite(s3f3, pHigh); 
  analogWrite(s3f3, pHigh);
  analogWrite(s4f3, pHigh);
  analogWrite(s5f3, pHigh);
   //delay(50);
  }      
  } 
  

