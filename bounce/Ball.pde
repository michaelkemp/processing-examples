class Ball {

  float x, y, r, dx, dy;
  int col;

  Ball(float _dx, float _dy, float _r, int _col) {
    dx = _dx;
    dy = _dy;
    r = _r;
    col = _col;
    x = random(_r, width - _r);
    y = random(_r, height - _r);
  }
  
  void update() {
    x = x+dx;
    y = y+dy;
    if ((x < 0 + r)||(x > width - r)) dx = -dx;
    if ((y < 0 + r)||(y > height - r)) dy = -dy;
    
  }
  
  void show() {
    noStroke();
    fill(col);
    circle(x, y, r*2);
  }
}
