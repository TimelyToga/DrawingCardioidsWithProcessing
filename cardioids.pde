import java.util.ArrayList;

class Point {
  float x;
  float y;
  
  public Point(float x, float y){
    this.x = x;
    this.y = y;
  }
}

float circleX = 0;
float circleY = 0; 

int xSize = 640;
int ySize = 480;

int xCenter = xSize / 2;
int yCenter = ySize / 2;

ArrayList<Point> points;

float size = 150;
float gridSize = size / 2; // radius of our circles
float t = 0;

void setup(){
  size(640, 480); 
  background(255);
  smooth();
  
  circleX = float(xSize / 2);
  circleY = float(ySize / 2);
  
  points = new ArrayList();
}

void draw(){
  background(255);
  
  
  // Draw axes
  stroke(190);
  strokeWeight(2);
  line(0, ySize / 2, xSize, ySize / 2);
  line(xSize / 2, 0, xSize / 2, ySize);
  
  
  // Draw grid
  stroke(230);
  strokeWeight(1);
  
  int curXLine = 1;
  while(curXLine * gridSize <= xSize){
    float xDelta = curXLine * gridSize;
    line(xCenter + xDelta, 0, xCenter + xDelta, ySize);
    line(xCenter - xDelta, 0, xCenter - xDelta, ySize);
    
    curXLine++;
  }
  
  int yL = 1;
  while(yL * gridSize <= ySize){
    float yD = yL * gridSize;
    line(0, yCenter + yD, xSize, yCenter + yD);
    line(0, yCenter - yD, xSize, yCenter - yD);
    
    yL++;
  }
  
  
  // Calculate cur position of rotating circle
  float xOffset = size * cos(t);
  float yOffset = size * sin(t);
  
  float x = circleX + xOffset;
  float y = circleY + yOffset;


  // Draw center circle
  stroke(18, 185, 204);
  strokeWeight(3);
  noFill();
  ellipse(circleX, circleY, size - 3, size - 3);
  
  
  // Draw rotating circle
  noStroke();
  fill(232, 152, 118);
  ellipse(x, y, size, size);
  
  
  // Add a new drawing point
  float dx = x - (size / 2.0) * cos(2*t);
  float dy = y - (size / 2.0) * sin(2*t);
  points.add(new Point(dx, dy));
  
  
  //Draw rotation line
  strokeWeight(3);
  stroke(252, 222, 168);
  line(x, y, dx, dy);


  // Draw our cardioid
  stroke(214, 79, 21);
  strokeWeight(3);
  noFill();
  beginShape();
  for(Point p: points){
    curveVertex(p.x, p.y);
  }
  endShape();
  
  // Timestep
  t += 0.03;
  if(t >= 2 * 3.14159) {
    t = 0;
    
    // If we have rotated once, stop animating
    noLoop();
  }
  
  // Save our frames as 0001.png, 0002.png, etc.
  saveFrame("/Users/Tim/prog/tfiarp_files/blog_entries/001_cardiodid_16-12-2016/pics/####.png");
}