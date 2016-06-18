class VisualizationTwo implements Visualization
{

  int currentColumn = 0;
  FloatTable tab;
  Float minRate;
  Float maxRate;
  String[] quarters;
  String startingQuart;
  String endingQuart;
  PFont plotFont;
  int rowCount;
  int topLeftX;
  int bottomRightX;
  int topLeftY;
  int bottomRightY;
  Float scl=1.0F;


  VisualizationTwo() 
  {
    topLeftX = 120;
    bottomRightX = width - 80;
    topLeftY = 60;
    bottomRightY = height - 70;

    //println("VisualizationTwo - Constructor");
    tab = new FloatTable("france.tsv");
    rowCount = tab.rowCount;
    minRate = tab.getColumnMin(0);
    maxRate = tab.getColumnMax(0);
    //println("Min Rate=" + maxRate);
    // println(maxYear = tab.getColumnMax(1));
    quarters = tab.getRowNames();
    startingQuart = quarters[0];
    endingQuart = quarters[quarters.length - 1];
    plotFont = createFont("SansSerif", 20);
    textFont(plotFont);
    smooth();
  }
  
  
  
  
  public void draw() {
    
   // println("Second Visualization");
    setSubTitle("Japan");

    background(224);
    // Show the plot area as a white box.
    fill(255);
    rectMode(CORNERS);
    noStroke();
    rect(topLeftX, topLeftY, bottomRightX, bottomRightY);
    // Draw the title of the current plot.
    fill(0);
    textSize(20);
    String title = "Unmployment Rate in Japan";
    setTitle(title, 275.0, 50.0);
    stroke(50, 121, 193);
    strokeWeight(5);
scale(scl);
println("Scale:"+scl);
    drawDataPoints(0);
    drawYearLabels();
    drawVolumeLabels();
    drawAxisLabels();
    drawDataHighlight(0);
  }

  void drawDataHighlight(int col) {
    for (int row = 0; row < rowCount; row++) {
      if (tab.isValid(row, col)) {
        float value = tab.getFloat(row, col);
        float x = map(row, 0, tab.rowNames.length - 1, this.topLeftX, this.bottomRightX);
        float y = map(value, minRate, maxRate, this.bottomRightY, this.topLeftY);
        if (dist(mouseX, mouseY, x, y) < 5) {
          strokeWeight(10);
          point(x, y);
          fill(0);
          textSize(10);
          textAlign(CENTER);
          text(nf(value, 0, 2) + " (" + this.quarters[row] + ")", x, y - 8);
          
            stroke(239,21,16);
            strokeWeight(1);
           line(x, y, topLeftX, y );
           line(x, y, x, bottomRightY );
          
        }
      }
    }
  }

  // Draw the data as a series of points.
  void drawDataPoints(int col) {
    int rowCount = tab.getRowCount();
    for (int row = 0; row < rowCount; row++) {
      if (tab.isValid(row, col)) {
        float value = tab.getFloat(row, col);
        float x = map(row, 0, tab.rowNames.length - 1, topLeftX, bottomRightX);
        float y = map(value, minRate, maxRate, bottomRightY, topLeftY);
       //println(x);
       // println(y);
        point(x, y);
        // text('x', x,y);
      }
    }
  }

  void drawYearLabels() {
    int yearInterval = 4;
    fill(0);
    textSize(10);
    textAlign(CENTER, TOP);
    // Use thin, gray lines to draw the grid.
    stroke(224);
    strokeWeight(1);
    for (int row = 0; row < rowCount; row++) {
      if (row % yearInterval == 0) {
        float x = map(row, 0, rowCount, topLeftX, bottomRightX);

        text(quarters[row], x, bottomRightY + 10);
        line(x, topLeftY, x, bottomRightY);
      }
    }
  }

  void drawVolumeLabels() {
    Float volumeIntervalMinor = .2F;

    fill(0);
    textSize(10);
    int count = 0;

    stroke(128);
    strokeWeight(1);
    for (float v = minRate; v <= maxRate; v += volumeIntervalMinor) {
      ++count;

      float y = map(v, minRate, maxRate, bottomRightY, topLeftY);
      if (count % 2 == 0) { // If a major tick mark
        if (v == minRate) {
          textAlign(RIGHT); // Align by the bottom
        } else if (v == maxRate) {
          textAlign(RIGHT, TOP); // Align by the top
        } else {
          textAlign(RIGHT, CENTER); // Center vertically
        }
        text(nf(v, 0, 0), topLeftX - 10, y);
        line(topLeftX - 4, y, topLeftX, y); // Draw major tick
      } else {
        line(topLeftX - 2, y, topLeftX, y); // Draw minor tick
      }
      // }
    }
  }

  void drawAxisLabels() {
    int labelX = 50;
    int labelY = height - 25;
    fill(0);
    textSize(10);
    textLeading(15);
    textAlign(CENTER, CENTER);
    // Use \n (aka enter or linefeed) to break the text into separate
    // lines.
    text("Unemployment\nRate\n", labelX, (topLeftY + bottomRightY) / 2);
    textAlign(CENTER);
    text("Year", (topLeftX + bottomRightX) / 2, labelY);
  }


    public void mouseMoved() {
    this.draw();
  }

  public void keyReleased() {
   // println("Key=" + key);
  //  println("KeyCode=" + keyCode);
    if (39 == keyCode) {
      currentColumn = (currentColumn + 1) % tab.columnCount;
    } else if (37 == keyCode) {
      currentColumn = (currentColumn == 0 ? (tab.columnCount - 1) : currentColumn - 1) % tab.columnCount;
    }
    this.draw();
  }
  
  public void mouseWheel(MouseEvent event) {
  //float e = event.getCount();
  //println("Mouse Wheel:"+e+"|Scroll value:"+scl);
  //if (-1==e)
  //{
  //  scl=scl-.01;
  //}
  //else
  //{
  //  scl=scl+.01;
  //}
    
 
  //this.draw();
  
}
  
  
}