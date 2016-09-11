int round = 10000; //length of round

Timer roundtimer; 

void setUpTimer() {
  roundtimer = new Timer(round); 
}

//////////////////////////////////////////////////////////
// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com
// Example 10-5: Object-oriented timer

class Timer {

  int savedTime; 
  int totalTime; 

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }

  void start() {
    savedTime = millis();
  }

  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true; 
    } else {
      return false;
    }
  }
}