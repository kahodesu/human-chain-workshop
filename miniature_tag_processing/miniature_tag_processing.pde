import processing.serial.*;//serial communications library

//////////////////////////////////////////////////////////////////////////
///////////// MINIATURE TAG FOR HUMAN CHAIN WORKSHOP /////////////////////
//////////////////////////////////////////////////////////////////////////
//                  By Kaho Abe SEPT 10TH, 2016                         //
//  for Incubate Arcade at Incubate Festival 2016, Tilburg, NL          //
//                **See accompanying Arduino code                       //
//////////////////////////////////////////////////////////////////////////

////////////////////////////////VARIABLES/////////////////////////////////

//vars for serial com
Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

//vars for text & scoring
int p1score = 0;
int p2score = 0;
String playertext = "";

//game mode, 0= start, 1 = player1 round, 2 = player 2 round, 3 = end
int mode = 0;


///////////////////////////////////SET UP/////////////////////////////////

void setup() //happens once at the beginning of the program
{
  size(800, 600); //size of stage
  setUpTimer(); //timer set up, see timer tab
  setupSound(); //sound set up, see sound tab

  ////////////////TEXT STUFF/////////////////
  textAlign(CENTER, CENTER);  //centers text
  fill(255); //text color - white

  ////////////////SERIAL COM STUFF/////////////////
  // println(Serial.list()); //un-comment this is you need to find your serial port number
  String portName = Serial.list()[1]; //setting portName to serial port number
  myPort = new Serial(this, portName, 9600); //setting myPort to serial, at what speed

  prep.play(); // count down to game starts to play
}

///////////////////////////////////DRAW///////////////////////////////////

void draw() { //happens over and over again, loop

  //println(mode); //uncomment this if you want to see current mode
  background(0); //black background

  ////////////////DATA FROM SERIAL COMMUNICATION///////////////////
  val = 0; //value read on A0 pin defaults to zero  
  if ( myPort.available() > 0) {  // If data is available, 
    val = myPort.read();         // read it and store it in val
  }

  ///////////////TEXT STUFF//////////////////////    
  textSize(50);
  text(playertext, width/2, 100);
  textSize(200);
  text(p1score, width/4, height/2);
  text(p2score, 3*width/4, height/2);

  ////////////////MODE 1: PLAYER 1's ROUND///////////
  if (mode ==0) {
    if (!prep.isPlaying()) {
      delay(3000);
      mode = 1;
      playertext = "PLAYER 1 GO!";
      one.trigger();
      roundtimer.start();
    }
  }

  ////////////////PLAYER 1 POINTS ////////////////
  else if (mode ==1) {
    if (val == 1) {   
      ding.trigger();
      p1score++;
    }

    ////////////////MODE 2: PLAYER 2's ROUND ////////////////
    if (roundtimer.isFinished()) {
      beep.trigger();
      delay(3000);
      mode = 2; 
      playertext = "PLAYER 2 GO!";
      two.trigger();
      roundtimer.start();
    }

  ////////////////PLAYER 2 POINTS ////////////////
  } else if (mode ==2) {
    if (val == 1) {  
      ding.trigger();
      p2score++;
    }

    ///////////////END OF ROUND 2 ////////////////   
    if (roundtimer.isFinished()) {
      beep.trigger();
      delay(3000);
      mode= 3 ;
      gameover.trigger();
    }

  ////////////////MODE 3: GAME OVER ////////////////
  } else if (mode ==3) {
    playertext = "FINAL SCORE";
  }
}