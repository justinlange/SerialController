color darkBlue = color(40,40,180);
color lightBlue = color(80,80,180);
color highlight = color(120,120,200);
color darkRed = color(100,0,0);
color lightRed = color(160,20,20);


float a;
float n = 255;
int resetKnob;

void createKnobs(){

cp5 = new ControlP5(this);

  int spacing = 150;
  int size = spacing;
  int counter = 0;

  Group g1 = cp5.addGroup("g1")
        .setPosition(25, spacing*4)
        .setBackgroundHeight(int(spacing*1.1))
        .setBackgroundColor(color(255, 50))
        .activateEvent(true)
        .setWidth(spacing*3)
        ;


  cp5.addKnob("interval")
      .setRange(0, 500)
      .setValue(125)
      .setPosition(0, 0)
      .setRadius(50)
      .setSize(size, size)
      .setDragDirection(Knob.HORIZONTAL)
      .setGroup(g1)
      .setCaptionLabel("interval")
      .setBroadcast(true)
      .setId(19)
                          ; 
  color red = color(255,0,0);

  for (int j=0;j<3;j++) {           
    for (int i=0;i<6;i++) {
      counter++;

      cp5.addGroup("group"+counter)
            .setPosition(20+i*spacing/2, 20+j*int(spacing*1.3))
            .activateEvent(true)
            .setId(counter)
            //.close()
            .setWidth(size/2)
            .setBarHeight(size/10)
            ;    


      cp5.addKnob("knob" + counter)
          .setColorBackground(darkBlue)  
          .setColorForeground(lightBlue)  
          .setRange(0, 99)
          .setValue(0)
          .setPosition(0, size/2)
          .setRadius(spacing/2)
          .setSize(size/2, size/2)
          .setDragDirection(Knob.HORIZONTAL)
          .setGroup("group"+counter)
          .setCaptionLabel("reps")
          .setBroadcast(true)
          .setId(counter)
          ;  
      
      cp5.addKnob("Tknob" + counter)
          .setColorBackground(darkRed)  
          .setColorForeground(lightRed)      
          .setColorActive(color(255, 40, 65))        
          .setRange(5, 500)
          .setValue(50)
          .setPosition(0, 0)
          .setRadius(size/2)
          .setSize(size/2, size/2)
          .setDragDirection(Knob.HORIZONTAL)
          .setGroup("group"+counter)
          .setCaptionLabel("timing")
          .setBroadcast(true)
          .setId(counter)
          ;  

    }
  }
}

void flashKnob(int theY) {


  cp5.get(Knob.class,"knob"+theY).setColorBackground(highlight);
  resetKnob =  theY;
  knobTimer[theY] = millis();
  fretArray.get(theY-1).on();
  

}

long[] knobTimer = new long[20];

void resetKnobColor() {
  
 for(int i=1;i<19;i++){   
  if(millis() > knobTimer[i] + 100) {
      cp5.get(Knob.class,"knob"+i).setColorBackground(darkBlue);
      fretArray.get(i-1).off();

    }    
  }
}


/*
void updateColor() {
  if(a>blueAtRest){
   a -= .1;
  }
  for(int i=1;i<19;i++){
    cp5.get(Knob.class,"knob"+i).setColorBackground(color(80,80,a));
  }
}
*/
