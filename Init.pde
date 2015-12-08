// Initialization

void Init() {
  
  count = 0;
  maxView = 10;
  
  InitColor();
  
  drawDataInfo = false;
  drawLinks = true;
  drawLabels = false;
  draw3dView = false;
  
  currentFrame = 0;
  timeSlider = new TimeSlider(gap*scaleFactor*2 + textWidth("New Data") + gap*scaleFactor, width - gap*scaleFactor*3 - imgWidth*scaleFactor, height - gap*scaleFactor - imgHeight*scaleFactor, height - imgHeight*scaleFactor);
  
  // highlight detail information for current frame
  drawBox = new boolean[timeTotal];
  for (int i=0; i<timeTotal; i++) {
    drawBox[i] = false;
  }
  
  // initialization
  leaf = new Leaf[maxView];
  pixelID = new int[maxView];
  leafX = new float[maxView];
  leafY = new float[maxView];
  active = new boolean[maxView];  
  for (int i=0; i<maxView; i++) {
    pixelID[i] = -1;
    leafX[i] = gap*scaleFactor*4 + gap*scaleFactor*i;
    leafY[i] = (height - imgHeight*scaleFactor)/4 + gap*scaleFactor*i;
    active[i] = false;
  }
  leafW = width - gap*scaleFactor*9;
  leafH = gap*scaleFactor*2;  // height of the trunk
  
  
  xCenter = width - gap*scaleFactor - imgWidth*scaleFactor*35/12;
  yCenter = height - gap*scaleFactor*2 - imgHeight*scaleFactor*7/3;
  
}
