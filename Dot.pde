class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;//true if this dot is the best dot from the previous generation

  float fitness = 0;

  Dot() {
    brain = new Brain(250);//new brain with 1000 instructions

    //start the dots at the bottom of the window with a no velocity or acceleration
    pos = new PVector(width/2, height - 40);
    vel = new PVector(0, 0);
    acc = new PVector(0, 1);
  }


  //-----------------------------------------------------------------------------------------------------------------
  //draws the dot on the screen
  void show() {
    //if this dot is the best dot from the previous generation then draw it as a big green dot
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {//all other dots are just smaller black dots
      if (vel.y > 0 ) {
        stroke(200, 200, 0);
        fill(200, 200, 0);
      } else {
        stroke(200, 0, 200);
        fill(200, 0, 200);
      }
      ellipse(pos.x, pos.y, 6, 6);
    }
  }

  //-----------------------------------------------------------------------------------------------------------------------
  //moves the dot according to the brains directions
  void move() {

    //apply the acceleration and move the dot
    if (brain.fly[brain.step] == 1) {
      vel.y -= 10;
    } else {
      vel.add(acc);
    }
    if (vel.y > 10) {
      vel.y = 10;
    }
    vel.x = brain.xMove[brain.step];
    //vel.limit(8);//not too fast
    pos.add(vel);
    
    if (brain.xMove.length - 1 > brain.step) {//if there are still directions left then set the acceleration as the next PVector in the direcitons array
      brain.step++;
    } else {//if at the end of the directions array then the dot is dead
      dead = true;
    }
  }

  //-------------------------------------------------------------------------------------------------------------------
  //calls the move function and check for collisions and stuff
  void update() {
    if (!dead && !reachedGoal) {
      move();
      //if (pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2) {//if near the edges of the window then kill it 
      //  dead = true;
      if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {//if reached goal

        reachedGoal = true;
      } else if (pos.y > height - 30) {//if the dot is in water
        dead = true;
      } else {
        if (pos.x < 3) {
          pos.x = 3;
        }
        if (pos.y < 3) {
          pos.y = 3;
          vel.y = 0;
        }
        if (pos.x > width - 4) {
          pos.x = width - 4;
        }
      }
      
    }
  }


  //--------------------------------------------------------------------------------------------------------------------------------------
  //calculates the fitness
  void calculateFitness() {
    if (reachedGoal) {//if the dot reached the goal then the fitness is based on the amount of steps it took to get there
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {//if the dot didn't reach the goal then the fitness is based on how close it is to the goal
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------------------
  //clone it 
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();//babies have the same brain as their parents
    return baby;
  }
}
