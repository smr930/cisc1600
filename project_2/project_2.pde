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
int floorPos = 450;

// for instructions/loading animation
float beginButtonScale = 0;
float loadingScale = 0;


// for mainScene animation
float rot = 0;

void setup()
{
   size (800, 600);

  
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
  
  //instructions();
  mainScene();
  
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
    floor();
    building(50); 
    
    // display 4 lamps
    for (int i = width/8; i < width; i += width/4)
        lamp(i);
    
    tree(200);
    tree(600);
    cloud(40, 40);
    
}

// display background
void background()
{   
    color c1 = color(100, 180, 250);
    color c2 = color(175, 212, 253);
    
    // create blue gradient
    for(int y = 0; y < height; y++)
    {
      float n = map(y, 0, height, 0, 1);
      color newc = lerpColor(c1, c2, n);
      stroke(newc);
      line(0, y, width, y);
  }
}

// display bricks floor
void floor()
{
    fill(#552211);
    rect(0, floorPos, width, height);
    
    int brickSizeX = 20;
    int brickSizeY = 12;
    fill(#C68F53); // brick color
    int counter = 0; // for offsetting bricks
    
    for (int j = 2; j < 200; j+= brickSizeY+2)
    {
      for (int i = 2; i < width; i+= brickSizeX+2)
      {
        if ( counter % 2 == 0) // even line
          rect(i-50, floorPos+j, brickSizeX + i, brickSizeY);
        else // odd line
          rect(i+20, floorPos+j, brickSizeX + i, brickSizeY);
        counter++;
      }
    }
}

// display building
void building(int x) 
{
  noStroke();
  fill(#6A6F7C);
  rect(x, floorPos, 200, -200);
  
  // windows
  fill(#aaaaab);
  for (int i = x+16; i < 240; i += 30)
      rect(i, 260, 20, 40);
  
  for (int i = x+16; i < 240; i += 30)
      rect(i, 320, 20, 40);
  
  // door
  stroke(#222222);
  rect(x + 100, floorPos-2, 32, -50);
  fill(#555555);
  ellipse(x + 108, floorPos-18, 6, 6);
}

// display street lamp
void lamp(int x)
{  
  fill(#222233);
  rect(x, 350, 8, 100);
  fill(#555544);
  rect(x+3, 350, 4, 100);
  fill(#666655);
  stroke(#222222);
  strokeWeight(1);
  ellipse(x+4, 340, 15, 35);
  noStroke();
  fill(#ccccaa);
  ellipse(x+4, 340, 8, 26);

}

// display tree
void tree(int x)
{ 
  // trunk
  fill(#644C35);
  rect(x, 350, 16, 100);
  fill(#836242);
  rect(x+3, 350, 8, 100);
  fill(#666655);
  
  // leaves
  stroke(#222222);
  strokeWeight(1);
  fill(#13AA00);
  ellipse(x-20, 340, 60, 50);
  noStroke();
  fill(#42E32E);
  ellipse(x-20, 340, 40, 30);
  
  stroke(#222222);
  strokeWeight(1);
  fill(#13AA00);
  ellipse(x-30, 310, 50, 60);
  noStroke();
  fill(#42E32E);
  ellipse(x-30, 310, 30, 40);
  
  stroke(#222222);
  strokeWeight(1);
  fill(#13AA00);
  ellipse(x+40, 340, 60, 50);
  noStroke();
  fill(#42E32E);
  ellipse(x+40, 340, 40, 30);
  
  stroke(#222222);
  strokeWeight(1);
  fill(#13AA00);
  ellipse(x+50, 310, 50, 60);
  noStroke();
  fill(#42E32E);
  ellipse(x+42, 310, 30, 40);
  
  stroke(#222222);
  strokeWeight(1);
  fill(#13AA00);
  ellipse(x+8, 300, 90, 100);
  noStroke();
  fill(#42E32E);
  ellipse(x+8, 300, 60, 70);

}

// display cloud
void cloud(int x, int y)
{ 
  fill(#E0E2E3);
  ellipse(x+30, y, 60, 50);
  fill(#E0E2E3);
  ellipse(x, y, 60, 50);
  
  fill(#ffffff);
  ellipse(x, y, 40, 30); 
  fill(#ffffff);
  ellipse(x+30, y, 40, 30);

}