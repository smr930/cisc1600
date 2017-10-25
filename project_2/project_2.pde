/*
  CISC 1600 - Project 2
  Syed Raza, Greg Lin
  Group #8
*/

//------------------
// global variables
//------------------
// normal vars
int scene = 0;
PImage gear;

// for instructions/loading animation
float beginButtonScale = 0;
float loadingScale = 0;


// for mainScene animation
float ray_counter = 0;
float rot = 0;

void setup()
{
   size (800, 600);
   gear = loadImage("gear.png");
  
}

void draw()
{ 
  /*
  if(scene == 0)
  {    
      instructions();    
  } 
  else if (scene == 1)
  {
       loading(); 
  }
  else
  {             
      mainScene();
  } 
  */
  
  instructions();
  //mainScene();
  
}

////////////////////////////////////////////////////////////////////////////////////////
// display instructions
void instructions()
{
   background (#081636);
   fill(#ffffff);
   
   // outer rectangle  
   stroke(100);
   strokeWeight(4);
   noFill();
   rectMode(CENTER);
   rect(width/2, height/2,  width - 40, height - 40);
   
   // text
   textSize(50);
   text("Instructions", width/2, 80);
   
   textAlign(CENTER);
   fill(#f79000);
   textSize(22);
   text("1. Use mouse move ship left/right", width/2, 200); 
   text("2. Use UP and Down arrows to move ship forward/back.", width/2, 250); 
   text("3. Type Q to quit", width/2, 300);   
      
   // create button
  fill(#dd1010); // button rect color
  noStroke();
  ellipse(width / 2 - 200, height - 100, 60 + cos(beginButtonScale), 60 + cos(beginButtonScale));
  ellipse(width / 2 + 200, height - 100, 60 + cos(beginButtonScale), 60 + cos(beginButtonScale));
  rect((width/2), height - 100, 400, 60 + cos(beginButtonScale));
  
  textAlign(CENTER);
  fill(#ffffff); // button text color
  textSize(30);
  text("BEGIN", width/2, height - 90);
  
  // animate
  if (beginButtonScale > 5)
       beginButtonScale = 0;
   else
     beginButtonScale += 0.1;
    
  // check if the button is clicked
  if (mousePressed == true) {
     if( mouseX <= (width/2) + 200 && 
         mouseX >= (width/2) - 200 && 
         mouseY <= height + 130 && 
         mouseY >= height - 130) 
     {
         print("Begin button is clicked!\n");
         scene = 1;
     }
  }
}
////////////////////////////////////////////////////////////////////////////////////////
// display a fake loading screen
void loading()
{
   background (#081636);
   fill(#ffffff);
   rectMode(CORNER);
   
   // text
   textSize(50);
   text("Loading", width/2, height/2);
   
   // outer rectangle  
   fill(#aaaaaa);
   rect(width/2 - 300, height/2 + 40,  width/2 + 200, 20);
   
   // inner rectangle  
   fill(#0000ff);
   rect(width/2 - 300, height/2 + 40,  loadingScale, 20);
      
  // animate
  float r = random(5);
  loadingScale += r;
  
  // change scene
  if (loadingScale > 600)
  {
         print("changing scene!\n");
         scene = 2;
    
  }
}

////////////////////////////////////////////////////////////////////////////////////////
// combine elements into once scene
void mainScene()
{
    background();
    gears();
    
}

// display background
void background()
{
    background (#000000);
}

// display gears
void gears()
{
    
    translate(width/2, height/2);
    rotate(rot);
    rot += 0.04;
    imageMode(CENTER);
    image(gear, 0, 0);
    
 




}