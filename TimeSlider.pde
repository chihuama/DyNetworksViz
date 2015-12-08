// time slider for zooming in/out

public int frameStart = 0;
public int frameEnd = 1500;
public int timeTotal = 1500;
public int bgColor = 40;

public int timeSeg = 25;


class TimeSlider {
  float xPos, yPos;
  float bWidth, bHeight;            // width and height of bar
  float sposStart, newsposStart;    // x position of slider for starting point
  float sposEnd, newsposEnd;        // x position of slider for ending point
  float sposMin, sposMax;           // max and min values of slider
  float loose = 1;                  // how loose/heavy
  boolean lockedStart = false;
  boolean lockedEnd = false;
  
  //int timeInterval = 50;  
  int timeInterval = timeTotal/timeSeg;
  
  TimeSlider(float x0, float x1, float y0, float y1) {
    xPos = x0;
    yPos = y0;
    bWidth = x1-x0;
    bHeight = y1-y0;
    
    sposMin = xPos;
    sposMax = xPos + bWidth - bHeight;    
    
    sposStart = xPos + (frameStart/timeTotal)*(bWidth-bHeight);
    newsposStart = sposStart;    
    sposEnd = xPos + (frameEnd/timeTotal)*(bWidth-bHeight);
    newsposEnd = sposEnd;
  }
  
  void draw() {    
    update();
    display();
    drawTimeLabels();
  }
  
  void update() {
    if (mousePressed && overEnd()) {
      lockedEnd = true;
      lockedStart = false;
    }
    if (mousePressed && overStart()) {
      lockedStart = true;
      lockedEnd = false;
    }
    
    if (lockedEnd) {
      newsposEnd = constrain(mouseX-bHeight/2, sposStart, sposMax);
    }
    if (abs(newsposEnd - sposEnd) > 1) {
      sposEnd = sposEnd + (newsposEnd-sposEnd)/loose;
    }    
    
    if (lockedStart) {
      newsposStart = constrain(mouseX-bHeight/2, sposMin, sposEnd); 
    }
    if (abs(newsposStart - sposStart) > 1) {
      sposStart = sposStart + (newsposStart-sposStart)/loose;
    } 
  } // end - update()
  
  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }
  
  boolean overStart() {
    if (mouseX > sposStart && mouseX < sposStart+bHeight && mouseY > yPos && mouseY < yPos+bHeight && !lockedEnd) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean overEnd() {
    if (mouseX > sposEnd && mouseX < sposEnd+bHeight && mouseY > yPos && mouseY < yPos+bHeight && !lockedStart) {
      return true;
    } else {
      return false;
    }
  }
  
  
  void display() {
    noFill();
    stroke(bgColor);
    strokeWeight(scaleFactor);
    rect(xPos, yPos, bWidth, bHeight, scaleFactor*5);
    
    noStroke();
    fill(bgColor, 80);
    rect(sposStart+bHeight/2, yPos, sposEnd-sposStart, bHeight, scaleFactor);
    //rect(xPos, yPos, sposStart-xPos+bHeight, bHeight, scaleFactor*5);
    //rect(sposEnd, yPos, xPos+bWidth-sposEnd, bHeight, scaleFactor*5);
    
    frameStart = round((sposStart-xPos)*timeTotal/(bWidth-bHeight));  // set the starting point according to the time start slider
    frameEnd = round((sposEnd-xPos)*timeTotal/(bWidth-bHeight)); // set the ending point according to the time end slider
    
    // draw start/end time on the start/end rect sliders
    noStroke();
    if (overStart() || lockedStart) {
      fill(bgColor);
    } else {
      fill(bgColor*2);
    }
    rect(sposStart, yPos, bHeight, bHeight, scaleFactor*5);     
    
    if (overEnd() || lockedEnd) {
      fill(bgColor);
    } else {
      fill(bgColor*2);
    }
    rect(sposEnd, yPos, bHeight, bHeight, scaleFactor*5);    
  
    // draw current frame's location  
    //if (drawBox[currentFrame]) {  
    if (currentFrame > 0) {    
      stroke(bgColor);
      strokeWeight(scaleFactor);
      float x = xPos + (currentFrame+halfWinSize+1)*(bWidth-bHeight)/timeTotal + bHeight/2;
      line(x, yPos, x, yPos+bHeight);  
    }
  } // end - display()
  
  void drawTimeLabels() {
    //smooth();
    fill(bgColor/2);
    stroke(bgColor);        
    strokeWeight(scaleFactor/2.0);
    textSize(10*scaleFactor);
    textAlign(CENTER, TOP);  
    for (int t = 0; t <= timeTotal; t += timeInterval) {      
      float x = map(t, 0,timeTotal, xPos+bHeight/2, xPos+bWidth-bHeight/2);
      text(t, x, yPos+bHeight*3/2);
      line(x, yPos+bHeight, x, yPos+bHeight*11/8);
    }
  } // end - drawTimeLabels()
}
