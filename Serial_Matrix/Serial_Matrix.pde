import processing.serial.*;
import controlP5.*; 

import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
LeapMotionP5 leap;


Serial myPort; 
ControlP5 cp5;

FingerCatcher fingerCatch;

int delay = 10;
boolean leapMode = false;

Dot[] dots;
Dot myDot = new Dot(500, 500, 100);

public void setup() { 
  size(800, 800);
  //frameRate(8);


  leap = new LeapMotionP5(this);

  if (leapMode) fingerCatch = new FingerCatcher(leap);


  println(Serial.list());
  int portVal;
  if (Serial.list().length > 6) {
    portVal = 7;
  }
  else {
    portVal = 0;
  }
  println("selected port: " + portVal + " -- " + Serial.list()[portVal]);  
  String portName = Serial.list()[portVal];
  myPort = new Serial(this, portName, 115200);


  //create p5 knobs
  createKnobs();

  //createFretboard();
}



public void draw() {
  background(0);

  if (leapMode) {
    fingerCatch.getFingers();
    fingerCatch.drawFingerPoints();
    //  fingerCatch.drawGrid();
    fingerCatch.drawTriGrid();
    //fingerCatch.buildSerialString();
    fingerCatch.clearVector();
  }

  /*
  for (Finger finger : leap.getFingerList()) {
   PVector fingerPos = leap.getTip(finger);
   //     checkRectSimple(fingerPos);
   
   fill(255);
   ellipse(fingerPos.x, fingerPos.y, 10, 10);
   println("x: " + fingerPos.x + "  y:" + fingerPos.y + "  z: " + fingerPos.z);
   }
   */

  //myDot.drawCircle();
  /*
  for (int i=0;i<17;i++){
   dots[i].drawCircle(); 
   }
   */

  //drawFrets();
}



void controlEvent(ControlEvent theEvent) {

  if (theEvent.isGroup()) {
    int groupId = theEvent.getGroup().getId();
    boolean broadcastStatus = cp5.getController("knob"+groupId).isBroadcast();
    cp5.getController("knob"+groupId).setBroadcast(!broadcastStatus);

    println("got an event from group "
      +theEvent.getGroup().getName()
      +", isOpen? "+theEvent.getGroup().isOpen()
      );
  } 
  else if (theEvent.isController()) {
    //println("controller!");

    // int knobId = theEvent.getController().getId();

    if (theEvent.getController().getId() == 19) {
      delay = int(theEvent.getController().getValue());
      println("delay is now: " + delay);
    }


    /*
    println("got something from a controller "
     +theEvent.getController().getName()
     );
     */
  }
}

void serialString(int id) {
}


void keyPressed() {

  if (key==' ') writeComplexString('p');      
  if (key=='d') writeComplexString('d');

  if (key=='o') {
    if (cp5.getGroup("g1")!=null) {

      int counter = 0;                
      for (int i=0;i<6;i++) {
        for (int j=0;j<3;j++) { 
          counter++;
          if (cp5.getController("knob"+counter).isBroadcast()) {
            //println(cp5.getController("knob"+counter).getValue());
            int val = int(cp5.getController("knob"+counter).getValue());
            String writeString = "s"+delay+"," + val/10 + ","+ counter + "," + int(counter+1) + "\n";
            println("counter: " + counter + "  " + writeString);
            myPort.write(writeString);
          }
        }
      }
    }
  }
}










