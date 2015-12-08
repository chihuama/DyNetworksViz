//

class CheckBox {
  
  float xPos;
  float yPos;
  float size;  
  String text;
  color bColor;
  boolean draw;
  
  CheckBox(float x, float y, float w, String t, color c, boolean d) {
    xPos = x;
    yPos = y;
    size = w;
    text = t;
    bColor = c;
    draw = d;
  }
  
  void draw() {
    noFill();
    stroke(bColor);
    strokeWeight(scaleFactor);
    smooth();
    rect(xPos, yPos, size, size);
    fill(bColor);
    textSize(size*scaleFactor);
    textAlign(LEFT, TOP);
    text(text, xPos+size*2, yPos);
    
    if(draw) {  // cross line
      line(xPos+scaleFactor*2, yPos+scaleFactor*2, xPos+size-scaleFactor*2, yPos+size-scaleFactor*2);
      line(xPos+scaleFactor*2, yPos+size-scaleFactor*2, xPos+size-scaleFactor*2, yPos+scaleFactor*2);
    }
  } // end - draw()
  
}
