// economz - your carbon foodprint
// by Sam Slover in the fall of 2012
// for NYU's Interactive Telecommunications Program
// icons designed using open source images from The Noun Project and ITP colleague Maria Paul Saba
// code ideas and suggestions contributed by Processing wizard Dan Shiffman (all mistakes are my own)

/* @pjs preload="clear-plate-deactive.png,go-button-deactive.png, clear-plate-active.png, go-button-active.png, message.png,  bottom-panel.jpg,
 20-a.png, 20-d.png, 20.png, 18.png, 14.png, 15.png, 13.png, 4.png, 21.png, 11.png, 7.png, plate-reset.jpg, 1-g.png, 1-b.png, 22-a.png, 22-d.png,
 18-a.png, 18-d.png, 17-a.png, 17-d.png, 15-a.png, 15-d.png,11-a.png,11-d.png,10-a.png,10-d.png, 9-a.png, 9-d.png, 8-a.png, 8-d.png, 7-a.png, 7-d.png, 
 6-a.png, 6-d.png, 4-a.png, 4-d.png, bg-reset.jpg, 3-b.png, 3-g.png, 4-g.png, 4-b.png, 2-b.png, 2-g.png, 0-g.png, 0-b.png, show.png, create-a-meal.png, 3.png,
 go-button.png, 19.png, 2.png, car.png, 0-a.png, 1-a.png, 2-a.png, 21-a.png, 13-a.png, 3-a.png, 14-a.png, 16-a.png, 5-a.png, 19-a.png, 12-a.png, 12-d.png,
 5-d.png, 19-d.png, 14-d.png, 16-d.png, 13-d.png, 3-d.png, 0-d.png, 1-d.png, 2-d.png, 21-d.png, 12.png, 9.png, 10.png, 5.png, 17.png, 16.png, 22.png, 8.png, 1.png,
 0.png, 6.png, economz-bg.jpg, go.png, splash1.png, texture.png";*/

int numItems = 23;
Food food[] = new Food[numItems];

// menu objects
Menu menu[] = new Menu[5];

// button objects
Button goButtonA;
Button goButtonD;
Button clearButtonD;
Button clearButtonA;
Button clearButtonDone;
Button goSplash;
boolean animate = false;

// car object
Car car;
int carTracker = 0; //tracks how many times a car has cycled through each animation

// fumes
ParticleSystem ps;
Random generator;
float fumeX = 65;
float fumeY = 611;
float moveFumeX = 0;
float moveFumeY = 0;

// main images
PImage bg;
PImage createMeal;
PImage show;
PImage bgReset;
PImage plateReset;
PImage bottom;
PImage splash1;
PImage message;

// fonts
PFont tradeGothic;
boolean textDisplay = false;

// to keep track of the plate items
int plateItemCounter = 0;

// to keep track of the total "carbon miles" travelled for all food on plate
float totalMilesTracker = 0;
int yearlyMilesRounded = 0;

// arrays for data
// the entire spreadsheet
String [] cells;
// split it in this array
String [] splits;
// just the carmiles
Float [] carMiles;

int foodCategory = 1;

// icon variables
int menuX = 797;
int menuY = 70;
int counterX0 = 0;
int counterY0 = 0;
int counterX1 = 0;
int counterY1 = 0;
int counterX2 = 0;
int counterY2 = 0;
int counterX3 = 0;
int counterY3 = 0;
int counterX4 = 0;
int counterY4 = 0;
int iconXset = 755;
int iconYset = 113;
int iconX = iconXset;
int iconY = iconYset;
int iconX0 = iconXset;
int iconY0 = iconYset;
int iconX1 = iconXset;
int iconY1 = iconYset;
int iconX2 = iconXset;
int iconY2 = iconYset;
int iconX3 = iconXset;
int iconY3 = iconYset;
int iconX4 = iconXset;
int iconY4 = iconYset;

