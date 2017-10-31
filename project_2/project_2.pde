/*************************
 * CISC 1600 - Project 2
 * Syed Raza, Weijie Lin
 * Group #8
 *************************/

// global variables
int scene = 0;
int floorPos = 450;
float carPosX = 200;
boolean changeScene = false;
Coin coin;
int score = 0;

// for animation
float beginButtonScale = 0;
float loadingScale = 0;
float cloudsPos[] = {0, 0, 0};

void setup()
{
   size (800, 600);
   coin = new Coin(400, 420);  
}

void draw()
{
  switch (scene) 
  {
      case 0:
        instructions();
        break;
      case 1:
        loading();
        break;
      default:
        mainScene();
        break;
  }
}

// keyboard event handler
void keyPressed()
{
  if(keyCode == 37) // left arrow key
  {
    carPosX -= 5;
  }

  if(keyCode == 39) // right arrow key
  {
    carPosX += 5;
  }

  if(keyCode == 81) // q key
  {
    exit();
  }
  
    // loop car position in scene
    if (carPosX - 80 > width) {
      carPosX = -80;
    }

    if (carPosX + 80 < 0) {
      carPosX = width + 80;
    }
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
   textSize(60);
   text("Instructions", width/2, 100);

   textAlign(CENTER);
   fill(#f79000);
   textSize(32);
   text("Use left/right keys to move the car", width/2, 250);
   text("Collect coins to increase your score", width/2, 300);
   text("Q key to quit", width/2, 350);

   // create button
   color colorN = color(221, 16, 16); // normal color
   color colorH = color(255, 187, 98); // highlighted color
   if (mouseHover())
      fill(colorH);
   else
      fill(colorN);

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
   if (mousePressed == true)
   {
       if( mouseX <= (width/2) + 200 &&
           mouseX >= (width/2) - 200 &&
           mouseY <= height + 130 &&
           mouseY >= height - 130)
     {
         scene = 1;
     }
  }
}

boolean mouseHover()
{
  if (mouseX >= (width/2) - 200 && mouseX <= (width/2) + 200 &&
      mouseY >= height - 130 && mouseY <= height + 130)
      {
        return true;
  } else
  {
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////////////
// display a sudo loading screen
void loading()
{
   if (changeScene == true) {
       fill(#69FF90);
       rect(width/2 - 300, height/2 + 40,  width/2 + 200, 20);
       scene = 2;
       print("changing scene!\n");
       return;
   }
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
  float r = random(10);
  loadingScale += r;

  // change scene
  if (loadingScale > 600)
  {
      fill(#0000ff);
      rect(width/2 - 300, height/2 + 40,  width/2 + 200, 20);
      changeScene = true;
  }
}

////////////////////////////////////////////////////////////////////////////////////////
// combine elements into one scene
void mainScene()
{
    background();
    floor();
    sun();
    cloudsAnimated();
    building(50);
    tree(200);
    tree(600);
    car(carPosX);
    coin.update(); 

    // display 4 lamps
    for (int i = width/8; i < width; i += width/4)
        lamp(i);
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

    // far away buildings
    fill(#996F7C, 64);
    rect(480, floorPos, 100, -80);
    fill(#B3E36C, 32);
    rect(320, floorPos, 70, -160);
    fill(#BCBA9A, 32);
    rect(720, floorPos, 90, -180);
}

// display bricks floor
void floor()
{
    int brickSizeX = 20;
    int brickSizeY = 12;
    fill(#552211);
    rect(0, floorPos, width, height);
    fill(#B98145); // brick color
    int counter = 0; // for offsetting bricks

    for (int j = 2; j < 200; j+= brickSizeY+2)
    {
      for (int i = 2; i < width + 40; i+= brickSizeX+2)
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
  stroke(0);
  strokeWeight(1);
  fill(#6A6F7C);
  rect(x, floorPos, 200, -300);

  // windows
  fill(#aaaaab);
  for (int i = x+16; i < 240; i += 30)
      rect(i, 180, 20, 40);

  for (int i = x+16; i < 240; i += 30)
      rect(i, 240, 20, 40);

  // door
  stroke(#222222);
  rect(x + 100, floorPos-2, 40, -70);
  fill(#555555);
  ellipse(x + 108, floorPos-30, 6, 6);
}

// display street lamp
void lamp(int x)
{
  noStroke();
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
  noStroke();
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

// display clouds
void cloud1(float x, float y)
{
  fill(#E0E2E3, 220);
  ellipse(x+30, y, 60, 50);
  fill(#E0E2E3, 220);
  ellipse(x, y, 60, 50);

  fill(#ffffff);
  ellipse(x, y, 40, 30);
  fill(#ffffff);
  ellipse(x+30, y, 40, 30);
}

void cloud2(float x, float y)
{
  fill(#E0E2E3, 128);
  ellipse(x+30, y, 50, 50);
  fill(#E0E2E3, 128);
  ellipse(x, y, 50, 50);
  fill(#E0E2E3, 128);
  ellipse(x+15, y, 50, 50);

  fill(#ffffff, 128);
  ellipse(x, y, 60, 40);
  fill(#ffffff, 128);
  ellipse(x+30, y, 60, 40);
}

void cloud3(float x, float y)
{
  fill(#E0E2E3, 64);
  ellipse(x+40, y, 80, 40);
  fill(#E0E2E3, 64);
  ellipse(x, y, 80, 40);

  fill(#ffffff, 64);
  ellipse(x, y, 50, 30);
  fill(#ffffff, 64);
  ellipse(x+40, y, 50, 30);
}

void cloudsAnimated()
{
     // top row
     for (int i = -width+100; i < width; i += 120)
        cloud1(i + cloudsPos[0], 50);

     if (cloudsPos[0] > width - 200)
         cloudsPos[0] = 0;
     else
        cloudsPos[0]++;

     // middle row
     for (int i = -width+100*2; i < width; i += 120*2)
        cloud2(i + cloudsPos[1], 120);

     if (cloudsPos[1] > width - 80)
         cloudsPos[1] = 0;
     else
        cloudsPos[1] += 0.5;

     // bottom row
     for (int i = -width+100*4; i < width; i += 120*3)
        cloud3(i + cloudsPos[2], 200);

     if (cloudsPos[2] > width - 200)
         cloudsPos[2] = 0;
     else
        cloudsPos[2] += 0.25;

}

void sun()
{
  noStroke();
  fill(#FFFEED);
  ellipse(width - 50, 46, 80, 80);
}

void car(float x)
{
  stroke(#000000);
  strokeWeight(1);
  fill(#F28218);   // car color

  // car body
  rect(x-80, 400, 160, 40);
  fill(#FFA148);
  rect(x-80, 400, 160, 10);
  quad ((-40 + x), 400,
        ( 40  + x), 400,
        ( 30  + x), 370,
        (-30  + x), 370
    );

  // windows
  fill(#555555);
  quad ((-36 + x), 400,
        ( 36  + x), 400,
        ( 28  + x), 372,
        (-28  + x), 372
    );
  fill(#F28218);
  rect(x-2, 372, 5, 30);

  // tires
  fill(#555555);
  ellipse(-50 + x, 435, 30, 30);
  fill(#aaaaaa);
  ellipse(-50 + x, 435, 15, 15);
  fill(#555555);
  ellipse(+50 + x, 435, 30, 30);
  fill(#aaaaaa);
  ellipse(+50 + x, 435, 15, 15);
  
  // car score text
  fill(#000000);  
  textSize(24);
  if (score < 10)
      text("0" + score, x, 435);
  else
      text(score, x, 435);
}

class Coin
{   
   int xPos;
   int yPos;
   
   Coin(int x, int y)
   {
       xPos = x;
       yPos = y;
   }
   
   int getX() { return xPos; }
   void setX(int x) { xPos = x; }
   
   // check collision between the car and coin
   boolean hasCollided(int x) 
   {
      if (x-110 >= getX() || x+110 <= getX()) 
        return !true;
      else
        return !false;
   }
   
   void update()
   {
       fill(#FFD608);
       strokeWeight(3);
       stroke(#112233);
       ellipse(xPos, yPos, 50+sin(beginButtonScale), 50+sin(beginButtonScale));
       fill(#000000);
       textSize(40);
       text("+", xPos, yPos+10);
       
       // animate
       if (beginButtonScale > 5)
           beginButtonScale = 0;
       else
         beginButtonScale += 0.8;
       
       // channge coin's position and increase score
       if (hasCollided(int(carPosX)))
       {
           int rand; 
           do {
             rand = int(random(width));
           } while(rand > carPosX+100 && rand < carPosX+100); 
           setX(rand);
           score++;
       }
   }
}