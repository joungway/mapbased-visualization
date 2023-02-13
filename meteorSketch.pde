// LIBRARIES
import processing.pdf.*;

//GLOBAL VARIABLES
PShape baseMap;
String csv[];
String myData[][];// 2D array
PFont f;


// SETUP
void setup() {
  size(1800, 900);
  noLoop();
  f = createFont("Roboto", 12);
  baseMap = loadShape("WorldMap.svg"); // create a shape that's filled with the baseMap 
  csv = loadStrings("MeteorStrikes.csv"); // bring in data from a text file
  myData = new String[csv.length][6]; // setup the size to fit in the data
  for(int i=0; i<csv.length; i++){
    myData[i] = csv[i].split(",");
  }
  println(myData[23][4]);
}


// DRAW
void draw() {
  beginRecord(PDF, "meteorStrikes.pdf");
  
  shape(baseMap, 0, 0, width, height);
  noStroke();
  fill(255, 0, 0, 30);
  //rect(100, 100, 200, 100);
  
  
  // cycle through all the values for latitude and longitude in CSV
  for(int i=0; i<myData.length; i++) {
    fill(200, 100, 50, 50);
    noStroke();
    float graphLong = map(float(myData[i][3]), -180, 180, 0, width);
    float graphLat = map(float(myData[i][4]), -90, 90, 0, height);
    float markerSize = 0.05 * sqrt(float(myData[i][2]))/PI;
    //println(graphLong + " / " + graphLat);
    ellipse(graphLong, graphLat, markerSize, markerSize);
    
    if(i<10){
      fill(0, 90);
      textFont(f);
      text(myData[i][0], graphLong+markerSize+5, graphLat+4);
      noFill();
      stroke(0, 90);
      line(graphLong+markerSize/2, graphLat, graphLong+markerSize, graphLat);
    }
  }
  endRecord();
  println("PDF Ssaved.");
}
