Population test;
PVector goal  = new PVector(400, 10);
int rect1Left, rect1Top, rect1Width, rect1Right, rect1Height, rect1Bottom;
void setup() {
  size(800, 800); //size of the window
  frameRate(25);//increase this to make the dots go faster
  test = new Population(1000);//create a new population with 1000 members
  
  
  rect1Left = width/4;
  rect1Top = height/2+40;
  rect1Width = width/2;
  rect1Right = rect1Left + rect1Width;
  rect1Height = 15;
  rect1Bottom = rect1Top + rect1Height;
}


void draw() {
  background(255);

  //draw goal
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  //draw obstacle(s)
  fill(0, 200, 255);
  stroke(0, 200, 255);
  rect(0, height-30, width-1, height-1);
  fill(128);
  stroke(128);
  rect(rect1Left, rect1Top, rect1Width, rect1Height);
  fill(0);
  stroke(0);
  

  if (test.allDotsDead()) {
    //genetic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
  } else {
    //if any of the dots are still alive then update and then show them

    test.update();
    test.show();
  }
}
