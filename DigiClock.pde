/* Digital clock
 * @author wbock
 * 
 */
class DigiClock extends Widget {

  int fontSize;

  DigiClock(int fontSize) {
    this.fontSize = fontSize;
  }

  void buttonA(int group) {
    // Do nothing
  }

  void buttonB(int group) {
    // Do nothing
  }

  void drawWidget(float cx, float cy) {
    fill(255);
    textAlign(CENTER);
    textSize(fontSize);
    text(hour() + " : " + nf(minute(), 2) + " : " + nf(second(), 2), cx, cy);
  }
}