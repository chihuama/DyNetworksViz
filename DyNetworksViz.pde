//

import javax.swing.*; 

final JFileChooser fc = new JFileChooser();  // create file chooser
public File file; 

Button buttonOpen;
Button buttonReOpen;
public String path;
public String dataSet;
public int halfWinSize;
public float loadingPercent;
public boolean errorInfo = false;
public boolean getFilesPath = false;
public boolean doneLoading = false;
public boolean firstOpen = true;

/*
import processing.net.*;
import omicronAPI.*;

OmicronAPI omicronManager;
*/

public int imgWidth = 172;
public int imgHeight = 130;
public int pixel = 130*172;

public int scaleFactor = 1;
public int gap = 20;



PImage img;
ReadFile pValueFile;
ReadFile nDegreeFile;
ReadFile corMeanFile;
ReadFile iColorFile;
ReadFile gColorFile;
ReadFile iSizeFile;
ReadFile gSizeFile;
ReadFile nPositionFile;

public float pValueMin;
public float pValueMax;
public float nDegreeMin;
public float nDegreeMax;
public float corMeanMin;
public float corMeanMax;


Leaf[] leaf;
public int[] pixelID;
public float[] leafX;
public float[] leafY;
public boolean[] active;
public float leafW, leafH;
public int count;
public int maxView;


TimeSlider timeSlider;
public int currentFrame;
public boolean[] drawBox;


CheckBox checkBoxDataInfo;
CheckBox checkBoxLinks;
CheckBox checkBoxLabels;
CheckBox checkBox3dView;
public boolean drawDataInfo;
public boolean drawLinks;
public boolean drawLabels;
public boolean draw3dView;

Button buttonXneg;
Button buttonXpos;
Button buttonYneg;
Button buttonYpos;
Button buttonZneg;
Button buttonZpos;
Button buttonPlay;
Button buttonPause;
/***************************************/


/*
// Override of PApplet init() which is called before setup()
public void init() {
  super.init();  
  // Creates the OmicronAPI object. This is placed in init() since we want to use fullscreen
  omicronManager = new OmicronAPI(this);  
  // Removes the title bar for full screen mode (present mode will not work on Cyber-commons wall)
  if (scaleFactor == 6) {
    omicronManager.setFullscreen(true);
  }
}
*/


void LoadData() {
  // The thread is not completed
  doneLoading = false;
  
  LoadingFiles();
  Init();
  
  // The thread is completed!
  doneLoading = true;
}


void setup() {
  size(1360*scaleFactor, 768*scaleFactor, P3D);
  
  /*if (frame != null) {
    frame.setResizable(true);
  }*/
    
  if (getFilesPath) {
    thread("LoadData");
  } else { // the opening view for opening files
    dataSet = "";
  }
}


void draw() {
  background(245);
  
  // For event and fullscreen processing, this must be called in draw()
  //omicronManager.process();
  
  if (getFilesPath && doneLoading) {
    
  ControlView();
  
  // individual models
  for (int i=0; i<count && pixelID[i]>=0; i++) {
    leaf[i] = new Leaf(pValueFile.value, pValueFile.timeline, nDegreeFile.value, corMeanFile.value, nDegreeFile.timeline, i, pixelColor[i], leafX[i], leafW, leafY[i], leafH);
    leaf[i].draw();
  }
  
  // correlation links
  for (int i=0; i<count && drawLinks; i++) {
    for (int j=i+1; j<count; j++) { 
      float corValue = Correlation(pixelID[i], pixelID[j], frameEnd-frameStart, shiftFrame);            
      if (corValue != 0) {
        if (corValue > 0) {
          stroke(clusterColor[0], 180);
        } else {
          stroke(clusterColor[1], 180);
        }
        strokeWeight(abs(corValue)*10*scaleFactor);
        line(leafX[i], leafY[i], -1, leafX[j], leafY[j], -1);
        fill(clusterColor[2]);
        textSize(15*scaleFactor);
        //textAlign(CENTER, CENTER);
        //text(nfc(corValue, 3), (leafX[i]+leafX[j])/2, (leafY[i]+leafY[j])/2);
        textAlign(LEFT, TOP);
        text(nfc(corValue, 3), (leafX[i]+leafX[j])/2 + scaleFactor*2, (leafY[i]+leafY[j])/2 + scaleFactor*2);
      }
    }
  }
         
  // 3D view
  if (draw3dView) {
    SpatialView();
  }
  
  save("pic.tiff");
  
  } else {  // opening view for loading files
  
    fill(20);
    textSize(28*scaleFactor);
    textAlign(RIGHT, TOP);
    text("Data Set", width*3/8, height/2);
    
    // draw the rects for displaying the path of files
    noFill();
    stroke(20);
    strokeWeight(scaleFactor);
    rect(width*3/8 + 5*scaleFactor, height/2, width/4, 32*scaleFactor);
    
    // draw the file path
    fill(40);
    textSize(16*scaleFactor);
    textAlign(LEFT, CENTER);
    text(dataSet, width*3/8 + 10*scaleFactor, height/2 + 16*scaleFactor);
    
    // open button
    if (firstOpen) {
      buttonOpen = new Button(width*5/8 + 15*scaleFactor, height/2, 60*scaleFactor, 32*scaleFactor, "Open", 22*scaleFactor);
      buttonOpen.draw();
    }
      
    if (getFilesPath && !doneLoading) {
      drawProgressBar(width*3/8 + 5*scaleFactor, width/4, height/2 + gap*scaleFactor*8, gap*scaleFactor, loadingPercent);
    }
    
  } // end - if else

}


void drawProgressBar(float x, float w, float y, float h, float percent) {
  
  noFill();
  stroke(40, 120);
  strokeWeight(scaleFactor);  
  rect(x, y, w, h);
  
  noStroke();
  fill(40, 120);  
  float w2 = map(percent, 0, 1, 0, w);
  rect(x, y, w2, h);
  
  String text;     
  if (errorInfo) {
    fill(color(186, 40, 53));
    text = "Error!";
  } else {
    fill(40);
    text = "Loading...";
  }
  textSize(16*scaleFactor);
  textAlign(CENTER, TOP);
  text(text, x + w/2, y + h*2);
}

/*****************************************************************************************/

// open files through a GUI
File OpenFile(JFileChooser Jfc) {
        
  File file = null;
 
  // set system look and feel
  try { 
    //UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName()); 
    // in response to a button click: 
    int returnVal = fc.showOpenDialog(this);   
    if (returnVal == JFileChooser.APPROVE_OPTION) { 
      file = fc.getSelectedFile();    
    }
  } catch (Exception e) { 
    e.printStackTrace();  
  }
  return file; //.getPath();  
}
