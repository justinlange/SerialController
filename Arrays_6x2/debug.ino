
void debugOne(String firstString, int firstInt){
  Serial.print(firstString);
  Serial.print(": ");
  Serial.println(firstInt);
}

void debugTwo(String firstString, int firstInt, String secondString, int secondInt){
  Serial.print(firstString);
  Serial.print(": ");
  Serial.print(firstInt);
  Serial.print("  ");
  Serial.print(secondString);
  Serial.print(": ");
  Serial.println(secondInt);
}

void debugThree(String firstString, int firstInt, String secondString, int secondInt, String thirdString, int thirdInt) {
  
  Serial.print(firstString);
  Serial.print(": ");
  Serial.print(firstInt);
  Serial.print("  ");
  Serial.print(secondString);
  Serial.print(": ");
  Serial.print(secondInt);
  Serial.print("  ");
  Serial.print(thirdString);
  Serial.print(": ");
  Serial.println(thirdInt);
}
