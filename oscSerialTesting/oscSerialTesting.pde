import oscP5.*;
import processing.serial.*;
 
Serial serial;
OscSerial osc;
String serialName = Serial.list()[6];;
 
int led = 0;
 
void setup() {
  serial = new Serial(this, serialName, 115200);
  osc = new OscSerial(this, serial);
  osc.plug(this, "myFunction", "/helloFromArduino");
}
 
void draw() {
}
 
void keyPressed() {
  // send an OSC message
  OscMessage msg = new OscMessage("/led");
 
  if (led == 1) led = 0;
  else led = 1;
 
  msg.add(led);
  osc.send(msg);
}
 
void plugTest(int value) {
  println("Plugged from /pattern: " + value);
}
 
// Any unplugged message will come here
void oscEvent(OscMessage theMessage) {
  println("Message: " + theMessage + ", " + theMessage.isPlugged());
}
