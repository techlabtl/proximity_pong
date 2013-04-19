class Puck {
  float x;
  float y;
  int   width;
  int   height;
  int   radius;
  int   speed;

  Puck(float x, float y, int r, int s) {
    this.x = x;
    this.y = y;
    this.width = 2*r;
    this.height = 2*r;
    this.radius = r;
    this.speed = s;
  } 

  /**
   *  These methods check if the puck collides with the passed argument.
   *
   *  The x/y vars must be the x/y of an object that can collide with the puck.
   */
  boolean collide_bottom(float y) {
    return (this.y + this.radius) >= y;
  }
  boolean collide_left(float x) {
    return (this.x - this.radius) <= x;
  }
  boolean collide_right(float x) {
    return (this.x + this.radius) >= x;
  }
  boolean collide_top(float y) {
    return (this.y - this.radius) <= y;
  }

  boolean collide_with_paddle(Paddle paddle) {
    return collide_right(paddle.x) && 
           collide_left(paddle.x + paddle.width) && 
           collide_bottom(paddle.y) && 
           collide_top(paddle.y + paddle.height);
  }

  void draw() {
    fill(255, 255, 255, 255);
    ellipse(this.x, this.y, this.width, this.height);
  }

  void move(float x, float y) {
    this.x += x * this.speed;
    this.y += y * this.speed;
  }
}
