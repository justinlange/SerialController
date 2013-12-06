public int bpm;
int tempo; // how long a sixteenth note is in milliseconds
int clock; // the timer for moving from note to note
int beat; // which beat we're on
boolean beatTriggered; // only trigger each beat once
ControlP5 gui;

void setupDrumMachine() {
  
 gui = new ControlP5(this);
  gui.setColorForeground(color(128, 200));
  gui.setColorActive(color(255, 0, 0, 200));
  //gui.setPosition(300,500,this);
  Toggle h;
  Toggle s;
  Toggle k; 
  int baseX = 500;
  
  for (int i = 0; i < 16; i++)
  {
    h = gui.addToggle("hat" + i, false, baseX+10+i*24, 50, 14, 30);
    h.setId(i);
    h.setCaptionLabel("hat");
    s = gui.addToggle("snr" + i, false, baseX+10+i*24, 100, 14, 30);
    s.setId(i);
    s.setCaptionLabel("snr");
    k = gui.addToggle("kik" + i, false, baseX+10+i*24, 150, 14, 30);
    k.setId(i);
    k.setCaptionLabel("kik");
  }
  gui.addNumberbox("bpm", 120, 10, 5, 20, 15);
  bpm = 120;
  tempo = 125;
  clock = millis();
  beat = 0;
  beatTriggered = false;
  
  textFont(createFont("Arial", 16));
  
  
}
