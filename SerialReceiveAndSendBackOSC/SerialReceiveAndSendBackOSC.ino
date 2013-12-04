/*
* Set the LED according to incoming OSC control
*/
#include <OSCBundle.h>
#include <OSCBoards.h>

#ifdef BOARD_HAS_USB_SERIAL
#include <SLIPEncodedUSBSerial.h>
SLIPEncodedUSBSerial SLIPSerial( thisBoardsSerialUSB );
#else
#include <SLIPEncodedSerial.h>
 SLIPEncodedSerial SLIPSerial(Serial);
#endif

void writeBack(int knobNumber, int tVar) {
  
    OSCBundle bndl;
    bndl.add("/writeback").add(knobNumber);
    bndl.add("/writeback").add(tVar);
    SLIPSerial.beginPacket();
    bndl.send(SLIPSerial); // send the bytes to the SLIP stream
    SLIPSerial.endPacket(); // mark the end of the OSC Packet
    bndl.empty(); // empty the bundle to free room for a new one
}

void repWrite(OSCMessage &msg)
{
  int knobNumber,tVar;
  
  knobNumber = msg.getInt(0);
  tVar = msg.getInt(1);
  
  writeBack(knobNumber,tVar);

   // if (msg.isInt(0))
  

}


void setup() {
    SLIPSerial.begin(9600);   // set this as high as you can reliably run on your platform
#if ARDUINO >= 100
    while(!Serial)
      ;   // Leonardo bug
#endif

}
//reads and dispatches the incoming message
void loop(){ 
  OSCBundle bundleIN;
  int size;

  while(!SLIPSerial.endofPacket())
    if( (size =SLIPSerial.available()) > 0)
    {
       while(size--)
          bundleIN.fill(SLIPSerial.read());
     }
  
  if(!bundleIN.hasError()){
   bundleIN.dispatch("/rep", repWrite);
  }
/*
    OSCBundle bndl;
    //BOSCBundle's add' returns the OSCMessage so the message's 'add' can be composed together
    bndl.add("/analog/0").add((int32_t)analogRead(0));
    bndl.add("/analog/1").add((int32_t)analogRead(1));


    bundleIN.add("/digital/5").add((digitalRead(5)==HIGH)?"HIGH":"LOW");

    SLIPSerial.beginPacket();
    bundleIN.send(SLIPSerial); // send the bytes to the SLIP stream
    SLIPSerial.endPacket(); // mark the end of the OSC Packet
    bundleIN.empty(); // empty the bundle to free room for a new one

*/
    delay(50);


}




