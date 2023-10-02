
int COUNT = 500;
int LOAD = 50;
Confetti[] poppers = new Confetti[COUNT];

void setup() {
  //frameRate(30);
  size(1920, 1080);
  for (int i=0; i<COUNT; ++i) {
    poppers[i] = new Confetti();
  }
}

void mousePressed() {
  int live = 0;
  for (int i=0; i<COUNT; ++i) {
    if (!poppers[i].getShow()) {
      poppers[i].reset(mouseX, mouseY);
      live++;
    }
    if (live > LOAD) {
      break;
    }
  }
}

void draw() {
  background(0);
  for (Confetti p : poppers) {
    if (p.getShow()) {
      p.update();
      p.show();
    }
  }
}
