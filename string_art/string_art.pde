
PImage IMG;
int[][] IMGARRAY = new int[1024][1024];

int CURRENTNAIL = 800;
int ROWS = 32;
int COLS = 32;
int STEP = 32;
int HS = STEP/2;

int FIL = 260;
int MAX = 220;

void setup() {
  background(255);
  strokeWeight(0.25);
  stroke(0, 0, 0, 255);
  
  IMG = loadImage("images/img1.png");
  size(1024,1024);
  IMG.resize(1024,1024);
  for(int y=0; y<IMG.height; ++y) {
    for(int x=0; x<IMG.width; ++x) {
      int loc = x + y * IMG.width;
      IMGARRAY[x][y] = floor(red(IMG.pixels[loc]));
    }
  }

}


void draw() {
  int xST, yST, xND, yND, nextNAIL;
  float maxCOL; 
  
  for(int many =0; many<10; ++many) {
    xST = floor(CURRENTNAIL % ROWS) * STEP;
    yST = floor(CURRENTNAIL / COLS) * STEP;
    xND = 0;
    yND = 0;
    maxCOL = MAX;
    nextNAIL = CURRENTNAIL;
    
    for(int nail = 0; nail < (ROWS * COLS); ++nail) {
      if (nail == CURRENTNAIL) continue; 
      int xTMP = floor(nail % ROWS) * STEP;
      int yTMP = floor(nail / COLS) * STEP;
      float tmp = getCol(xST, yST, xTMP, yTMP);
      if (tmp < maxCOL) {
        maxCOL = tmp;
        nextNAIL = nail;
        xND = xTMP;
        yND = yTMP;
      }
    }
    if (nextNAIL != CURRENTNAIL) {
      line(xST+HS, yST+HS, xND+HS, yND+HS);
      setCol(xST, yST, xND, yND);
      CURRENTNAIL = nextNAIL;
    } else {
      println("Done");
      noLoop();
      break;
    }
  }  
    
}

float getCol(int x0, int y0, int x1, int y1) {
  int total = 0;
  int cnt = 0;
  int x, y;
  ArrayList<Integer> pixels = pixelLine(x0, y0, x1, y1);
  for (int i = 0; i < pixels.size(); i+=2) {
    x = pixels.get(i);
    y = pixels.get(i+1);
    total += IMGARRAY[x][y];
    cnt += 1;
  }
  return total / cnt;
}

void setCol(int x0, int y0, int x1, int y1) {
  int x, y;
  ArrayList<Integer> pixels = pixelLine(x0, y0, x1, y1);
  for (int i = 0; i < pixels.size(); i+=2) {
    x = pixels.get(i);
    y = pixels.get(i+1);
    IMGARRAY[x][y] = FIL;
  }
}


ArrayList<Integer> pixelLine(int x0, int y0, int x1, int y1) {
  int dx = abs(x1 - x0);
  int sx = x0 < x1 ? 1 : -1;
  int dy = -abs(y1 - y0);
  int sy = y0 < y1 ? 1 : -1;
  int error = dx + dy;
  int e2 = 0;
  
  ArrayList<Integer> pixels = new ArrayList<Integer>();

  while (true) {
    pixels.add(x0);
    pixels.add(y0);

    if (x0 == x1 && y0 == y1) {
      break;
    }
    
    e2 = 2 * error;
    if (e2 >= dy) {
      if (x0 == x1) {
        break;
      }
      error = error + dy;
      x0 = x0 + sx;
    }
    
    if (e2 <= dx) {
      if (y0 == y1) {
        break;
      }
      error = error + dx;
      y0 = y0 + sy;
    }
    
  }
  
  return pixels;
}
