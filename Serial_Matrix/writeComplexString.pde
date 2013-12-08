void writeComplexString(char letter) {
  if (cp5.getGroup("g1")!=null) {

    int[] millisBetween = new int[18]; 
    int[] pinStrikes = new int[18];
    int[] writeHighLength = new int[18];
    int phraseLength; 
    int runLimit = 18;
    String writeString = new String("");


    for (int i=0;i<18;i++) {
      millisBetween[i] = 0;
      pinStrikes[i] = 0;
      writeHighLength[i] = 0;
    }

    int counter = 0;  

    for (int i=0;i<runLimit;i++) {
      counter++;
      if (cp5.getController("knob"+counter).isBroadcast()) {
        int val = int(cp5.getController("knob"+counter).getValue());            
        pinStrikes[i] = val;
        if (val>0) {
          flashKnob(counter);
        }
      }
      if (cp5.getController("Tknob"+counter).isBroadcast()) {
        int val = int(cp5.getController("Tknob"+counter).getValue());
        millisBetween[i] = val;
      }
    }

    writeString = writeString + letter;

    if (letter == 'p') {
      for (int i=0;i<runLimit;i++) writeString = writeString + pinStrikes[i] + ",";
      writeString = writeString + pinStrikes[17] + "\n";
    }
    else if (letter == 'd') {
      for (int i=0;i<18;i++) writeString = writeString + millisBetween[i] + ",";
      writeString = writeString + millisBetween[17] + "\n";
    }


    //for(int i=0;i<18;i++) writeString = writeString + millisBetween[i] + ",";
    //for(int i=0;i<17;i++) writeString = writeString + writeHighLength[i] + ",";
    //writeString = writeString + writeHighLength[runLimit+1] + "\n";

    //--- Gal's Advice ---//
    //send bytes intstead of strings
    //0-250 represent values, which give sme four remaining characters for special purposes (delimiter, end of packet, etc)

    if (writeString.getBytes().length < 64) {
      if (serialOn) myPort.write(writeString);
      print("good repsString write! byteSize = " + writeString.getBytes().length +  "  string written: " + writeString);
    }
    else {
      println("string too long! ");
      println(writeString.getBytes().length);
      print(writeString);
    }
  }
}

void writeOldString(int[] gridNumber, int[] zStrikes, char letter) {

  int[] millisBetween = new int[18]; 
  int[] pinStrikes = new int[18];
  int[] writeHighLength = new int[18];
  int phraseLength; 
  int runLimit = 18;
  String writeString = new String("");


  for (int i=0;i<18;i++) {
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

  if (letter == 'p') {
    for (int i=0;i<runLimit;i++) writeString = writeString + pinStrikes[i] + ",";
    writeString = writeString + pinStrikes[17] + "\n";
  }

  if (writeString.getBytes().length < 64) {
    myPort.write(writeString);
    print("good repsString write! byteSize = " + writeString.getBytes().length +  "  string written: " + writeString);
  }
  else {
    println("string too long! ");
    println(writeString.getBytes().length);
    print(writeString);
  }
}  

