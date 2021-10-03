/*
Project 1
Creature has 2 'phases':
--Wandering
-Creature will normally wander around looking for food, moving in random directions and sometimes stopping
-Creature will randomly rotate
-Creature will sometimes leave behind red circles
--Food
-If Creature sees food it will stop what it is doing and make it's way 'excitedly' over to the food and 'eats' it.

Creature has a 1/20 chance of stopping at any moment
Creature has a 1/100 chance of rotating at any moment
Creature has a 1/100 chance of leaving behind a red circle at any moment
Food has a 1/200 chance of spawning at any moment
*/

int charX, charY = 0;
int rotation = 1;
int action = 0;
int xMove = 5;
int yMove = 5;
int circleDraw = -100;
int circX, circY;
int circSize = 0;
boolean still = false;
int stillDelay = (int)random(100);
int spawnFood = 0;
boolean doSpawnFood = false;
int foodX, foodY;
void setup() {
  size(1200, 800);
}

void draw() {
  background(255, 255, 255);
  action = (int)random(100);
  fill(255, 0, 0);
  rect(charX, charY, 50, 50);
  if (rotation == 1) {
    fill(255, 255, 0);
    rect(charX, charY, 25, 25);
    fill(0, 255, 0);
    rect(charX + 25, charY + 25, 25, 25);
  } else if (rotation == 2) {
    fill(255, 255, 0);
    rect(charX + 25, charY, 25, 25);
    fill(0, 255, 0);
    rect(charX, charY + 25, 25, 25);
  } else if (rotation == 3) {
    fill(255, 255, 0);
    rect(charX + 25, charY + 25, 25, 25);
    fill(0, 255, 0);
    rect(charX, charY, 25, 25);
  } else if (rotation == 4) {
    fill(255, 255, 0);
    rect(charX, charY + 25, 25, 25);
    fill(0, 255, 0);
    rect(charX + 25, charY, 25, 25);
  }
  if (!doSpawnFood) {
    spawnFood = (int)random(200);
    if (spawnFood == 100) {
      doSpawnFood = true;
      foodX = (int)random(width);
      foodY = (int)random(height);
    }
    if (still == false) {
      if (action > 95) {
        still = true;
      }
      charX += xMove;
      charY += yMove;
      if (charX <= 0) {
        xMove = (int)random(1, 10);  
        yMove = (int)random(-10, 10);
        while (yMove == 0) {
          yMove = (int)random(-10, 10);
        }
      } else if (charX + 50 >= width) {
        xMove = (int)random(-1, -10);
        yMove = (int)random(-10, 10);
        while (yMove == 0) {
           yMove = (int)random(-10, 10);
        }
      }
      if (charY <= 0) {
        yMove = (int)random(1, 10);
        xMove = (int)random(-10, 10);
        while(xMove == 0) {
          xMove = (int)random(-10, 10);
        }
      } else if (charY + 50 >= height) {
        yMove = (int)random(-1, -10);
        xMove = (int)random(-10, 10);
        while(xMove == 0) {
          xMove = (int)random(-10, 10);
        }
      }
    } else if (still == true) {
      stillDelay--;
      if (stillDelay == 0) {
        still = false;
        stillDelay = (int)random(100);
      }
      xMove = (int)random(-10, 10);
      yMove = (int)random(-10, 10);
    }
    if (action == 50) {
        if (rotation < 4) {
          rotation++;
        } else {
          rotation = 1;
        }
      } else if (action == 25) {
        if(circleDraw < -99) {
          circleDraw = 100;
          circX = charX + 25;
          circY = charY + 25;
          circSize = 1;
        }
      }
      if (circleDraw > 0) {
        circleDraw--;
        fill(255, 0, 0);
        ellipse(circX, circY, circSize, circSize);
        circSize++;
      }
      if (circleDraw < 1 && circleDraw > -100) {
        circleDraw--;  
      }
   } else if (doSpawnFood) {
     fill(255, 255, 0);
     ellipse(foodX, foodY, 10, 10);
     if (foodX - (charX + 25) > 0) {
       charX += 10;  
     } else if (foodX - (charX + 25) < 0) {
       charX -= 10;
     }
     if (foodY - (charY + 25) > 0) {
       charY += 10;
     } else if (foodY - (charY + 25) < 0) {
       charY -= 10;
     }
     circX = charX;
     circY = charY;
     if (foodX > charX && foodX < charX + 50 && foodY > charY && foodY < charY + 50) {
         doSpawnFood = false;
     }
   }
}
