class Brain {
  int[] xMove; //series of vectors which get the dot to the goal (hopefully)
  int[] fly;
  int step = 0;
  int flyNext = 10;
  int horizontal = 10;


  Brain(int size) {
    xMove = new int[size];
    fly = new int[size];
    randomize();
  }

  //--------------------------------------------------------------------------------------------------------------------------------
  //sets all the vectors in xMove to a random vector with length 1
  void randomize() {
    int prev = -flyNext;
    int temp;
    for (int i = 0; i< xMove.length; i++) {
      xMove[i] = (int(random(3)) - 1)*int(random(horizontal));
      if (i - prev >= flyNext) {
        temp = int(random(2));
        fly[i] = temp;
        if (temp == 1) {
          prev = i;
        }
      } else {
        fly[i] = 0;
      }
    }
  }

  //-------------------------------------------------------------------------------------------------------------------------------------
  //returns a perfect copy of this brain object
  Brain clone() {
    Brain clone = new Brain(xMove.length);
    for (int i = 0; i < xMove.length; i++) {
      clone.xMove[i] = xMove[i];
      clone.fly[i] = fly[i];
    }

    return clone;
  }

  //----------------------------------------------------------------------------------------------------------------------------------------

  //mutates the brain by setting some of the xMove to random vectors
  void mutate() {
    float mutationRate = 0.01;//chance that any vector in xMove gets changed
    int prev = -flyNext;
    int temp;
    for (int i =0; i< xMove.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        //set this direction as a random direction
        xMove[i] = (int(random(3)) - 1)*horizontal;
        if (i - prev >= flyNext) {
          temp = int(random(2));
          fly[i] = temp;
          if (temp == 1) {
            prev = i;
          }
        } else {
          fly[i] = 0;
        }
        
      } else if (fly[i] == 1) {
        if (i - prev < flyNext) {
          fly[i] = 0;
        } else {
          prev = i;
        }
      }
    }
  }
}
