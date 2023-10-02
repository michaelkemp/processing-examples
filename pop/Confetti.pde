class Confetti {

  float x, y, t, dx, dy, dt;
  int col;
  boolean show;

  Confetti() {
    x = 0;
    y = 0;
    t = 0;
    dt = 0;
    dx = 0;
    dy = 0;
    show = false;
    col = color(floor(random(255)), floor(random(255)), floor(random(255)));
  }

  boolean getShow() {
    return show;
  }

  void reset(float _x, float _y) {
    x = _x;
    y = _y;
    t = 0;
    dt = random(-1, 1);
    dx = random(-10, 10);
    dy = random(-10, 10);
    show = true;
  }

  void update() {
    x += dx;
    y += dy;
    t += dt;
    // gravity
    dy += 0.25;
    // don't show if off the bottom of the screen
    if ((y > height) || (x < 0) || (x > width)) {
      show = false;
    }
  }

  void show() {
    rectMode(CENTER);
    noStroke();
    fill(col);

    pushMatrix();
    translate(x, y);
    rotate(t);
    square(0, 0, 10);
    popMatrix();
  }
}