void setup() {
  size (980, 653);
  // font
  tradeGothic = loadFont("TradeGothicLT-Bold-48.vlw");
  // load panel images
  bg = loadImage("economz-bg.jpg"); 
  bgReset = loadImage("bg-reset.jpg");
  createMeal = loadImage("create-a-meal.png"); 
  show = loadImage("show.png");
  plateReset = loadImage("plate-reset.jpg");
  bottom = loadImage("bottom-panel.jpg");
  splash1 = loadImage("splash1.png");
  message = loadImage("message.png");
  PImage gobuttonDImg = loadImage("go-button-deactive.png");
  PImage gobuttonAImg = loadImage("go-button-active.png");
  PImage goSplashImg = loadImage("go.png");
  goButtonD = new Button (gobuttonDImg, false, iconXset+12, 470);
  goButtonA = new Button (gobuttonAImg, false, iconXset+12, 470);
  PImage clearbuttonImgA = loadImage("clear-plate-active.png");
  PImage clearbuttonImgD = loadImage("clear-plate-deactive.png");
  clearButtonA = new Button (clearbuttonImgA, false, 524, 482);
  clearButtonD = new Button (clearbuttonImgD, false, 524, 482); 
  clearButtonDone = new Button (clearbuttonImgA, false, width-155, height-30);
  goSplash = new Button (goSplashImg, false, 365, 405);
  // load fume system
  generator = new Random();
  PImage img = loadImage("texture.png");
  println("fumeX is "+fumeX+" fumeY is " +fumeY);
  ps = new ParticleSystem(0,new PVector(fumeX,fumeY),img);
  // load and bring in the car object
  PImage carImage = loadImage("car.png");
  car = new Car (carImage, 50, height-98, 0, 0);
  // load images for the menu items
  PImage[] menuA = new PImage [5];
  PImage[] menuD = new PImage [5]; 
  for (int i = 0; i < menuA.length; i++) {
    menuA[i] = loadImage(i + "-g.png");
    menuD[i] = loadImage(i + "-b.png");
  } 
  // load images for the food items
  PImage[] mainImages = new PImage[numItems];
  for (int i = 0; i < mainImages.length; i++) {
    mainImages[i] = loadImage(i + ".png");
  }
  PImage[] iconA = new PImage[numItems];
  for (int i = 0; i < iconA.length; i++) {
    iconA[i] = loadImage(i + "-a.png");
  }
  PImage[] iconD = new PImage[numItems];
  for (int i = 0; i < iconD.length; i++) {
    iconD[i] = loadImage(i + "-d.png");
  }
  //load data
  cells = loadStrings("economz.csv");
  carMiles = new Float[cells.length];
  for (int i = 0; i < cells.length; i++) {
    splits = cells[i].split(",");
    carMiles[i] = float(splits[5]);
  }
  //bring in the menu objects!
  for (int i = 0; i < menu.length; i++) {
    menu[i] = new Menu(menuA[i], menuD[i], false, menuX, menuY);
    // set location attributes
    menuX = menuX + 43;
    if (menuX+80 >width) {
      menuX = 797;
      menuY = 88;
    }
  }
  // bring in the food objects!
  for (int i = 0; i < food.length; i++) {
    food[i] = new Food(mainImages[i], iconD[i], iconA[i], false, carMiles[i], 0, width/2, height/2, iconX, iconY, 0); 
    //set categories and location attributes
    if (i >= 0 && i < 5) {
      food[i].setCategory(1); 
      iconX0 = iconX0 + 105;
      counterX0++;
      counterY0++;
      if (counterY0 == 2) {
        iconX0 = width-225;
        iconY0 = iconY0 + 90;
        counterY0 = 0;
      }
      iconX = iconX0;
      iconY = iconY0; 
      if (i == 4) {
        iconX = iconXset;
        iconY = iconYset;
      }
    }
    if (i >= 5 && i < 13) {
      food[i].setCategory(2);
      iconX1 = iconX1 + 105;
      counterX1++;
      counterY1++;
      if (counterY1 == 2) {
        iconX1 = width-225;
        iconY1 = iconY1 + 90;
        counterY1 = 0;
      }
      iconX = iconX1;
      iconY = iconY1; 
      if (i == 12) {
        iconX = iconXset;
        iconY = iconYset;
      }
    }
    if (i >= 13 && i < 17) {
      food[i].setCategory(3);
      iconX2 = iconX2 + 105;
      counterX2++;
      counterY2++;
      if (counterY2 == 2) {
        iconX2 = width-225;
        iconY2 = iconY2 + 90;
        counterY2 = 0;
      }
      iconX = iconX2;
      iconY = iconY2; 
      if (i == 16) {
        iconX = iconXset;
        iconY = iconYset;
      }
    }
    if (i >= 17 && i < 21) {
      food[i].setCategory(4);
      iconX3 = iconX3 + 105;
      counterX3++;
      counterY3++;
      if (counterY3 == 2) {
        iconX3 = width-225;
        iconY3 = iconY3 + 90;
        counterY3 = 0;
      }
      iconX = iconX3;
      iconY = iconY3; 
      if (i == 20) {
        iconX = iconXset;
        iconY = iconYset;
      }
    }
    if (i >= 21 && i < 23) {
      food[i].setCategory(5);
      iconX4 = iconX4 + 105;
      counterX4++;
      counterY4++;
      if (counterY4 == 2) {
        iconX4 = width-225;
        iconY4 = iconY1 + 90;
        counterY4 = 0;
      }
      iconX = iconX4;
      iconY = iconY4;
    }
  }
}
void draw() {
  imageMode(CORNER);
  // load and show initial panel images
  background(bg);
  // if no food items, show initial splash screen
  image(createMeal, 755, 20);
  image(show, 756, 70);
  //image(plateReset, 0, 0);
  for (int i = 0; i < food.length; i++) {
    food[i].foodDisplay();
  }
  // highlight the menu item if it is chosen
  for (int i = 0; i < menu.length; i++) {
    menu[i].display();
  }
  // lower part of the program display goes here
  car.display();
  goButtonD.display();
  clearButtonD.display();
  if (plateItemCounter >= 1) {
    fumes(-0.2, -0.02, 1);
    car.display();
    image(message, 600, height-110);
    goButtonA.display();
    clearButtonA.display();
  }
  yearlyMilesRounded = round(365*totalMilesTracker);
  if (animate == true) {
    image(bottom, 0, height-110);
    goButtonD.display();
    fumes(-0.2, -0.02, 1);
    car.display();
  }
  if (textDisplay == true) {
    fill(29, 91, 46);
    textFont(tradeGothic, 28);
    text("If you ate this meal once a day for a year", width-585, height-65);
    fill(64, 64, 65);
    text("it's the carbon equivalent of driving", width-585, height-35);
    fill(211, 33, 50);
    text(yearlyMilesRounded + " miles", width-143, height-35);
  }
  // show the associated food icons for each food category when that menu item is selected
  if (foodCategory == 1) {
    menu[0].setSelected();
    menu[0].display();
    //image(bgReset, iconXset, iconYset);
    for (int i = 0; i < 5; i++) {
      food[i].iconDisplay();
    }
  }
  if (foodCategory == 2) {
    //image(bgReset, iconXset, iconYset);    
    for (int i = 5; i < 13; i++) {
      food[i].iconDisplay();
    }
  }
  if (foodCategory == 3) {
    //image(bgReset, iconXset, iconYset);
    for (int i = 13; i < 17; i++) {
      food[i].iconDisplay();
    }
  }
  if (foodCategory == 4) {
    //image(bgReset, iconXset, iconYset);
    for (int i = 17; i < 21; i++) {
      food[i].iconDisplay();
    }
  }
  if (foodCategory == 5) {
    //image(bgReset, iconXset, iconYset);
    for (int i = 21; i < 23; i++) {
      food[i].iconDisplay();
    }
  }
  // draw splash screens on top at beginning and end
  if (plateItemCounter == 0 && goSplash.isClicked == false) {
    noStroke();
    fill(88, 88, 91, 160);
    rect(0, 0, width, height);
    imageMode(CENTER);
    image(splash1, width/2, height/2-40);
    imageMode(CORNER);
    goSplash.display();
  }
  imageMode(CORNER);
}

