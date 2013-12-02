void writeOldString(int[] gridNumber, int[] zStrikes, char letter) {
  
    int[] millisBetween = new int[18]; 
    int[] pinStrikes = new int[18];
    int[] writeHighLength = new int[18];
    int phraseLength; 
    int runLimit = 18;
    String writeString = new String("");

   
    for(int i=0;i<18;i++){
      millisBetween[i] = 0;
      pinStrikes[i] = 0;
      writeHighLength[i] = 0;
    }
    
      int counter = 0;  
      
      for (int i=0;i<runLimit;i++) {
        counter++;
          if (gridNumber[i] > 0) {            
            pinStrikes[i] = zStrikes[i]/100;    
          }
        }
     
      writeString = writeString + letter;
      
      if(letter == 'p'){
        for(int i=0;i<runLimit;i++) writeString = writeString + pinStrikes[i] + ",";
        writeString = writeString + pinStrikes[17] + "\n";
      }
      
      if(writeString.getBytes().length < 64){
            myPort.write(writeString);
            print("good repsString write! byteSize = " + writeString.getBytes().length +  "  string written: " + writeString);
      }else{
        println("string too long! ");
        println(writeString.getBytes().length);
        print(writeString);

      }
   }  

