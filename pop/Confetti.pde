class Confetti {

  float x, y, dx, dy, t, dt;
  int col;
  boolean show = true;

  Confetti(float _x, float _y) {
    x = _x;
    y = _y;
    t = 0;
    dt = random(-1, 1);
    dx = random(-10, 10);
    dy = random(-10, 10);
    col = color(floor(random(255)), floor(random(255)), floor(random(255)));
  }

  void update() {
    x += dx;
    y += dy;
    t += dt;
    // gravity
    dy += 0.25;

    // don't show if off the bottom of the screen
    if (y > height) {
      show = false;
    }
  }

  void show() {
    if (show) {
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
}
