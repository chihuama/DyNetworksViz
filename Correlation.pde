// calculate correlation value for two selected pixels

public int shiftFrame = 0;


float Correlation(int pixel0, int pixel1, int winSize, int shift) {
  
  int w = winSize - abs(shift);  // window size
  //int len = timeTotal - winSize + 1;   // shift every frame, totally len steps
  int len = 1;  // static correlation
  float corValue = 0;
  //println("window size: " + w);
  //println("length: " + len);
  
  // compute standard deviation
  float[] pixel0_s1 = new float[len];
  float[] pixel0_s2 = new float[len];
  float[] pixel0_sd = new float[len];
  float[] pixel1_s1 = new float[len];
  float[] pixel1_s2 = new float[len];  
  float[] pixel1_sd = new float[len];
  float[] sum_xy = new float[len];
  float[] cor = new float[len];
  
  for (int i=0; i<len; i++) {
    pixel0_s1[i] = 0;
    pixel0_s2[i] = 0;
    pixel1_s1[i] = 0;
    pixel1_s2[i] = 0;
    sum_xy[i] = 0;
    cor[i] = 0;
  }
  
  for (int i=0; i<len; i++) {  // shift every frame
    for (int j=frameStart; j<w+frameStart; j++) {
      if (shift >= 0) {    
      pixel0_s1[i] = pixel0_s1[i] + pValueFile.value[i+j+shift][pixel0];
      pixel0_s2[i] = pixel0_s2[i] + sq(pValueFile.value[i+j+shift][pixel0]);
      
      pixel1_s1[i] = pixel1_s1[i] + pValueFile.value[i+j][pixel1];
      pixel1_s2[i] = pixel1_s2[i] + sq(pValueFile.value[i+j][pixel1]);
      
      sum_xy[i] = sum_xy[i] + pValueFile.value[i+j+shift][pixel0]*pValueFile.value[i+j][pixel1];   
      } else {
        pixel0_s1[i] = pixel0_s1[i] + pValueFile.value[i+j][pixel0];
        pixel0_s2[i] = pixel0_s2[i] + sq(pValueFile.value[i+j][pixel0]);
      
        pixel1_s1[i] = pixel1_s1[i] + pValueFile.value[i+j-shift][pixel1];
        pixel1_s2[i] = pixel1_s2[i] + sq(pValueFile.value[i+j-shift][pixel1]);
      
        sum_xy[i] = sum_xy[i] + pValueFile.value[i+j][pixel0]*pValueFile.value[i+j-shift][pixel1]; 
      }   
    }
    
    pixel0_sd[i] = sqrt((pixel0_s2[i] - sq(pixel0_s1[i])/w)/(w-1));
    pixel1_sd[i] = sqrt((pixel1_s2[i] - sq(pixel1_s1[i])/w)/(w-1));
    
    if (pixel0_sd[i] != 0 || pixel1_sd[i] != 0) {
      cor[i] = (sum_xy[i] - pixel0_s1[i]*pixel1_s1[i]/w)/(w-1)/pixel0_sd[i]/pixel1_sd[i];
      //println("cor: " + cor[i]);
      corValue = cor[i];
    }     
  }
  
  return corValue;
}

// shift one pixel
/*void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      shiftFrame--;
    } else if (keyCode == RIGHT) {
      shiftFrame++;
    }
  }
  println("shift: " + shiftFrame);
}*/


// shift correlation
/*
public float[] corShift;
public int corShiftMaxIndex;

void ShiftCorrelation() {
  corShift = new float[200];
  for (int i=0; i<200; i++) {
    Correlation(pID, pID2, i-100);
    corShift[i] = corValue;
  }
  float corShiftMax = getMax(corShift, 200);
  corShiftMaxIndex = indexMax-100;
}
*/
