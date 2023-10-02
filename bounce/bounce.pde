
int COUNT = 50;

Ball[] bouncies = new Ball[COUNT];

void setup() {
  size(1024, 768);
  for (int i=0; i<COUNT; ++i) {
    int xNeg = random(0,1) < 0.5 ? -1: 1;
    int yNeg = random(0,1) < 0.5 ? -1: 1;
    int r = floor(random(255));
    int g = floor(random(255));
    int b = floor(random(255));
    
    bouncies[i] = new Ball(random(3,7)*xNeg, random(3,7)*yNeg, random(30,70), color(r, g, b, 150));
  }
}

void draw() {
  background(255);
  for(Ball b: bouncies) {
    b.update();
    b.show();
  }
}
