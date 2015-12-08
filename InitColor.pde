// initialize top 10 colors

public int top = 10;
public color[] clusterColor;
public color[] pixelColor;

void InitColor() {
  clusterColor = new color[top];
  clusterColor[0] = color(213, 26, 33);
  clusterColor[1] = color(6, 128, 67);
  clusterColor[2] = color(0, 49, 79);
  clusterColor[3] = color(90, 13, 67);
  clusterColor[4] = color(220, 87, 18);
  clusterColor[5] = color(100, 107, 48);
  clusterColor[6] = color(69, 137, 148);
  clusterColor[7] = color(244, 208, 0);
  clusterColor[8] = color(205, 164, 158);
  clusterColor[9] = color(107, 194, 53);
  
  // identify pixel
  pixelColor = new color[maxView];
  pixelColor[0] = color(186, 40, 53);
  pixelColor[1] = color(64, 116, 52);
  pixelColor[2] = color(3, 101, 100); 
  pixelColor[3] = color(175, 18, 88);  
  pixelColor[4] = color(29, 131, 8);  
  pixelColor[5] = color(84, 115, 135);  
  pixelColor[6] = color(217, 104, 49);
  pixelColor[7] = color(179, 214, 110);  
  pixelColor[8] = color(224, 160, 158);
  pixelColor[9] = color(180, 141, 1);
}
