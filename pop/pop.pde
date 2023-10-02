
int COUNT = 100;

boolean party = false;

Confetti[] poppers = new Confetti[COUNT];

void setup() {
  //frameRate(30);
  size(1024, 768);
}

void mousePressed() {
  for (int i=0; i<COUNT; ++i) {
    poppers[i] = new Confetti(mouseX, mouseY);
  }

  party = true;
}

void draw() {


  background(255);
  if (party) {
    for (Confetti p : poppers) {
      p.update();
      p.show();
    }
  }
}
