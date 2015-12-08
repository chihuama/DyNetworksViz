// read input files

class ReadFile {
  String inputFile;
  int timeline;
  int cols;
  float[][] value; 
  
  ReadFile(String fileName, int c) {
    inputFile = fileName;
    cols = c;
  }
  
  void load() {
    String[] rows = loadStrings(inputFile);
    timeline = rows.length;
    value = new float[timeline][cols];
    
    for (int i=0; i<timeline; i++) {
      String[] columns = split(rows[i], TAB);  // split the row on the tabs
      for (int j=0; j<cols; j++) {
        value[i][j] =  Float.parseFloat(columns[j]);
      }
    }
  } // end - load()
  
  void load2() {
    String[] rows = loadStrings(inputFile);
    timeline = rows.length;
    value = new float[timeline][cols];
    
    for (int i=0; i<timeline; i++) {
      String[] columns = split(rows[i], ',');  // split the row on the qoutes
      for (int j=0; j<cols; j++) {
        value[i][j] =  Float.parseFloat(columns[j]);
      }
    }
  } // end - load()
} // end - class

/**************************************************************************/

public int indexMin = 0, indexMax = 0;

float getMax(float[] value, int num) {
  float m = -Float.MAX_VALUE;
  for (int i=0; i<num; i++) {
    if (value[i] > m) {
      m = value[i];
      indexMax = i;
    }
  }
  return m;
}

float getMin(float[] value, int num) {
  float m = Float.MAX_VALUE;
  for (int i=0; i<num; i++) {
    if (value[i] < m) {
      m = value[i];
      indexMin = i;
    }
  }
  return m;
}


float getMax2(float[][] value, int row, int col) {
  float m = -Float.MAX_VALUE;
  for (int i=0; i<row; i++) {
    for (int j=0; j<col; j++) {
      if (value[i][j] > m) {
        m = value[i][j];
      }
    }    
  }
  return m;
}

float getMin2(float[][] value, int row, int col) {
  float m = Float.MAX_VALUE;
  for (int i=0; i<row; i++) {
    for (int j=0; j<col; j++) {
      if (value[i][j] < m) {
        m = value[i][j];
      }
    }    
  }
  return m;
}
