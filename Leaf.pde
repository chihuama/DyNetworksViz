//

class Leaf {
  float xMin;
  float xMax;
  float yMin;
  float yMax;
  float yHeight;   // height of the middle part (trunk)
  float deltaX;    // width of bars for node degree
  float xShift;    // shift body from the start time of window to the middle point
  
  int pValueTimeline;
  int nDegreeTimeline;
  int viewIndex;
  int currentPixel;
  float[] pValue;
  float[] nDegree;
  float[] corMean;
  float pValueMin, pValueMax;
  color plotColor;
  int index;
  
  Leaf(float[][] pV, int pVT, float[][] nD, float[][] cM, int nDT, int vIndex, color pColor, float x, float xW, float y, float yH) {
    pValueTimeline = pVT;
    nDegreeTimeline = nDT;    
    viewIndex = vIndex;
    currentPixel = pixelID[viewIndex];
    pValue = new float[pValueTimeline];
    nDegree = new float[nDegreeTimeline];
    corMean = new float[nDegreeTimeline];
    for (int i=0; i<pValueTimeline; i++) {
      pValue[i] = pV[i][currentPixel];
    }
    for (int i=0; i<nDegreeTimeline; i++) {
      nDegree[i] = nD[i][currentPixel];
      corMean[i] = cM[i][currentPixel];
    }
    
    pValueMin = getMin(pValue, pValueTimeline);
    pValueMax = getMax(pValue, pValueTimeline);
    
    plotColor = pColor;
    xMin = x;
    xMax = x + xW;
    yMin = y - yH*3;
    yMax = y + yH*3;
    yHeight = yH;
    deltaX = (xMax-xMin)/float(frameEnd-frameStart);
    xShift = (xMax-xMin)*halfWinSize/float(frameEnd-frameStart); 
  } // end - Leaf()
  
  void draw() {
    update();
    noStroke();  
    fill(color(25));
    //translate(0, 0, -1);
    rect(xMin, (yMax+yMin-yHeight)/2, xMax-xMin, yHeight);    
    triangle(xMax, (yMax+yMin-yHeight)/2, xMax, (yMax+yMin+yHeight)/2, xMax+gap*scaleFactor*3, (yMax+yMin)/2);
    ellipse(xMax+gap*scaleFactor*3-yHeight/8, (yMax+yMin)/2, yHeight/4, yHeight/4);
    ellipse(xMax, (yMax+yMin+yHeight)/2, yHeight/4, yHeight/4);
    //translate(0, 0, 1);
    fill(plotColor);
    //ellipse(xMin - gap*scaleFactor*2 + yHeight*3/4, (yMax+yMin)/2, yHeight*3/2, yHeight*3/2);
    ellipse(xMin - yHeight*3/8, (yMax+yMin)/2, yHeight*3/2, yHeight*3/2);    
    stroke(color(25));
    strokeWeight(scaleFactor);
    line(xMax, (yMax+yMin-yHeight)/2, xMax, (yMax+yMin+yHeight)/2);
    /*fill(180);
    textSize(12*scaleFactor);
    textAlign(CENTER, CENTER);
    text(frameStart, xMin - gap*scaleFactor*2 + yHeight*3/4, (yMax+yMin)/2);
    textAlign(LEFT, CENTER);
    text(frameEnd, xMax, (yMax+yMin)/2);
    */
    drawDataLine();
    drawDataArea();
    drawDataPoint();
    drawVolumeLabels();
    showDetail();    
  }
  
