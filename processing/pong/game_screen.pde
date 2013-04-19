
class GameScreen {
  int width;
  int height;
  ScoreBoard scoreboard;

  GameScreen(int w, int h) {
    this.width = w;
    this.height = h;

    size(this.width, this.height);

    scoreboard = new ScoreBoard();
  }

  void draw() {
    reset_background();
    fill(255, 255, 255, 128);
    rect((this.width/2)-2, 0, 4, this.height);

    scoreboard.draw();
  }

  void draw_victory(String winner) {
    textAlign(CENTER);
    int width = this.width/2;
    int height = (this.height/4)*3;

    fill(255, 255, 255, 255);
    if (winner == "left") {
      text("left wins", width, height);
    }
    else if (winner == "right") {
      text("right wins", width, height);
    }
  }

  void reset_background() {
    background(0, 0, 0);
  }
}
