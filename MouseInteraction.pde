// mouse control

void mouseClicked() {
  // img control to select current pixel
  float xMinImg = width - gap*scaleFactor - imgWidth*scaleFactor;
  float xMaxImg = xMinImg + imgWidth*scaleFactor;
  float yMinImg = height - gap*scaleFactor - imgHeight*scaleFactor;
  float yMaxImg = height - gap*scaleFactor;
  
  if (getFilesPath && doneLoading) {
    
  imgOver(xMinImg, xMaxImg, yMinImg, yMaxImg);
  
  // checkbox Data Information
  if (mouseX>checkBoxDataInfo.xPos && mouseX<(checkBoxDataInfo.xPos+checkBoxDataInfo.size) && mouseY>checkBoxDataInfo.yPos && mouseY<(checkBoxDataInfo.yPos+checkBoxDataInfo.size)) {
    if (drawDataInfo == true) {
      drawDataInfo = false;
    } else {
      drawDataInfo = true;
    }
  } // end - if
  
  // checkbox Correlation Links
  if (mouseX>checkBoxLinks.xPos && mouseX<(checkBoxLinks.xPos+checkBoxLinks.size) && mouseY>checkBoxLinks.yPos && mouseY<(checkBoxLinks.yPos+checkBoxLinks.size)) {
    if (drawLinks == true) {
      drawLinks = false;
    } else {
      drawLinks = true;
    }
  } // end - if
  
  // checkbox Volume Labels
  if (mouseX>checkBoxLabels.xPos && mouseX<(checkBoxLabels.xPos+checkBoxLabels.size) && mouseY>checkBoxLabels.yPos && mouseY<(checkBoxLabels.yPos+checkBoxLabels.size)) {
    if (drawLabels == true) {
      drawLabels = false;
    } else {
      drawLabels = true;
    }
  } // end - if
    
  // checkbox 3D View
  if (mouseX>checkBox3dView.xPos && mouseX<(checkBox3dView.xPos+checkBox3dView.size) && mouseY>checkBox3dView.yPos && mouseY<(checkBox3dView.yPos+checkBox3dView.size)) {
    if (draw3dView == true) {
      draw3dView = false;
    } else {
      draw3dView = true;
    }
  } // end - if
  
  // button rotations for 3D view
  if (buttonXneg.overRect()) {
    rotateX -= 0.1;
  } else if (buttonXpos.overRect()) {
    rotateX += 0.1;
  } else if (buttonZneg.overRect()) {
    rotateZ -= 0.1;
  } else if (buttonZpos.overRect()) {
    rotateZ += 0.1;
  } else if (buttonYneg.overRect()) {
    rotateRate = rotateRate/2;
  } else if (buttonYpos.overRect()) {
    rotateRate = rotateRate*2;
  } 
  
  // reload new data set
  if (buttonReOpen.overRect()) {
    firstOpen = false;
    doneLoading = false;    
    file = OpenFile(fc);  // open file
    if (file != null) {
      path = file.getPath();  // get the path
      setup();  // initialize all the objects and variables for drawing the graph
    }
  }
  
  }  // end - if (getFilesPath && doneLoading)
 
}


void imgOver(float x0, float x1, float y0, float y1) {
  if (mouseX>=x0 && mouseX<=x1 && mouseY >=y0 && mouseY <= y1) {
    // get current pixel ID
    if (mouseButton == LEFT && count < maxView) {     
      if (mouseBrain) {
        pixelID[count] = int((mouseY-y0)/scaleFactor)*imgWidth + int((mouseX-x0)/scaleFactor);
        println("current pixel ID: " + pixelID[count]);
        count++;
      } else {        
        for (int i=0; i<pixel; i++) {
          if (abs(mouseX - x0 - nPositionFile.value[i][0]*imgWidth*scaleFactor) < scaleFactor*2 && abs(mouseY - y0 - nPositionFile.value[i][1]*imgWidth*scaleFactor) < scaleFactor*2) {
            pixelID[count] = i;
            println("current pixel ID: " + pixelID[count]);
            count++;
          }
        }
      }      
      
    } else if (mouseButton == RIGHT && count > 0) {      
      count--;
      pixelID[count] = -1;        
    }
  }
}


void mouseReleased() {
  if (getFilesPath && doneLoading) {
    timeSlider.lockedStart = false;
    timeSlider.lockedEnd = false;
    for (int i=0; i<maxView; i++) {
      active[i] = false;
    }
  }
}


void mousePressed() {
  if (!getFilesPath) {  // effective only at the opening view
    if (buttonOpen.overRect()) {
      file = OpenFile(fc);  // open file
      if (file != null) {
        path = file.getPath();  // get the path
        getFilesPath = true; 
        setup();  // initialize all the objects and variables for drawing the graph
      }
    }
  }
}


void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
  if (e > 0) {
    scale3D = scale3D+0.1;
  } else {
    scale3D = scale3D-0.1;
  }
  //println(e);
}


void keyPressed() {
  if (key == CODED && getFilesPath && doneLoading) {  //  
    if (keyCode == LEFT && currentFrame>0 && drawBox[currentFrame]) {
      currentFrame--;
      drawBox[currentFrame] = true;
    } else if (keyCode == RIGHT && currentFrame<nDegreeFile.timeline-1) {
      if (drawBox[currentFrame]) {
      currentFrame++;
      drawBox[currentFrame] = true;
      } else {
        currentFrame++;
      }
    }
    println("currentFrame " + currentFrame);
  }
}