  // mouse interaction to move the location
  void update() {
    if (mousePressed && abs(mouseX-(xMin - gap*scaleFactor*2 + yHeight*3/4)) <= scaleFactor*15 && abs(mouseY-(yMax+yMin)/2) <= scaleFactor*15) {
      active[viewIndex] = true;
    }
    if (active[viewIndex]) {
      if (mouseX > yHeight*3/4 && mouseX < (width - yHeight*3/4)) {
        leafX[viewIndex] = mouseX;
      }
      //if (mouseY <= (height - gap*scaleFactor*2 - imgHeight*scaleFactor - (yMax-yMin)/2) && mouseY > (yMax-yMin)/2) {
      if (mouseY <= (height - gap*scaleFactor*2 - imgHeight*scaleFactor - yHeight*3/4) && mouseY > yHeight*3/4) {
        leafY[viewIndex] = mouseY;
      }
      //println("leafX: " + leafX[viewIndex]);
      //println("leafY: " + leafY[viewIndex]);
    }
    
    // change width
    if (mousePressed && abs(mouseX-(xMax+gap*scaleFactor*3-yHeight/8)) <= scaleFactor*15 && abs(mouseY-(yMax+yMin)/2) <= scaleFactor*15) {
      leafW = mouseX - xMin - (gap*scaleFactor*3-yHeight/8);
    }
    // change height
    if (mousePressed && abs(mouseX-xMax) <= scaleFactor*15 && abs(mouseY-(yMax+yMin+yHeight)/2) <= scaleFactor*15) {
      leafH = abs(mouseY - (yMax+yMin-yHeight)/2);
    }
  }
  /*
  boolean over(float x0, float x1, float y0, float y1) {
    if (mouseX >= x0 && mouseX <= x1 && mouseY >= y0 && mouseY <= y1) {
      return true;
    } else {
      return false;
    }
  }
  */
  // pixel value
  void drawDataLine() {
    noFill();
    stroke(clusterColor[7], 250);
    strokeWeight(scaleFactor);
    beginShape();
    for (int i=frameStart; i<frameEnd; i++) {
      float x = map(i, frameStart, frameEnd, xMin, xMax);
      float y = map(pValue[i], pValueMin, pValueMax, (yMax+yMin+yHeight/2)/2, (yMax+yMin-yHeight)/2);
      vertex(x, y); 
    }
    endShape();
    
    // time labels
    int deltaTime = (frameEnd - frameStart)/20;
    for (int j=frameStart; j<frameEnd; j=j+deltaTime) {
      float xT = map(j, frameStart, frameEnd, xMin, xMax);
      stroke(225);
      strokeWeight(scaleFactor);
      line(xT, (yMax+yMin+yHeight)/2, xT, (yMax+yMin+yHeight)/2 - yHeight/10 + scaleFactor); 
      fill(225);
      //textSize(8*scaleFactor);
      textSize(yHeight/5);
      textAlign(CENTER, BOTTOM);
      text(j+1, xT, (yMax+yMin+yHeight)/2 - yHeight/10);
    }
  } // end - drawDataLine()
  
   // node degree - upper
  void drawDataArea() {           
    noStroke();
    for (int i=0; i<min(nDegreeTimeline, frameEnd); i++) {
      float x = map(i, frameStart, frameEnd, xMin, xMax) + xShift;
      //float y = map(nDegree[i], nDegreeMin, nDegreeMax, (yMax+yMin+yHeight)/2, yMax);  // lower
      float y = map(nDegree[i], nDegreeMin, nDegreeMax, (yMax+yMin-yHeight)/2, yMin);
      if (iColorFile.value[i][currentPixel] != 0 && (x+deltaX+1) < xMax && x > xMin) {
        fill(clusterColor[(int)iColorFile.value[i][currentPixel]-1]);   // change color according to clusters   
        //rect(x, (yMax+yMin+yHeight)/2, deltaX+1, y-(yMax+yMin+yHeight)/2);   
        rect(x, y, deltaX+1, (yMax+yMin-yHeight)/2-y);
      } 
    }
  } // end - drawDataArea()
  
  // mean correlation values - lower
  void drawDataPoint() {
    noFill();    
    for (int i=0; i<min(nDegreeTimeline,frameEnd); i++) {
      float x = map(i, frameStart, frameEnd, xMin, xMax) + xShift;
      //float y = map(corMean[i], corMeanMin, corMeanMax, (yMax+yMin-yHeight)/2, yMin);  // upper
      float y = map(corMean[i], corMeanMin, corMeanMax, (yMax+yMin+yHeight)/2, yMax);
      
      if (gColorFile.value[i][currentPixel] != 0 && x < xMax && x > xMin) {
        stroke(clusterColor[(int)gColorFile.value[i][currentPixel]-1]);        
        strokeWeight(scaleFactor * int(timeTotal/(frameEnd-frameStart)/3 + 1));
        line(x, y, x, (yMax+yMin+yHeight)/2);
        strokeWeight(scaleFactor*2 * int(timeTotal/(frameEnd-frameStart)/3 + 1));
        point(x, y); 
      }
      
      // click the point
      if (mousePressed && abs(mouseX-x) <= scaleFactor*2 && abs(mouseY-y) <= scaleFactor*2) {
        drawBox[i] = true;
        currentFrame = i;
        //println("currentFrame " + currentFrame);
      }      
    } // end -for()   
  } // end - drawDataPoint()
  
