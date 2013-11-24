void runPWMpins(){

for(int i = 0; i< 18; i++){
       analogWrite(stringPos[i], 255); 
       delay(500);
       analogWrite(stringPos[i], 0);
      delay(500); 

  }
delay(1000);

}

void runPWMfade(){
  for(int i = 0; i< 18; i++){
    for(int j=255; j>0; j--){
       analogWrite(stringPos[i], j); 
       delay(2);
    }
       delay(250);
       analogWrite(stringPos[i], 0);
      delay(500); 

  }
delay(1000);
}
 
