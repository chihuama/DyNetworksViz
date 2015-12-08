// 3D view

public boolean rotate = true;
public float rotateRate = 0.006;
public float rotateY = 0;
public float rotateX = -PI/18.0;
public float rotateZ = 0;
public float scale3D = 1;

public float xCenter;
public float yCenter;

void SpatialView() {
    
  float xMin = width - gap*scaleFactor - (imgWidth*9/2)*scaleFactor;
  float yMin = gap*scaleFactor;
  float xMax = width - gap*scaleFactor;
  float yMax = height - gap*scaleFactor*2 - imgHeight*scaleFactor;
  
  // background 
  //fill(bgColor);
  fill(185);
  noStroke();
  translate(0, 0, 3);
  rect(xMin, yMin, xMax-xMin, yMax-yMin);
  translate(0, 0, -3);
  
  //camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  
  // texture the img
  //xCenter = (xMax+xMin)/2 - imgWidth*scaleFactor*2/3;
  //yCenter = yMax - imgHeight*scaleFactor*4/3;
  if (mousePressed && mouseX>xMin+imgWidth*scaleFactor*2/3 && mouseX<xMax-imgWidth*scaleFactor*2/3 && mouseY>yMin && mouseY<yMax) {
    xCenter = mouseX;
    yCenter = mouseY;
  }
  //float zCenter = -imgHeight*scaleFactor/2;
  float zCenter = imgHeight*scaleFactor*3/2;
  translate(xCenter, yCenter, zCenter);
  rotateX(rotateX); 
  rotateZ(rotateZ); 
  if (rotate) {
    rotateY += rotateRate;      
  } 
  rotateY(rotateY); 
  noFill();
  //stroke(bgColor);
  noStroke();
  beginShape();
  texture(img);
  vertex(-imgWidth*scaleFactor*scale3D, 0, -imgHeight*scaleFactor*scale3D, 0, 0);
  vertex(-imgWidth*scaleFactor*scale3D, 0, imgHeight*scaleFactor*scale3D, 0, imgHeight);
  vertex(imgWidth*scaleFactor*scale3D, 0, imgHeight*scaleFactor*scale3D, imgWidth, imgHeight);
  vertex(imgWidth*scaleFactor*scale3D, 0, -imgHeight*scaleFactor*scale3D, imgWidth, 0);
  endShape(CLOSE);

  // draw nodes
  float y = (yCenter-yMin*10)/nDegreeMax;
  for (int i=0; i<pixel; i++) {
    //int x = i%imgWidth;
    //int z = i/imgWidth;
    float x = 0;
    float z = 0;
    if (mouseBrain) {
      x = int(i%imgWidth);
      z = int(i/imgWidth);
    } else{
      x = nPositionFile.value[i][0]*imgWidth;
      z = nPositionFile.value[i][1]*imgHeight;
    }
    
    if (nDegreeFile.value[currentFrame][i] != 0 && iColorFile.value[currentFrame][i] != 0 && currentFrame < nDegreeFile.timeline) {  // && drawCluster[clusterColorFile.value[frameCurrent][i] - 1]) {
      stroke(clusterColor[(int)iColorFile.value[currentFrame][i]-1]);
      strokeWeight(scaleFactor*4);
      //strokeWeight(scaleFactor*(corMeanFile.value[currentFrame][i] - corMeanMin)*100);
      point(-imgWidth*scaleFactor*scale3D + x*2*scaleFactor*scale3D, nDegreeFile.value[currentFrame][i] * (-y), -imgHeight*scaleFactor*scale3D + z*2*scaleFactor*scale3D);
    }
  } // end - for
  
  // highlight selected nodes
  for (int j=0; j<count; j++) {
    stroke(clusterColor[7]);
    strokeWeight(scaleFactor*12);
    if (mouseBrain) {
      point(-imgWidth*scaleFactor*scale3D + (pixelID[j]%imgWidth)*2*scaleFactor*scale3D, nDegreeFile.value[currentFrame][pixelID[j]] * (-y), -imgHeight*scaleFactor*scale3D + (pixelID[j]/imgWidth)*2*scaleFactor*scale3D);
    } else {
      point(-imgWidth*scaleFactor*scale3D + nPositionFile.value[pixelID[j]][0]*imgWidth*2*scaleFactor*scale3D, nDegreeFile.value[currentFrame][pixelID[j]] * (-y), -imgHeight*scaleFactor*scale3D + nPositionFile.value[pixelID[j]][1]*imgWidth*2*scaleFactor*scale3D);
    }
  }
  
  stroke(225);
  strokeWeight(scaleFactor); 
  line(-imgWidth*scaleFactor*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D, -imgWidth*scaleFactor*scale3D+scaleFactor*40*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D);    // x
  line(-imgWidth*scaleFactor*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D, -imgWidth*scaleFactor*scale3D, -yMin*9*scale3D + scaleFactor*40*scale3D, -imgHeight*scaleFactor*scale3D);  // y
  line(-imgWidth*scaleFactor*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D, -imgWidth*scaleFactor*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D+scaleFactor*40*scale3D);    // z
  fill(225);
  textSize(10*scaleFactor*scale3D);
  textAlign(LEFT, CENTER);
  text(" + x", -imgWidth*scaleFactor*scale3D+scaleFactor*40*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D);
  textAlign(LEFT, CENTER);
  text(" + y", -imgWidth*scaleFactor*scale3D, -yMin*9*scale3D + scaleFactor*40*scale3D, -imgHeight*scaleFactor*scale3D);
  textAlign(CENTER, CENTER);
  text(" + z", -imgWidth*scaleFactor*scale3D, -yMin*9*scale3D, -imgHeight*scaleFactor*scale3D+scaleFactor*40*scale3D);
  
  translate(-xCenter, -yCenter, -zCenter);
  
}