  // volume labels
  void drawVolumeLabels() {
    if (drawLabels) {      
      stroke(25);
      strokeWeight(scaleFactor);      
      line(xMin - yHeight*3/8, (yMax+yMin+yHeight/2)/2, xMin - yHeight*3/8, (yMax+yMin-yHeight)/2);
      line(xMin - yHeight*3/8 - scaleFactor*5, (yMax+yMin+yHeight/2)/2, xMin - yHeight*3/8, (yMax+yMin+yHeight/2)/2);
      line(xMin - yHeight*3/8 - scaleFactor*5, (yMax+yMin-yHeight)/2, xMin - yHeight*3/8, (yMax+yMin-yHeight)/2);
      fill(25);      
      //textSize(scaleFactor*8);
      textSize(yHeight/5);
      textAlign(RIGHT, CENTER);
      text((int)pValueMin, xMin - yHeight*3/8 - scaleFactor*5, (yMax+yMin+yHeight/2)/2);
      text((int)pValueMax, xMin - yHeight*3/8 - scaleFactor*5, (yMax+yMin-yHeight)/2);
      
      line(xMin - scaleFactor, (yMax+yMin-yHeight)/2, xMin - scaleFactor, yMin);
      line(xMin - scaleFactor*6, (yMax+yMin-yHeight)/2, xMin, (yMax+yMin-yHeight)/2);
      line(xMin - scaleFactor*6, yMin, xMin, yMin);
      text((int)nDegreeMin, xMin - scaleFactor*5, (yMax+yMin-yHeight)/2);
      text((int)nDegreeMax, xMin - scaleFactor*5, yMin);
      
      line(xMin - scaleFactor, (yMax+yMin+yHeight)/2, xMin - scaleFactor, yMax);
      line(xMin - scaleFactor*6, (yMax+yMin+yHeight)/2, xMin, (yMax+yMin+yHeight)/2);
      line(xMin - scaleFactor*6, yMax, xMin, yMax);      
      text(nfc(corMeanMin, 2), xMin - scaleFactor*5, (yMax+yMin+yHeight)/2);
      text(nfc(corMeanMax, 2), xMin - scaleFactor*5, yMax);
    }
  }
  
  // show detail information
  void showDetail() {
    if (drawBox[currentFrame]) {
      
      // window size
      float x = map(currentFrame, frameStart, frameEnd, xMin, xMax);
      float x2 = (xMax-xMin)*halfWinSize*2/float(frameEnd-frameStart);
      fill(plotColor, 180);
      stroke(plotColor);
      strokeWeight(scaleFactor);
      //translate(0, 0, 1);
      if (x < xMin && (x+x2-xMin) >= 0) {
        rect(xMin, (yMax+yMin-yHeight)/2, min(x+x2-xMin, xMax-xMin), yHeight);
      } 
      if (x >= xMin && (xMax-x) >= 0) {
        rect(x, (yMax+yMin-yHeight)/2, min(x2, xMax-x), yHeight);
      }
      
      if (x+x2/2 < xMax && x+x2/2 > xMin) {
        // draw box
        stroke(20);
        fill(25, 220); 
        translate(0, 0, 1);        
        float y = map(corMean[currentFrame], corMeanMin, corMeanMax, (yMax+yMin+yHeight)/2, yMax) - scaleFactor*60;
        float y2 = map(nDegree[currentFrame], nDegreeMin, nDegreeMax, (yMax+yMin-yHeight)/2, yMin);
        rect(x + x2/2 + scaleFactor*3, y + scaleFactor*3, scaleFactor*140, scaleFactor*60);
        // close box - center: x + x2/2 + scaleFactor*137, y + scaleFactor*9
        stroke(225, 220);
        line(x + x2/2 + scaleFactor*133, y + scaleFactor*5, x + x2/2 + scaleFactor*141, y + scaleFactor*13);
        line(x + x2/2 + scaleFactor*133, y + scaleFactor*13, x + x2/2 + scaleFactor*141, y + scaleFactor*5);
        if (mousePressed && abs(mouseX - (x + x2/2 + scaleFactor*137)) < scaleFactor*8 && abs(mouseY - (y + scaleFactor*9)) < scaleFactor*8) {
          drawBox[currentFrame] = false;
        }
        stroke(40, 220);
        line(x+x2/2, (yMax+yMin+yHeight)/2, x+x2/2, y2);
              
        //fill(plotColor);
        fill(225);
        textSize(12*scaleFactor);
        textAlign(LEFT, TOP);
        text("Frame No.: " + (currentFrame+halfWinSize+1), x + x2/2 + scaleFactor*5, y + scaleFactor*4);
        if (mouseBrain) {
          text("Node Value: " + int(pValue[currentFrame]), x + x2/2 + scaleFactor*5, y + scaleFactor*18);
        } else {
          text("Node Value: " + nfc(pValue[currentFrame], 3), x + x2/2 + scaleFactor*5, y + scaleFactor*18);
        }
        text("Node Degree: " + int(nDegree[currentFrame]), x + x2/2 + scaleFactor*5, y + scaleFactor*32);
        text("Mean Weight: " + nfc(corMean[currentFrame], 3), x + x2/2 + scaleFactor*5, y + scaleFactor*46);
        translate(0, 0, -1);
      }
      //translate(0, 0, -1);
    }
  } // end - showDetail()
}
