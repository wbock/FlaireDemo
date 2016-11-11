/* Flip through images in multi-dim PImage array.
 * Format: PImage[setNr][imgNr]
 * @author wbock
 * 
 */
class Gallery extends Widget {

  PImage[][] images;
  int image, set, group;
  float margin;
  float imgWidth, imgHeight;

  // Make sure all images are exactly the same size to avoid scaling issues
  Gallery(PImage[][] images, int marginPercent, int group) {
    this.images = images;
    this.group = group;
    this.margin = marginPercent * width;
    image = 0;
    set = 0;
    imgWidth = width-2*margin;
    imgHeight = (float)  images[0][0].height / (float) images[0][0].width * imgWidth;
  }

  void buttonA(int group) {
    if (this.group == group) {
      image++;
      if (image >= images[set].length) {
        image = 0;
      }
    }
  }

  void buttonB(int group) {
    if(this.group == group) {
      set++;
      if (set >= images.length) {
        set = 0;
      }
      if (image >= images[set].length) {
        image = 0;
      }
    }
  }

  void drawWidget(float x, float y) {
    image(images[set][image], x + margin, y + margin, imgWidth, imgHeight);
  }
}