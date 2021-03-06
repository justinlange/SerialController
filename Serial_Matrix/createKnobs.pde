color darkBlue = color(40,40,180);
color lightBlue = color(80,80,180);
color highlight = color(120,120,200);
color darkRed = color(100,0,0);
color lightRed = color(160,20,20);

float a;
float n = 255;
int resetKnob;
boolean freeMode;

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


  cp5.addKnob("bpm")
      .setRange(10, 200)
      .setValue(bpm)
      .setPosition(0, 0)
      .setRadius(50)
      .setSize(size, size)
      .setDragDirection(Knob.HORIZONTAL)
      .setGroup(g1)
      .setCaptionLabel("bpm" + bpm)
      .setBroadcast(true)
      .setId(19)
      ;
      
   cp5.addToggle("freeMode")
     .setPosition(spacing,0)
     .setSize(50,20)
     .setGroup(g1)
     ;  
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
          .setRange(0, 500)
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



