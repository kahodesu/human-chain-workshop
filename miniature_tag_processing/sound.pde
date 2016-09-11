import ddf.minim.*; //loading minim library

Minim minim; 

AudioSample beep, gameover, ding, one, two; 
AudioPlayer prep;

void setupSound() {
  minim = new Minim(this);
  gameover = minim.loadSample( "gameover.wav" ); 
  beep = minim.loadSample( "buzzer.mp3" );
  ding= minim.loadSample( "ding2.aif" );
  one= minim.loadSample( "player1.wav" );
  two= minim.loadSample( "player2.wav" );
  prep = minim.loadFile("prep.wav");
}