class Food {
  PImage main;
  PImage iconD;
  PImage iconA;
  boolean isSelected;
  float carbonFootprint;
  int category;
  int mainX;
  int mainY;
  int iconX;
  int iconY;
  int plateOrder;

  Food (PImage tempMain, PImage tempIconD, PImage tempIconA, boolean tempIsSelected, float tempCarbonFootprint, int tempCategory, int tempMainX, int tempMainY, int tempIconX, int tempIconY, int tempPlateOrder) {
    main = tempMain; 
    iconD = tempIconD; 
    iconA = tempIconA; 
    isSelected = tempIsSelected;
    carbonFootprint = tempCarbonFootprint; 
    category = tempCategory;
    mainX = tempMainX;
    mainY = tempMainY;
    iconX = tempIconX;
    iconY = tempIconY;
    plateOrder = tempPlateOrder;
  }
  // what category is the food item in
  int setCategory(int options) {
    if (options == 1) {
      category = 1; //veggie
    }
    else if (options == 2) {
      category = 2; //meat
    }
    else if (options == 3) {
      category = 3; //dairy
    } 
    else if (options == 4) {
      category = 4; //starch
    }
    else if (options == 5) {
      category = 5; //other
    }   
    return category;
  }
  void iconDisplay() {
    // if an icon is selected, show active version; otherwise show deactive
    if (isSelected == true) {
      image(iconA, iconX, iconY);
    }
    if (isSelected == false) {
      image(iconD, iconX, iconY);
    }
  }
  void foodDisplay() {    
    // if an item has been selected, then show it on the plate
    // if the item is deselected, then hide it 
    if (isSelected == true) {
      image(main, mainX, mainY);
    }
  }
  void plateOrderFunction() {
    // immediately give it the food a plate location
    if (plateOrder == 1) {
      mainX = 190;
      mainY = 70;
    } 
    else if (plateOrder == 2) {
      mainX = 385;
      mainY = 260;
    } 
    else if (plateOrder == 3) {
      mainX = 165;
      mainY = 215;
    } 
    else if (plateOrder == 4) {
      mainX = 400;
      mainY = 70;
    }
    else if (plateOrder == 5) {
      mainX = 187;
      mainY = 340;
    }
    else if (plateOrder == 6) {
      mainX = 380;
      mainY = 170;
    }
    else if (plateOrder == 7) {
      mainX = 345;
      mainY = 345;
    }
    else if (plateOrder == 8) {
      mainX = 275;
      mainY = 15;
    }
    else if (plateOrder == 9) {
      mainX = 197 + int(random(-15, 15));
      mainY = 70 + int(random(-15, 15));
    } 
    else if (plateOrder == 10) {
      mainX = 385 + int(random(-15, 15));
      mainY = 260 + int(random(-15, 15));
    } 
    else if (plateOrder == 11) {
      mainX = 185 + int(random(-15, 15));
      mainY = 215 + int(random(-15, 15));
    } 
    else if (plateOrder == 12) {
      mainX = 400 + int(random(-15, 15));
      mainY = 70 + int(random(-15, 15));
    }
    else if (plateOrder == 13) {
      mainX = 197 + int(random(-15, 15));
      mainY = 340 + int(random(-15, 15));
    }
    else if (plateOrder == 14) {
      mainX = 380 + int(random(-15, 15));
      mainY = 170 + int(random(-15, 15));
    }
    else if (plateOrder == 15) {
      mainX = 345 + int(random(-15, 15));
      mainY = 345 + int(random(-15, 15));
    }
    else if (plateOrder == 16) {
      mainX = 275 + int(random(-15, 15));
      mainY = 15 + int(random(-15, 15));
    }
    else if (plateOrder == 17) {
      mainX = 197 + int(random(-15, 15));
      mainY = 70 + int(random(-15, 15));
    } 
    else if (plateOrder == 18) {
      mainX = 385 + int(random(-15, 15));
      mainY = 260 + int(random(-15, 15));
    } 
    else if (plateOrder == 19) {
      mainX = 185 + int(random(-15, 15));
      mainY = 215 + int(random(-15, 15));
    } 
    else if (plateOrder == 20) {
      mainX = 400 + int(random(-15, 15));
      mainY = 70 + int(random(-15, 15));
    }
    else if (plateOrder == 21) {
      mainX = 197 + int(random(-15, 15));
      mainY = 340 + int(random(-15, 15));
    }
    else if (plateOrder == 22) {
      mainX = 380 + int(random(-15, 15));
      mainY = 170 + int(random(-15, 15));
    }
    else if (plateOrder == 23) {
      mainX = 345 + int(random(-15, 15));
      mainY = 345 + int(random(-15, 15));
    }
  }

  void isFoodSelected() {
    if (mouseX>(iconX-2) && mouseX<(iconX + 97) && mouseY>(iconY-2) && mouseY<(iconY+77)) {
      isSelected =! isSelected;
      // keep track of how many items are currently on plate with plateItemCounter
      // keep track of global "food miles" for the plate with totalMilesTracker
      if (isSelected == true) {
        plateItemCounter++;
        totalMilesTracker = totalMilesTracker + carbonFootprint;
        plateOrder = plateItemCounter;
        // re-oder plate give new order
        plateOrderFunction();
      }
      if (isSelected == false) {
        plateItemCounter--;
        totalMilesTracker = totalMilesTracker - carbonFootprint;
        // check what item is getting removed so we can reorder properly
        int removedItem = plateOrder;
        // reset this item to 0 
        plateOrder = 0;
        // algorithm to re-order the entire plate. everything slides down by 1, if it's above the value of the removedItem.
        for (int i = 0; i < food.length; i++) {
          if (food[i].isSelected == true) {
            if (food[i].plateOrder > 1 && food[i].plateOrder > removedItem) {
              food[i].plateOrder = food[i].plateOrder - 1;
              food[i].plateOrderFunction();
            }
          }
        }
        // reset the plate!
        //image(plateReset, 0, 0);
        // re-oder plate given new order
        plateOrderFunction();
      }
    }
  }
}   

