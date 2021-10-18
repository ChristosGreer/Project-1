/*
Project 1
The spider has 2 'phases'
--Wandering
-Spider will normally wander around looking for food, moving in random directions and sometimes stopping
-Spider will randomly change to look in different directions
-Spider will sometimes leave behind webs that disappear after a short time
--Food
-If the spider sees food (Cherries) it will stop what it is doing and make it's way 'excitedly' 'jumping' over to the food and it will 'eat' it.

Spider has a 1/20 chance of stopping at any moment
Spider has a 1/100 chance of changing the direction it is looking at any moment
Spider has a 1/100 chance of leaving behind a web at any moment
Cherries have a 1/200 chance of spawning at any moment
*/

int spiderX, spiderY = 0;
int rotation = 1;
int action, spawnFood = 0;
int xMove, yMove = 5;
int webDraw = -100;
int webX, webY, foodX, foodY;
boolean still, doSpawnFood = false;
int stillDelay = (int)random(100);
PImage creature1, creature2, creature3, creature4, food, web, background;
void setup() {
  size(1200, 800);
  creature1 = loadImage("creature1.png");
  creature2 = loadImage("creature2.png");
  creature3 = loadImage("creature3.png");
  creature4 = loadImage("creature4.png");
  food = loadImage("food.png");
  web = loadImage("web.png");
  background = loadImage("background.png");
}

void draw() {
  image(background, 0, 0);
  action = (int)random(100);
  if (rotation == 1) {
    image(creature1, spiderX, spiderY);
  } else if (rotation == 2) {
    image(creature2, spiderX, spiderY);
  } else if (rotation == 3) {
    image(creature3, spiderX, spiderY);
  } else if (rotation == 4) {
    image(creature4, spiderX, spiderY);
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
      spiderX += xMove;
      spiderY += yMove;
      if (spiderX <= 0) {
        xMove = (int)random(1, 10);  
        yMove = (int)random(-10, 10);
        while (yMove == 0) {
          yMove = (int)random(-10, 10);
        }
      } else if (spiderX + 50 >= width) {
        xMove = (int)random(-1, -10);
        yMove = (int)random(-10, 10);
        while (yMove == 0) {
           yMove = (int)random(-10, 10);
        }
      }
      if (spiderY <= 0) {
        yMove = (int)random(1, 10);
        xMove = (int)random(-10, 10);
        while(xMove == 0) {
          xMove = (int)random(-10, 10);
        }
      } else if (spiderY + 50 >= height) {
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
        if(webDraw < -99) {
          webDraw = 100;
          webX = spiderX + 25;
          webY = spiderY + 25;
        }
      }
      if (webDraw > 0) {
        webDraw--;
        image(web, webX, webY);
      }
      if (webDraw < 1 && webDraw > -100) {
        webDraw--;  
      }
   } else if (doSpawnFood) {
     image(food, foodX - 10, foodY - 10);
     if (foodX - (spiderX + 25) > 0) {
       spiderX += 10;  
     } else if (foodX - (spiderX + 25) < 0) {
       spiderX -= 10;
     }
     if (foodY - (spiderY + 25) > 0) {
       spiderY += 10;
     } else if (foodY - (spiderY + 25) < 0) {
       spiderY -= 10;
     }
     webX = spiderX;
     webY = spiderY;
     if (foodX > spiderX && foodX < spiderX + 50 && foodY > spiderY && foodY < spiderY + 50) {
         doSpawnFood = false;
     }
   }
}
