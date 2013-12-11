void setupMidi() {
  midiIO = MidiIO.getInstance(this);
  midiIO.printDevices();
  midiIO.plug(this, "noteOn", 2, 0);
  midiIO.plug(this, "noteOff", 2, 0);
  //midiIO.plug(this,"controllerIn",2,0);
  midiIO.plug(this, "programChange", 2, 0);
}

int noteOn = 0;

void noteOn(Note note) {
  int vel = note.getVelocity();
  int pit = note.getPitch();
  int pin = 20;


  int newVel = int(map(vel, 0, 127, 50, 1));

  if (pit > 35 && pit < 99) {
    pin = ableMapping[pit];
  }
  if (pin >= 0 && pin <= 17) { //this can be commented out once all values from push are properly mapped

    if (noteOn < 1 ) {
      pushString(pin, newVel);
      noteOn = 2;
      println("pin: " + pin + " old vel: " + vel + "  remapped velocity: " + newVel + "time: " + millis()/1000);
    }
  }
}

void noteOff(Note note) {

  noteOn--;
  int pit = note.getPitch();
}

/*
void controllerIn(Controller controller){
 
 int num = controller.getNumber();
 int val = controller.getValue();
 
 println("controller number:" + num + " value: " + val);
 
 
 fill(255,num*2,val*2,num*2);
 stroke(255,num);
 ellipse(num*5,val*5,30,30);
 }
 */

void programChange(ProgramChange programChange) {

  int num = programChange.getNumber();
  //println("controller change:" + num);
}

