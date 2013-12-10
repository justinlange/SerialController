void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    /* print the address pattern and the typetag of the received OscMessage */

    if (theOscMessage.checkTypetag("fff")) {
      String sGroup = "/rep";
      parseBCRknobs(theOscMessage, sGroup, true, true);
    }
    else if (theOscMessage.checkTypetag("ffi")) {
      String sGroup = "/pwm";
      //parseBCRknobs(theOscMessage, sGroup, false, true);
    }
    else if (theOscMessage.checkTypetag("fif")) {
      String sGroup = "/write";
      parseWriteKnobs(theOscMessage, sGroup, false, true);
    }
    else if (theOscMessage.checkTypetag("fii")) {
      String sGroup = "/seq";
      parseBCRknobs(theOscMessage, sGroup, false, false);
    }
    else if (theOscMessage.checkTypetag("fiii")) {
      //debugOne("getting fiii ", 0);
    }
    else if (theOscMessage.checkTypetag("ifff")) {
      String sGroup = "/buttons";
      parseBCRbuttons(theOscMessage, sGroup);
    }
    else if (theOscMessage.checkTypetag("ffif")) {
      String sGroup = "/mb";
      parseMbKnobs(theOscMessage, sGroup, true, true);
    }
    else {
      print("osc message not mapped: " + theOscMessage);
      print(" addrpattern: "+theOscMessage.addrPattern());
      println(" typetag: "+theOscMessage.typetag());
    }
  }
}

void sendMessages() {
  boolean[] dupes = new boolean[256];
  for (int i=0;i<256;i++) {
    dupes[i]=false;
  }
  for (int i = messages.size()-1; i >= 0; i--) {
    int knobNumber = messages.get(i).get(0).intValue();
    if (dupes[knobNumber] == false) {
      oscP5.send(messages.get(i), myRemoteLocation);
      println("sending messages: " + knobNumber + "  " + i + "  " + messages.get(i).addrPattern());
      dupes[knobNumber] = true;
    }
    messages.remove(i);
  }
}

void parseBCRbuttons(OscMessage theOscMessage, String sGroup) {
  int buttonNumber = getNum(theOscMessage.addrPattern());
  boolean tVar = boolean((theOscMessage.get(0).intValue()));
  println("buttonNumber: " + buttonNumber + " state: " + tVar);

  switch(buttonNumber) {
  case 106:
    if (serialMode) writeComplexString('d');
    break;
  case 107:
    if (serialMode) { 
      writeComplexString('p');
    }
    else {
      sendMessages();
    }
    break;
  case 108:    
    cp5.get(Toggle.class, "freeMode").setState(!tVar);
    sendMessages();
    break;
  }
}


void parseWriteKnobs(OscMessage theOscMessage, String sGroup, boolean remap, boolean setSoft) {      
  int knobNumber = getNum(theOscMessage.addrPattern());
  if (remap) knobNumber = knobMapping[knobNumber];
  int tVar = int(theOscMessage.get(0).floatValue()*100);
  println(sGroup+knobNumber+tVar);


  for (int i=1; i<19; i++) {
    cp5.get(Knob.class, "knob"+i).setValue(tVar);
  }


  if (!serialMode) {
    OscMessage myMessage = new OscMessage(sGroup);
    myMessage.add(knobNumber);
    myMessage.add(tVar); 
    messages.add(myMessage);
  }
}


void parseMbKnobs(OscMessage theOscMessage, String sGroup, boolean remap, boolean setSoft) {      
  int knobNumber = getNum(theOscMessage.addrPattern());
  knobNumber = knobNumber -24;
  int tVar = int(theOscMessage.get(0).floatValue()*100);
  println(sGroup+knobNumber+tVar);



  if (setSoft) {
    //cp5.get(Knob.class, "knob"+knobNumber).setValue(tVar);
    cp5.get(Knob.class, "knob"+knobNumber).setValue(tVar);
    }
}


    void parseBCRknobs(OscMessage theOscMessage, String sGroup, boolean remap, boolean setSoft) {      
      int knobNumber = getNum(theOscMessage.addrPattern());
      if (remap) knobNumber = knobMapping[knobNumber];
      int tVar = int(theOscMessage.get(0).floatValue()*100);

      if (setSoft) {
        cp5.get(Knob.class, "Tknob"+knobNumber).setValue(tVar*5);
      }
      else {
        sendOSCMessage(sGroup, knobNumber, tVar);
      }

      /*   if(timeCheck(10)){
       oscP5.send(myMessage, myRemoteLocation);
       debugTwo(theOscMessage.addrPattern(), tVar, "knobNumber", knobNumber);
       }  
       */
    }




  void sendOSCMessage(String sGroup, int knobNumber, int tVar) {
    OscMessage myMessage = new OscMessage(sGroup);
    myMessage.add(knobNumber);
    myMessage.add(tVar); 

    if (!serialMode) {
      oscP5.send(myMessage, myRemoteLocation);
    }
  }

  int getNum(String addrPattern) {
    int knobNumber;
    String kString = addrPattern;
    kString = kString.substring(8, kString.length() - 2);
    return knobNumber = int(kString);
  }