/*
a list of all methods available for the Group Controller
 use ControlP5.printPublicMethodsFor(Group.class);
 to print the following list into the console.
 
 You can find further details about class Group in the javadoc.
 
 Format:
 ClassName : returnType methodName(parameter type)
 
 
 controlP5.ControlGroup : Group activateEvent(boolean) 
 controlP5.ControlGroup : Group addListener(ControlListener) 
 controlP5.ControlGroup : Group hideBar() 
 controlP5.ControlGroup : Group removeListener(ControlListener) 
 controlP5.ControlGroup : Group setBackgroundColor(int) 
 controlP5.ControlGroup : Group setBackgroundHeight(int) 
 controlP5.ControlGroup : Group setBarHeight(int) 
 controlP5.ControlGroup : Group showBar() 
 controlP5.ControlGroup : Group updateInternalEvents(PApplet) 
 controlP5.ControlGroup : String getInfo() 
 controlP5.ControlGroup : String toString() 
 controlP5.ControlGroup : boolean isBarVisible() 
 controlP5.ControlGroup : int getBackgroundHeight() 
 controlP5.ControlGroup : int getBarHeight() 
 controlP5.ControlGroup : int listenerSize() 
 controlP5.ControllerGroup : CColor getColor() 
 controlP5.ControllerGroup : ControlWindow getWindow() 
 controlP5.ControllerGroup : ControlWindowCanvas addCanvas(ControlWindowCanvas) 
 controlP5.ControllerGroup : Controller getController(String) 
 controlP5.ControllerGroup : ControllerProperty getProperty(String) 
 controlP5.ControllerGroup : ControllerProperty getProperty(String, String) 
 controlP5.ControllerGroup : Group add(ControllerInterface) 
 controlP5.ControllerGroup : Group bringToFront() 
 controlP5.ControllerGroup : Group bringToFront(ControllerInterface) 
 controlP5.ControllerGroup : Group close() 
 controlP5.ControllerGroup : Group disableCollapse() 
 controlP5.ControllerGroup : Group enableCollapse() 
 controlP5.ControllerGroup : Group hide() 
 controlP5.ControllerGroup : Group moveTo(ControlWindow) 
 controlP5.ControllerGroup : Group moveTo(PApplet) 
 controlP5.ControllerGroup : Group open() 
 controlP5.ControllerGroup : Group registerProperty(String) 
 controlP5.ControllerGroup : Group registerProperty(String, String) 
 controlP5.ControllerGroup : Group remove(CDrawable) 
 controlP5.ControllerGroup : Group remove(ControllerInterface) 
 controlP5.ControllerGroup : Group removeCanvas(ControlWindowCanvas) 
 controlP5.ControllerGroup : Group removeProperty(String) 
 controlP5.ControllerGroup : Group removeProperty(String, String) 
 controlP5.ControllerGroup : Group setAddress(String) 
 controlP5.ControllerGroup : Group setArrayValue(float[]) 
 controlP5.ControllerGroup : Group setColor(CColor) 
 controlP5.ControllerGroup : Group setColorActive(int) 
 controlP5.ControllerGroup : Group setColorBackground(int) 
 controlP5.ControllerGroup : Group setColorForeground(int) 
 controlP5.ControllerGroup : Group setColorLabel(int) 
 controlP5.ControllerGroup : Group setColorValue(int) 
 controlP5.ControllerGroup : Group setHeight(int) 
 controlP5.ControllerGroup : Group setId(int) 
 controlP5.ControllerGroup : Group setLabel(String) 
 controlP5.ControllerGroup : Group setMouseOver(boolean) 
 controlP5.ControllerGroup : Group setMoveable(boolean) 
 controlP5.ControllerGroup : Group setOpen(boolean) 
 controlP5.ControllerGroup : Group setPosition(PVector) 
 controlP5.ControllerGroup : Group setPosition(float, float) 
 controlP5.ControllerGroup : Group setStringValue(String) 
 controlP5.ControllerGroup : Group setUpdate(boolean) 
 controlP5.ControllerGroup : Group setValue(float) 
 controlP5.ControllerGroup : Group setVisible(boolean) 
 controlP5.ControllerGroup : Group setWidth(int) 
 controlP5.ControllerGroup : Group show() 
 controlP5.ControllerGroup : Group update() 
 controlP5.ControllerGroup : Group updateAbsolutePosition() 
 controlP5.ControllerGroup : Label getCaptionLabel() 
 controlP5.ControllerGroup : Label getValueLabel() 
 controlP5.ControllerGroup : PVector getPosition() 
 controlP5.ControllerGroup : String getAddress() 
 controlP5.ControllerGroup : String getInfo() 
 controlP5.ControllerGroup : String getName() 
 controlP5.ControllerGroup : String getStringValue() 
 controlP5.ControllerGroup : String toString() 
 controlP5.ControllerGroup : Tab getTab() 
 controlP5.ControllerGroup : boolean isCollapse() 
 controlP5.ControllerGroup : boolean isMouseOver() 
 controlP5.ControllerGroup : boolean isMoveable() 
 controlP5.ControllerGroup : boolean isOpen() 
 controlP5.ControllerGroup : boolean isUpdate() 
 controlP5.ControllerGroup : boolean isVisible() 
 controlP5.ControllerGroup : boolean setMousePressed(boolean) 
 controlP5.ControllerGroup : float getValue() 
 controlP5.ControllerGroup : float[] getArrayValue() 
 controlP5.ControllerGroup : int getHeight() 
 controlP5.ControllerGroup : int getId() 
 controlP5.ControllerGroup : int getWidth() 
 controlP5.ControllerGroup : void remove() 
 java.lang.Object : String toString() 
 java.lang.Object : boolean equals(Object) 
 
 */
