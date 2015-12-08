// loading files once getting the path

public boolean mouseBrain = true;

void LoadingFiles() {
  
  loadingPercent = 0;
  errorInfo = false;
  
  // path seperator '/' (lastIndexOf)
  String pathDelimiter = File.separator;
  
  String[] listPath = splitTokens(path, pathDelimiter);  
  dataSet = listPath[listPath.length-3] + pathDelimiter + listPath[listPath.length-2];  
  println("dataSet: " + dataSet);
  
  if (dataSet.indexOf("Callosum") != -1) {
    imgWidth = 172;
    imgHeight = 130;
    pixel = 130*172;
    mouseBrain = true;
  } else if (dataSet.indexOf("Zebrafish") != -1) {
    imgWidth = 130;
    imgHeight = 130;
    pixel = 1000;
    mouseBrain = false;
  }
  
    
  String path2 = path.substring(0, path.lastIndexOf(pathDelimiter));
  path = path2 + pathDelimiter;   
  File dir = new File(path);        // get the directory
  String[] files = dir.list();      // list all the files
  println("path: " + path);
  println("files: " + files.length);
  if (files == null) {
    println("Folder does not exist or cannot be accessed.");
  } else {
    for (int i=0; i<files.length; i++) {
      println("file: " + files[i]);
      if (files[i].indexOf("nodeDegree") != -1) {
        nDegreeFile = new ReadFile(path+files[i], pixel);
        nDegreeFile.load();
        loadingPercent += 0.2;
      } else if (files[i].indexOf("nodeCorMean") != -1) {
        corMeanFile = new ReadFile(path+files[i], pixel);
        corMeanFile.load();
        loadingPercent += 0.2;
      } else if (files[i].indexOf("icolor_nodeClusterColor") != -1) {
        iColorFile = new ReadFile(path+files[i], pixel);
        iColorFile.load();
        loadingPercent += 0.2;
      } else if (files[i].indexOf("gcolor_nodeClusterColor") != -1) {
        gColorFile = new ReadFile(path+files[i], pixel);
        gColorFile.load();
        loadingPercent += 0.2;
      }
    }
  } // end - if else
   
  path2 = path2.substring(0, path2.lastIndexOf(pathDelimiter)) + pathDelimiter;  
  File dir2 = new File(path2);        // get the directory
  String[] files2 = dir2.list();      // list all the files
  println("path2: " + path2);
  println("files2: " + files2.length);
  for (int i=0; i<files2.length; i++) {
    if (files2[i].indexOf(".jpg") != -1) {
      img = loadImage(path2+files2[i]); 
    } else if (files2[i].indexOf("pixelsGreyValue") != -1) {
      pValueFile = new ReadFile(path2+files2[i], pixel);
      pValueFile.load();
      loadingPercent += 0.2;
    } else if (files2[i].indexOf("networkPositions") != -1) {
      nPositionFile = new ReadFile(path2+files2[i], 2);
      nPositionFile.load2();
    }
  }

  // error
  if (loadingPercent < 1) {
    println("Error!");
    errorInfo = true;
    
    file = OpenFile(fc);  // open file
    if (file != null) {
      path = file.getPath();  // get the path
      setup();  // initialize all the objects and variables for drawing the graph
    }      
  } 
  
  timeTotal = pValueFile.timeline;
  frameEnd = timeTotal;
  
  
  // min & max values
  pValueMin = getMin2(pValueFile.value, pValueFile.timeline, pixel);
  pValueMax = getMax2(pValueFile.value, pValueFile.timeline, pixel);
  nDegreeMin = getMin2(nDegreeFile.value, nDegreeFile.timeline, pixel);
  nDegreeMax = getMax2(nDegreeFile.value, nDegreeFile.timeline, pixel);
  float[][] corMeanArrayMin = new float[corMeanFile.timeline][pixel];  // remove 0
  for (int i=0; i<corMeanFile.timeline; i++) {
    for(int j=0; j<pixel; j++) {
      if (corMeanFile.value[i][j] == 0) {
        corMeanArrayMin[i][j] = 1;
      } else {
        corMeanArrayMin[i][j] = corMeanFile.value[i][j];
      }
    }
  }
  corMeanMin = getMin2(corMeanArrayMin, corMeanFile.timeline, pixel);
  corMeanMax = getMax2(corMeanFile.value, corMeanFile.timeline, pixel);
  
  println("pValueMin " + pValueMin);
  println("pValueMax " + pValueMax);
  println("nDegreeMin " + nDegreeMin);
  println("nDegreeMax " + nDegreeMax);
  println("corMeanMin " + corMeanMin);
  println("corMeanMax " + corMeanMax);
  
  String wSize = listPath[listPath.length-2].substring(1);
  halfWinSize = Integer.parseInt(wSize)/2;
  println("halfWinSize: " + halfWinSize);
  
}
