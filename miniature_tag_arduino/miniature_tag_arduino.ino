//////////////////////////////////////////////////////////////////////////
///////////// MINIATURE TAG FOR HUMAN CHAIN WORKSHOP /////////////////////
//////////////////////////////////////////////////////////////////////////
//                  By Kaho Abe SEPT 10TH, 2016                         //
//  for Incubate Arcade at Incubate Festival 2016, Tilburg, NL          //
//                **See accompanying Processing code                    //
//////////////////////////////////////////////////////////////////////////

//////////////////////////////VARAIBLES/////////////////////////////////
const int ledPin =  13;           // the number of the LED pin
const int analog =  A0;           // the number of the analog pin
int val = 0;                      //setting up variable for value read on analog pin

//////////////////////////////////SET UP/////////////////////////////////
void setup() {
  pinMode(ledPin, OUTPUT);        //ledpin is set up as output
  pinMode(analog, INPUT);         //analogpin is set up as input
  Serial.begin(9600);             //setting up serial com
}

//////////////////////////////////LOOP/////////////////////////////////
void loop() {
  val = analogRead(analog);       //setting value to what is read on analog pin
  //Serial.println(analog);       //to see the values in serial monitor, uncomment this.
      
  if (val<1023) {                 //if the value is less than 1023
   digitalWrite(ledPin, HIGH);    //turn on LED
   Serial.write(1);               //send over serial com the number 1
  }
  
  else {                          //otherwise
  digitalWrite(ledPin, LOW);      //turn off LED
  Serial.write(0);                //send over serial com the number 0
  }
  delay(200);                     //put small delay here to reduce lag with Processing
}
