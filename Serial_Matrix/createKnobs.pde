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


  cp5.addKnob("delay")
      .setRange(0, 100)
      .setValue(50)
      .setPosition(0, 0)
      .setRadius(50)
      .setSize(size, size)
      .setDragDirection(Knob.HORIZONTAL)
      .setGroup(g1)
      .setCaptionLabel("delay")
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
          .setRange(0, 99)
          .setValue(3)
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
          .setColorBackground(color(100, 20, 25))  
          .setColorForeground(color(140, 40, 65))      
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
