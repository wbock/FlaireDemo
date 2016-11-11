/* Start/stop/pause timer
 * @author wbock
 * Modified from: https://processing.org/examples/clock.html
 */
class Timer extends Widget {
  float cx, cy;
  float startTime, pauseTime, currentTime;
  int seconds, minutes, group;
  float secondsRadius, minutesRadius, radius;
  boolean paused;

  Timer(float startTime, float diameter, int group) {
    
    this.startTime = startTime;
    this.radius = diameter/2;
    this.group = group;

    stroke(255);

    secondsRadius = radius * 0.82;
    minutesRadius = radius * 0.60;

    startTime = 0;
    pauseTime = 0;
    currentTime = 0;
    paused = true;
  }

  void buttonA(int group) {
    if(this.group == group) {
      togglePause();
    }
  }

  void buttonB(int group) {
    if(this.group == group) {
      resetTimer();
    }
  }

  void drawWidget(float cx, float cy) {
    if (!paused) {
      currentTime = millis();
    }
    // calc times
    seconds = (int) (currentTime - startTime) / 1000;
    minutes = seconds / 60;

    this.cx = cx;
    this.cy = cy;
    // Draw the clock background
    fill(0);
    stroke(255);
    ellipse(cx, cy, radius*2, radius*2);

    // Angles for sin() and cos() start at 3 o'clock;
    // subtract HALF_PI to make them start at the top
    float s = map(seconds, 0, 60, 0, TWO_PI) - HALF_PI;
    float m = map(minutes + norm(seconds, 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 

    // Draw the hands of the timer
    stroke(255);
    strokeWeight(1);
    line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
    strokeWeight(2);
    line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);

    // Draw the minute ticks
    strokeWeight(2);
    beginShape(POINTS);
    for (int a = 0; a < 360; a+=6) {
      float angle = radians(a);
      float x = cx + cos(angle) * secondsRadius;
      float y = cy + sin(angle) * secondsRadius;
      vertex(x, y);
    }
    endShape();

    //Draw timer text
    fill(255);
    textSize(60);
    text(nf(minutes, 2) + " : " + nf(seconds, 2), cx, cy + radius/2);
  }

  private void togglePause() {
    if (startTime == 0) {
      paused = false;
      startTime = millis();
    } else if (paused) {
      startTime += millis() - pauseTime;
      paused = false;
    } else {
      paused = true;
      pauseTime = millis();
    }
  }

  private void resetTimer() {
    startTime = 0;
    currentTime = 0;
    pauseTime = 0;
    paused = true;
  }
}  