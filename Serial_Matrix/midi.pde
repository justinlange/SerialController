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

//we can asscertain the first midi note and disregard the others by checking to see if the
//veolocity is greater than zero

    if (vel > 0 ) {
      pushString(pin, newVel);
      println("pin: " + pin + " old vel: " + vel + "  remapped velocity: " + newVel + "time: " + millis()/1000);
    }
  }
}

void noteOff(Note note) {

  int pit = note.getPitch();
  
  //we could have the arduino fire continuously (rather than keeping track of how many times a pin has struck
  //and instead wait for an 'off' signal to stop the pin from firing. stuck pins, wheneevr they happen, should be
  //easily reset by hitting the trigger button again. 
  
  //alternatively, since only midi messages, when repeating, only seem to happen 30 times a second, with 15 of these
  //being 'off'

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

