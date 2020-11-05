int scl = 1;
int cols;
int rows;
PImage heightmap;
float[][] terrain;


void setup(){
  size(1000,1000, P3D);
  cols = height/scl;
  rows = width/scl;
  terrain = new float[rows][cols];
  heightmap = loadImage("Heightmap.png");
  heightmap.resize(width,height);
  heightmap.filter(GRAY);
}

int index(int x, int y){
  return x + y * heightmap.width;
}

void draw(){
  lights();
  background(255);
  //stroke(0);
  noStroke();
  fill(150);
  
for(int y = 0; y < cols; y++){
  beginShape(TRIANGLE_STRIP);
  for(int x = 0; x < rows; x++){
    color pix = heightmap.pixels[index(x*scl,y*scl)];
    float oldG = red(pix);
    terrain[x][y] = map(oldG, 0, 255, -50, 50);
  }
}
  
translate(width/2, height/2);
rotateX(PI/4);
translate(-width/2, -height/2);
translate(0, -200);
  
for(int y = 0; y < cols-1; y++){
  beginShape(TRIANGLE_STRIP);
  for(int x = 0; x < rows; x++){
    vertex(x*scl, y*scl, terrain[x][y]);
    vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
  }
  endShape();
}
}
