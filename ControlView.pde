// control view


void ControlView() {
  
  // background 
  fill(205);
  noStroke();
  rect(gap*scaleFactor/2, height - gap*scaleFactor*3/2 - imgHeight*scaleFactor, width - gap*scaleFactor, gap*scaleFactor + imgHeight*scaleFactor);
  
  // draw 2D image
  float xMin = width - gap*scaleFactor - imgWidth*scaleFactor;
  float yMin = height - gap*scaleFactor - imgHeight*scaleFactor;
  float xMax = width - gap*scaleFactor;
  float yMax = height - gap*scaleFactor;

  image(img, xMin, yMin, imgWidth*scaleFactor, imgHeight*scaleFactor);
  
  // draw clusters at current frame
  for (int i=0; i<pixel; i++) {
      if (iColorFile.value[currentFrame][i] != 0 && drawBox[currentFrame]) {
      stroke(clusterColor[(int)iColorFile.value[currentFrame][i]-1]);
      strokeWeight(scaleFactor);
      if (mouseBrain) {
        point(xMin+(i%imgWidth)*scaleFactor, yMin+(i/imgWidth)*scaleFactor);
      } else {
        point(xMin+(nPositionFile.value[i][0]*imgWidth)*scaleFactor, yMin+(nPositionFile.value[i][1]*imgWidth)*scaleFactor);
      }
    }
  }
  
  // draw highlight node
  for (int j=0; j<count; j++) {
    stroke(pixelColor[j], 220);
    strokeWeight(scaleFactor*6);
    if (mouseBrain) {
      point(xMin+(pixelID[j]%imgWidth)*scaleFactor, yMin+(pixelID[j]/imgWidth)*scaleFactor);
    } else {
      point(xMin+(nPositionFile.value[pixelID[j]][0]*imgWidth)*scaleFactor, yMin+(nPositionFile.value[pixelID[j]][1]*imgWidth)*scaleFactor);
    }
  } 
  /***************************************************************************************/
  
  // check boxes  
  checkBoxDataInfo = new CheckBox(gap*scaleFactor*3, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2/3, "Data Information", color(40), drawDataInfo);
  checkBoxDataInfo.draw(); 
  checkBoxLinks = new CheckBox(gap*scaleFactor*3, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, gap*scaleFactor*2/3, "Correlation Links", color(40), drawLinks);
  checkBoxLinks.draw();  
  checkBoxLabels = new CheckBox(gap*scaleFactor*3, height - imgHeight*scaleFactor + gap*scaleFactor*4.5, gap*scaleFactor*2/3, "Volume Labels", color(40), drawLabels);
  checkBoxLabels.draw();    
  /*
  w50 = new CheckBox(gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2/3, "50", color(40), draw50);
  w50.draw();
  w100 = new CheckBox(gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, gap*scaleFactor*2/3, "100", color(40), draw100);
  w100.draw();
  w200 = new CheckBox(gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*4.5, gap*scaleFactor*2/3, "200", color(40), draw200);
  w200.draw();
  */
  checkBox3dView = new CheckBox(gap*scaleFactor*13, height - imgHeight*scaleFactor + gap*scaleFactor*1.5, gap*scaleFactor*2/3, "3D View", color(40), draw3dView);
  //checkBox3dView = new CheckBox(gap*scaleFactor*19.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.5, gap*scaleFactor*2/3, "3D View", color(40), draw3dView);
  checkBox3dView.draw();
  
  stroke(40);
  strokeWeight(scaleFactor);
  line(gap*scaleFactor*2.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*10.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*2.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*2.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*10.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*10.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*2.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5, gap*scaleFactor*10.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  /*
  line(gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*16, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*17, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*17, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*17, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5, gap*scaleFactor*17, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  */
  line(gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*17.7, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*22, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*22, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*22, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*11.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5, gap*scaleFactor*22, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  /*
  line(gap*scaleFactor*18, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*19, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*23.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*25.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75);
  line(gap*scaleFactor*18, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*18, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*25.5, height - imgHeight*scaleFactor + gap*scaleFactor*1.75, gap*scaleFactor*25.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  line(gap*scaleFactor*18, height - imgHeight*scaleFactor + gap*scaleFactor*5.5, gap*scaleFactor*25.5, height - imgHeight*scaleFactor + gap*scaleFactor*5.5);
  */
  fill(40);
  textSize(gap*scaleFactor*2/3);
  textAlign(LEFT, TOP);
  //text("Community View", gap*scaleFactor*13, height - imgHeight*scaleFactor + gap*scaleFactor*1.5);
  text("Rotate X: ", gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*2.5);
  text("Rotate Z: ", gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*3.5);
  text("Rotate Y: ", gap*scaleFactor*12.5, height - imgHeight*scaleFactor + gap*scaleFactor*4.5);
  
  buttonXneg = new Button(gap*scaleFactor*16, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "-", gap*scaleFactor*2/3);
  buttonXneg.draw();
  buttonXpos = new Button(gap*scaleFactor*17.5, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "+", gap*scaleFactor*2/3);
  buttonXpos.draw();
  buttonZneg = new Button(gap*scaleFactor*16, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "-", gap*scaleFactor*2/3);
  buttonZneg.draw();
  buttonZpos = new Button(gap*scaleFactor*17.5, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "+", gap*scaleFactor*2/3);
  buttonZpos.draw();
  buttonYneg = new Button(gap*scaleFactor*16, height - imgHeight*scaleFactor + gap*scaleFactor*4.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "-", gap*scaleFactor*2/3);
  buttonYneg.draw();
  buttonYpos = new Button(gap*scaleFactor*17.5, height - imgHeight*scaleFactor + gap*scaleFactor*4.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "+", gap*scaleFactor*2/3);
  buttonYpos.draw();
  
  buttonPlay = new Button(gap*scaleFactor*19, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2, gap*scaleFactor, "Play", gap*scaleFactor*2/3);
  buttonPlay.draw();
  buttonPause = new Button(gap*scaleFactor*19, height - imgHeight*scaleFactor + gap*scaleFactor*4, gap*scaleFactor*2, gap*scaleFactor, "Pause", gap*scaleFactor*2/3);
  buttonPause.draw();
  /*
  text("Rotate X: ", gap*scaleFactor*19, height - imgHeight*scaleFactor + gap*scaleFactor*2.5);
  text("Rotate Z: ", gap*scaleFactor*19, height - imgHeight*scaleFactor + gap*scaleFactor*3.5);
  text("Rotate Y: ", gap*scaleFactor*19, height - imgHeight*scaleFactor + gap*scaleFactor*4.5);
  
  buttonXneg = new Button(gap*scaleFactor*22.5, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "-", gap*scaleFactor*2/3);
  buttonXneg.draw();
  buttonXpos = new Button(gap*scaleFactor*24, height - imgHeight*scaleFactor + gap*scaleFactor*2.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "+", gap*scaleFactor*2/3);
  buttonXpos.draw();
  buttonZneg = new Button(gap*scaleFactor*22.5, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "-", gap*scaleFactor*2/3);
  buttonZneg.draw();
  buttonZpos = new Button(gap*scaleFactor*24, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "+", gap*scaleFactor*2/3);
  buttonZpos.draw();
  buttonYneg = new Button(gap*scaleFactor*22.5, height - imgHeight*scaleFactor + gap*scaleFactor*4.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "-", gap*scaleFactor*2/3);
  buttonYneg.draw();
  buttonYpos = new Button(gap*scaleFactor*24, height - imgHeight*scaleFactor + gap*scaleFactor*4.5, gap*scaleFactor*2/3, gap*scaleFactor*2/3, "+", gap*scaleFactor*2/3);
  buttonYpos.draw();
  */  
  // legend 
  fill(40);
  textSize(gap*scaleFactor*2/3);
  textAlign(LEFT, TOP);
  text("Top 10 Communities", gap*scaleFactor*23, height - imgHeight*scaleFactor + gap*scaleFactor*2);
  float legendSize = (width - gap*scaleFactor*25.5 - imgWidth*scaleFactor)/10;
  for (int i=0; i<top; i++) {
    noStroke();
    fill(clusterColor[i]);
    stroke(clusterColor[i]);
    strokeWeight(scaleFactor/2.0);
    rect(gap*scaleFactor*23 + legendSize*i, height - imgHeight*scaleFactor + gap*scaleFactor*3.5, legendSize*4/5, legendSize*2/5);
  }
  
  buttonReOpen = new Button(gap*scaleFactor*2, height - imgHeight*scaleFactor - gap*scaleFactor, textWidth("New Data") + gap*scaleFactor/2, gap*scaleFactor, "New Data", gap*scaleFactor*2/3);
  buttonReOpen.draw();
  
  timeSlider.draw();
  /***************************************************************************************/
  /*
  // show static correlation value
  fill(clusterColor[0]);
  textSize(14*scaleFactor);
  textAlign(LEFT, TOP);
  text("cor: " + nfc(corValue,3), gap*scaleFactor*2, yMin);
  text("Shift: " + shiftFrame, gap*scaleFactor*2, yMin+gap*scaleFactor*3/2);
  
  text("corMax: " + nfc(corShift[corShiftMaxIndex+100],3), gap*scaleFactor*2, yMin+gap*scaleFactor*3);
  text("Shift: " + corShiftMaxIndex, gap*scaleFactor*2, yMin+gap*scaleFactor*9/2);
  
  // draw shift bars
  noFill();
  stroke(clusterColor[1]);
  strokeWeight(scaleFactor);
  rect(gap*scaleFactor*8, yMin, gap*scaleFactor*15, gap*scaleFactor);
  rect(gap*scaleFactor*8 + shiftFrame*(gap*scaleFactor*15)/timeTotal, yMin+gap*scaleFactor*3/2, gap*scaleFactor*15, gap*scaleFactor);
  */
}
