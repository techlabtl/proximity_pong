
class Paddle {

  float x;
  float y;
  int   width;
  int   height;

  Paddle(float x, float y, int w, int h) {
    this.x = x;
    this.y = (y-h/2);
    this.width = w;
    this.height = h;
  }

  /**
   *  These methods check if the puck collides with the passed argument.
   *
   *  The x/y vars must be the x/y of an object that can collide with the puck.
   */
  boolean collide_bottom(float y) {
    return (this.y + this.height) >= y;
  }
  // boolean collide_left(float x) {
  //   return (this.x) <= x;
  // }
  // boolean collide_right(float x) {
  //   return (this.x + this.width) >= x;
  // }
  boolean collide_top(float y) {
    return (this.y) <= y;
  }

  void draw() {
    fill(255, 255, 255, 255);
    rect(this.x, this.y, this.width, this.height);
  }

  void move(float y) {
    this.y = y;
  }
}
