/* Switch scenes on button-press
 * @author wbock
 *
 */
// Countiers for animations
int currentScene, targetScene;
// current scene
int scene;
// Temp value for calculating scene draw locations
float sceneX, sceneY;

boolean press = false;

//All widgets
ArrayList<Widget> widgets;

//Scene 0 widgets
Wallpaper scene0Wallpaper;
DigiClock scene0Clock;
Timer scene0Timer;

//Scene 1 widgets
Gallery scene1Gallery;

//Scene 2 widgets
Gallery scene2Gallery;

//scene 3 widgets
Wallpaper scene3Wallpaper;


void setup() {
  // Replace with moto x resolution on final build
  //size(422, 750);
  size(1080, 1920);

  // Create UI-elements array
  widgets = new ArrayList<Widget>();

  //Scene logic & coordinates
  currentScene = 0;
  targetScene = 0;
  scene = 0;
  sceneX = width;
  sceneY = height;

  //Scene 0 widgets ini
  scene0Wallpaper = new Wallpaper();
  widgets.add(scene0Wallpaper);
  scene0Clock = new DigiClock(64);
  widgets.add(scene0Clock);
  scene0Timer = new Timer(0.0f, 6 * width / 8, 0);
  widgets.add(scene0Timer);

  //Scene 1 widgets ini
  PImage[][] mapImages = {
    {loadImage("map2-0.png"), loadImage("map2-1.png"), loadImage("map2-2.png")}, 
    {loadImage("map3-0.png")}
  };
  scene1Gallery = new Gallery(mapImages, 0, 1);
  widgets.add(scene1Gallery);

  //Scene 2 widgets ini
  PImage[][] songImages = {
    {loadImage("song0-0.png"), loadImage("song0-1.png")}, 
    {loadImage("song1-0.png"), loadImage("song1-1.png")}, 
    {loadImage("song2-0.png"), loadImage("song2-1.png")}, 
    {loadImage("song3-0.png"), loadImage("song3-1.png")}, 
    {loadImage("song4-0.png"), loadImage("song4-1.png")}
  };
  scene2Gallery = new Gallery(songImages, 0, 2);
  widgets.add(scene2Gallery);
  
  //Scene 3 widgets ini
  scene3Wallpaper = new Wallpaper();
  widgets.add(scene3Wallpaper);
}

void draw() {

  //Draw 
  animate();
  background(0);

  switch(scene) {
  case 0:
    // Clock/timer scene
    drawScene0();
    break;
  case 1:
    // Map scene
    drawScene1();
    break;
  case 2:
    // Music scene
    drawScene2();
    break;
  case 3:
    // status overview scene
    drawScene3();
    break;
  default:
    break;
  }

  if (mousePressed && !press) {
    press = true;
  } else if (!mousePressed && press) {
    press = false;
    endPress();
  }
}

/* 
 * Draw scenes
 */
void drawScene0() {
  sceneX = -width * currentScene / 40.0f + 0.0f * width;
  //Draw background gfx
  scene0Wallpaper.drawWidget(sceneX, 0);
  // Draw digital clock
  scene0Clock.drawWidget(sceneX + width/2, height/8);
  // Draw timer
  scene0Timer.drawWidget(sceneX + width/2, height/2);
}

void drawScene1() {
  sceneX = -width * currentScene / 40.0f + 1.0f * width;
  //Draw background gfx
  scene1Gallery.drawWidget(sceneX, 0);
}

void drawScene2() {
  sceneX = -width * currentScene / 40.0f + 2.0f * width;
  //Draw background gfx
  scene2Gallery.drawWidget(sceneX, 0);
}

void drawScene3() {
  sceneX = -width * currentScene / 40.0f + 3.0f * width;
  //Draw background gfx
  scene3Wallpaper.drawWidget(sceneX, 0);
  
  //misc filler text
  fill(255);
  textAlign(LEFT);
  textSize(60);
  text("Distance:  "+ 6*millis()/1000 + " m", sceneX + width/4, height/4);
  text("Speed   :  24 km/h", sceneX + width/4, 2*height/4);
  text("Cadence :  85 RPM", sceneX + width/4, 3*height/4);
}

/* 
 * Input
 */
void endPress() {
  if (mouseX > width/2 && mouseY > height/4  && mouseY < 3*height/4) {
    pressRight();
  } else if (mouseY < height/4) {
    pressDown();
  } else if (mouseY > 3*height/4) {
    pressUp();
  } else {
    pressLeft();
  }
}

void keyPressed() {
  //
}

void keyReleased() {
  switch(key) {
  case '6': // Right
    pressRight();
    break;
  case 'd': // Right
    pressRight();
    break;
  case '4': // Left
    pressLeft();
    break;
  case 'a': // Left
    pressLeft();
    break;
  case '8': // Up
    pressUp();
    break;
  case 'w': // Up
    pressUp();
    break;
  case '5': // Down
    pressDown();
    break;
  case 's': // Down
    pressDown();
    break;
  default:
    break;
  }
}

/*
 * Switch scene & animation functions
 */
void pressRight() {
  if (scene < 3) {
    scene++;
    targetScene += 40;
  }
}

void pressLeft() {
  if (scene > 0) {
    scene--;
    targetScene -= 40;
  }
}

void pressUp() {
  for (Widget widget : widgets) {
    widget.buttonA(scene);
  }
}

void pressDown() {
  for (Widget widget : widgets) {
    widget.buttonB(scene);
  }
}

void animate() {
  if (currentScene < targetScene) {
    //currentScene += 1;
    currentScene += 2;
    delay(5);
  } else if (currentScene > targetScene) {
    //currentScene -= 1;
    currentScene -= 2;
    delay(5);
  }
}