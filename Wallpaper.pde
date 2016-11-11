/* Background gfx
 * @author wbock
 * 
 */
class Wallpaper extends Widget {

  int margin;

  Wallpaper() {
    margin = width/28;
  }

  void buttonA(int group) {
    //Do nothing
  }

  void buttonB(int group) {
    //Do nothing
  }

  void drawWidget(float x, float y) {
    fill(0);
    stroke(255);
    strokeWeight(2);
    rect(x + margin, y + margin, width-2*margin, height-2*margin);
  }
}