/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
boolean printStuff = false;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
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



/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.isPlugged()==false) {
    /* print the address pattern and the typetag of the received OscMessage */
  

    if (theOscMessage.checkTypetag("fff")) {
      String sGroup = "/rep";
      parseBCR(theOscMessage, sGroup);   
    }else if (theOscMessage.checkTypetag("ffi")) {
      String sGroup = "/pwm";
      parseBCR(theOscMessage, sGroup);
    }else if (theOscMessage.checkTypetag("fif")) {
      String sGroup = "/write";
      parseBCR(theOscMessage, sGroup);
    }else if (theOscMessage.checkTypetag("fii")) {
      String sGroup = "/seq";
      parseBCR(theOscMessage, sGroup);
    }else{
      print("osc message not mapped: " + theOscMessage);
      print(" addrpattern: "+theOscMessage.addrPattern());
      println(" typetag: "+theOscMessage.typetag());
    }  
  }
}

void parseBCR(OscMessage theOscMessage, String sGroup) {      
      int knobNumber = getNum(theOscMessage.addrPattern());
      int tVar = int(theOscMessage.get(0).floatValue()*100);
      OscMessage myMessage = new OscMessage(sGroup);
      myMessage.add(knobNumber);
      myMessage.add(tVar);
      oscP5.send(myMessage, myRemoteLocation);
      debugTwo("rep value", theOscMessage.get(0).floatValue(), "knobNumber", knobNumber);
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

