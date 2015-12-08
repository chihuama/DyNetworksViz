// button

class Button {
  float rectX, rectY, rectW, rectH;
  String text;
  int textSize;
  boolean rectOver = false;
  
  Button(float x, float y, float w, float h, String t, int s) {
    rectX = x;
    rectY = y;
    rectW = w;
    rectH = h;
    text = t;
    textSize = s;
  }
  
  void draw() {    
    if (overRect()) {
      fill(25, 120);
    } else {
      noFill();
    }
    stroke(40);
    strokeWeight(scaleFactor);
    rect(rectX, rectY, rectW, rectH);
    
    fill(40);
    textSize(textSize);
    textAlign(CENTER, CENTER);
    text(text, rectX + rectW/2, rectY + rectH/2 - scaleFactor*3);
  }
  
  boolean overRect() {
    if (mouseX >= rectX && mouseX <= rectX  + rectW && mouseY >= rectY && mouseY <= rectY + rectH) {
      return true;
    } else {
      return false;
    }
  }
}
