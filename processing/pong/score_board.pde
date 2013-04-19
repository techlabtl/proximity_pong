
class ScoreBoard {
  int left;
  int right;
  PFont font;

  ScoreBoard() {
    reset();

    font = createFont("Verdana", 16, true);
  }

  void draw() {
    fill(255, 255, 255, 128);
    textFont(font, 72);
    text(this.left, width/4, height/6);
    text(this.right, (width/4)*3, height/6);
  }

  void left_score() {
    this.left += 1;
  }

  void right_score() {
    this.right += 1;
  }

  void reset() {
    this.left = 0;
    this.right = 0;
  }
}
