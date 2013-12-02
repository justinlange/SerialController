void serialString() {



    //every 30 milliseconds, send 18 bits

    //map hand z to counter -- each string has a counter

    //if hand hand is half way, counter value is


    //map z values to repetitions

    byte[] myBytes = new byte[3];

    for (int i=0;i<18;i++) {
      myBytes[i]=0; //set array to zero
    }

    //intermediate array of bools

    boolean[] iArray = new boolean[24];
    for (int i=0;i<18;i++) {
      iArray[i] = false;
    }

  int counter = 0;
  for(int i=0;i<3;i++){
    for (int j = 0;j<8;j++) {
      counter++;
      if(iArray[counter] == true){ 
        
        myBytes[i] += 1 << j;    //set the counter beat
      }
    }
  }
  
  //after I have 3 bytes, send to serial
  
  //send a byte that is all ones....
 // Serial.write(myBytes, 3);  //look up syntax

  }

