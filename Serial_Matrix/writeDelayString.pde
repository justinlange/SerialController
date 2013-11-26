void writeDelayString() {
       if (cp5.getGroup("g1")!=null) {

    int[] millisBetween = new int[18]; 
    String writeString = new String("");

   
    for(int i=0;i<18;i++){
      millisBetween[i] = 0;
    }
    
      int counter = 0;  
      
      for (int i=0;i<18;i++) {
        counter++;
          if (cp5.getController("Tknob"+counter).isBroadcast()) {
            int val = int(cp5.getController("Tknob"+counter).getValue());
            millisBetween[i] = val;            
          }
        }
     
      writeString = writeString +"d";
      
      for(int i=0;i<18;i++) writeString = writeString + millisBetween[i] + ",";
      //for(int i=0;i<18;i++) writeString = writeString + pinStrikes[i] + ",";
      //for(int i=0;i<17;i++) writeString = writeString + writeHighLength[i] + ",";
      writeString = writeString + millisBetween[17] + "\n";
 
      if(writeString.getBytes().length < 64){
            myPort.write(writeString);
            print("good millisString write! byteSize = " + writeString.getBytes().length +  "  string written: " + writeString);
      }else{
        println("string too long! ");
        println(writeString.getBytes().length);
        print(writeString);

      }
   }  
}