void mousePressed() {
  // on mouse click, figure out which menu is selected, with only 1 being selected at one time
  if (menu[0].isMenuSelected() == true) {
    foodCategory = 1;
    menu[0].setSelected();
    menu[1].setDeselected();
    menu[2].setDeselected();
    menu[3].setDeselected();
    menu[4].setDeselected();
  }
  else if (menu[1].isMenuSelected() == true) {
    foodCategory = 2;
    menu[0].setDeselected();
    menu[1].setSelected();
    menu[2].setDeselected();
    menu[3].setDeselected();
    menu[4].setDeselected();
  }
  else if (menu[2].isMenuSelected() == true) {
    foodCategory = 3;
    menu[0].setDeselected();
    menu[1].setDeselected();
    menu[2].setSelected();
    menu[3].setDeselected();
    menu[4].setDeselected();
  }
  else if (menu[3].isMenuSelected() == true) {
    foodCategory = 4;    
    menu[0].setDeselected();
    menu[1].setDeselected();
    menu[2].setDeselected();
    menu[3].setSelected();
    menu[4].setDeselected();
  }
  else if (menu[4].isMenuSelected() == true) {
    foodCategory = 5;
    menu[0].setDeselected();
    menu[1].setDeselected();
    menu[2].setDeselected();
    menu[3].setDeselected();
    menu[4].setSelected();
  }
  // on mouse click, determine if a food item has been selected
  if (foodCategory == 1) {
    for (int i = 0; i < 5; i++) {
      food[i].isFoodSelected();
    }
  }
  if (foodCategory == 2) {
    for (int i = 5; i < 13; i++) {
      food[i].isFoodSelected();
    }
  }
  if (foodCategory == 3) {
    for (int i = 13; i < 17; i++) {
      food[i].isFoodSelected();
    }
  }
  if (foodCategory == 4) {
    for (int i = 17; i < 21; i++) {
      food[i].isFoodSelected();
    }
  }
  if (foodCategory == 5) {
    for (int i = 21; i < 23; i++) {
      food[i].isFoodSelected();
    }
  }
  // if they click to go, well then, go!
  if (goButtonA.goClick() == true && plateItemCounter >=1) {
    animate = true;
    textDisplay = true;
  }
  // if the plate is cleared via the clear button OR via removing all items, reset everything
  if (clearButtonA.clearPlate() == true || plateItemCounter == 0 || clearButtonDone.clearPlate()) {
    plateItemCounter = 0;
    totalMilesTracker = 0;
    carTracker = 0;
    goButtonA.isClicked = false;
    textDisplay = false;
    for (int i = 0; i < food.length; i++) {
      food[i].isSelected = false;
      food[i].plateOrder = 0;
    }
    // reset bottom attributes too
    animate = false;
    car.carX =  50; 
    car.carY = height-98;
  } 
  if (goSplash.splashClick() == true) {
    goSplash.isClicked = true;
  }
}

void textDisplay() {
  fill(29, 91, 46);
  textFont(tradeGothic, 84);
  text("If you ate this everyday for a year", width-200, height-98);
}

void fumes(float windX, float windY, int partNum) { 
  PVector wind = new PVector(windX, windY);
  ps.applyForce(wind);
  ps.run();
  for (int i = 0; i < partNum; i++) {
    ps.addParticle();
  }
  fumeX = fumeX + 2; 
  fumeY = fumeY + moveFumeY;
  imageMode(CORNER);
  noTint();
  println(fumeX);
}

