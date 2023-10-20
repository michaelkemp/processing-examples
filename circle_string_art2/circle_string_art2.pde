
PImage IMG;

int NAILS = 720;
int CURRENTNAIL = 0;
int RADius;
float RADians;

int[][] IMGARRAY = new int[1024][1024];

int FIL = 300;
int MAX = 255;

void setup() {
  background(255);
  strokeWeight(0.3);
  stroke(0, 0, 0, 255);
  size(1024, 1024);

  int grey;
  RADius = floor(width/2) - 10;
  RADians = TWO_PI / NAILS;

  // Load and Resize Image
  IMG = loadImage("images/img3.png");
  IMG.resize(width, height);
  for(int y=0; y<IMG.height; ++y) {
    for(int x=0; x<IMG.width; ++x) {
      int loc = x + y * IMG.width;
      grey = floor(red(IMG.pixels[loc]));
      IMGARRAY[x][y] = grey;
    }
  }
}


void draw() {
  float angleStart = RADians * CURRENTNAIL;
  int xST = round(RADius * cos(angleStart) + width / 2);
  int yST = round(RADius * sin(angleStart) + height / 2);
  int xND = 0;
  int yND = 0;
  int nextNAIL = CURRENTNAIL;
  float maxCOL = MAX;
  float tmpCOL = 0;
  
  for (int nail = 0; nail < NAILS; ++nail) {
    if (nail == CURRENTNAIL) continue;
    float angND = RADians * nail;
    int tmpX = round(RADius * cos(angND) + width / 2);
    int tmpY = round(RADius * sin(angND) + height / 2);
    tmpCOL = getCol(xST, yST, tmpX, tmpY);
    if (tmpCOL < maxCOL) {
      maxCOL = tmpCOL;
      nextNAIL = nail;
      xND = tmpX;
      yND = tmpY;
    }
  }
  if (nextNAIL != CURRENTNAIL) {
    setCol(xST, yST, xND, yND);
    line(xST, yST, xND, yND);
    CURRENTNAIL = nextNAIL;
  } else {
    println("Done");
    noLoop();
    //save("string-img1.png");
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
    //total += IMGARRAY[x][y];
    total += (0.4 * IMGARRAY[x][y]) +
    (0.075 * IMGARRAY[x+1][y]) +
    (0.075 * IMGARRAY[x-1][y]) +
    (0.075 * IMGARRAY[x][y+1]) +
    (0.075 * IMGARRAY[x][y-1]) +
    (0.075 * IMGARRAY[x+1][y+1]) +
    (0.075 * IMGARRAY[x+1][y-1]) +
    (0.075 * IMGARRAY[x-1][y+1]) +
    (0.075 * IMGARRAY[x-1][y-1]);
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
    IMGARRAY[x+1][y] *= 1.01;
    IMGARRAY[x-1][y] *= 1.01;
    IMGARRAY[x][y+1] *= 1.01;
    IMGARRAY[x][y-1] *= 1.01;
    IMGARRAY[x+1][y+1] *= 1.01;
    IMGARRAY[x+1][y-1] *= 1.01;
    IMGARRAY[x-1][y+1] *= 1.01;
    IMGARRAY[x-1][y-1] *= 1.01;
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
