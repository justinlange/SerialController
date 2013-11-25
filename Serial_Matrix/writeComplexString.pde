void writeComplexString() {
       if (cp5.getGroup("g1")!=null) {

    int[] millisBetween = new int[18]; 
    int[] pinStrikes = new int[18];
    int[] writeHighLength = new int[18];
    int phraseLength; 
    String writeString = new String("");

   
    for(int i=0;i<18;i++){
      millisBetween[i] = 0;
      pinStrikes[i] = 0;
      writeHighLength[i] = 0;
    }
    
      int counter = 0;  
      
      for (int i=0;i<18;i++) {
        counter++;
          if (cp5.getController("knob"+counter).isBroadcast()) {
            int val = int(cp5.getController("knob"+counter).getValue());
            
            millisBetween[i] = delay;
            pinStrikes[i] = val;
            writeHighLength[i] = 10;
            
          }
        }
     
      writeString = writeString +"s";
      
      //for(int i=0;i<18;i++) writeString = writeString + millisBetween[i] + ",";
      for(int i=0;i<18;i++) writeString = writeString + pinStrikes[i] + ",";
      //for(int i=0;i<17;i++) writeString = writeString + writeHighLength[i] + ",";
      writeString = writeString + writeHighLength[17] + "\n";
      
      if(writeString.getBytes().length < 64){
            myPort.write(writeString);
            print("good write! byteSize = " + writeString.getBytes().length +  "  string written: " + writeString);
      }else{
        println("string too long! ");
        println(writeString.getBytes().length);
        print(writeString);

      }
   }  
}

void checkStr(char id, String stringToSend) {
  
}
