/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
boolean printStuff = true;
long timer;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

ArrayList<OscMessage> messages;
int knobMapping[] = {0,1,2,3,4,5,6,0,0,7,8,9,10,11,12,0,0,13,14,15,16,17,18};


void setup() {
  messages = new ArrayList<OscMessage>();
  timer = millis();
  size(400, 400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 9000);
  oscP5.plug(this, "pwm", "/pwm");
  //oscP5.plug(this, "
}

public void pwm(float thePin, float theVal) {  
  println("### plug event method. received a message /pwm.");
  println(" received: " + thePin + " the val " +theVal);
}


void draw() {
  background(0);
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");

  myMessage.add(123); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}

void beatTest(){
  
  
  
}



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    /* print the address pattern and the typetag of the received OscMessage */
  

    if (theOscMessage.checkTypetag("fff")) {
      String sGroup = "/rep";
      parseBCR(theOscMessage, sGroup, true);   
    }else if (theOscMessage.checkTypetag("ffi")) {
      String sGroup = "/pwm";
      parseBCR(theOscMessage, sGroup,false);
    }else if (theOscMessage.checkTypetag("fif")) {
      String sGroup = "/write";
      parseBCR(theOscMessage, sGroup, false);
    }else if (theOscMessage.checkTypetag("fii")) {
      String sGroup = "/seq";
      parseBCR(theOscMessage, sGroup, false);
    }else if (theOscMessage.checkTypetag("fiii")) {
      //debugOne("getting fiii ", 0);
      sendMessages();
    }else{
      print("osc message not mapped: " + theOscMessage);
      print(" addrpattern: "+theOscMessage.addrPattern());
      println(" typetag: "+theOscMessage.typetag());
    }  
  }
}

void sendMessages(){
  boolean[] dupes = new boolean[256];
  for(int i=0;i<256;i++){
   dupes[i]=false; 
  }
  for(int i = messages.size()-1; i >= 0; i--){
    int knobNumber = messages.get(i).get(0).intValue();
    if(dupes[knobNumber] == false){
      oscP5.send(messages.get(i), myRemoteLocation);
      println(knobNumber + "  " + i + "  " + messages.get(i).addrPattern());
      dupes[knobNumber] = true;
    }
    messages.remove(i);
  }
}

void parseBCR(OscMessage theOscMessage, String sGroup, boolean remap) {      
      int knobNumber = getNum(theOscMessage.addrPattern());
      if(remap) knobNumber = knobMapping[knobNumber];
      int tVar = int(theOscMessage.get(0).floatValue()*1000);
      OscMessage myMessage = new OscMessage(sGroup);
      myMessage.add(knobNumber);
      myMessage.add(tVar);     
      messages.add(myMessage);
      
      
      if(timeCheck()){
        oscP5.send(myMessage, myRemoteLocation);
        debugTwo(theOscMessage.addrPattern(), tVar, "knobNumber", knobNumber);
      }
      //println(myMessage);
      
}

boolean timeCheck(){
  long now = millis();
  if (now-timer > 10) {       
    timer = millis();
    return true;
  }else{
    return false;
  }
  
}

void sendMessage() {
   OscMessage myMessage = new OscMessage("/test");

  myMessage.add(123); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation); 
  
  
}

int getNum(String addrPattern){
  int knobNumber;
  String kString = addrPattern;
      kString = kString.substring(8, kString.length() - 2);
      return knobNumber = int(kString);
}

