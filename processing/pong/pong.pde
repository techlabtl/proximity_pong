
import processing.serial.*;

// game handling
GameScreen screen;
Paddle right_paddle;          // the right user paddle
Paddle left_paddle;           // the left user paddle
Puck puck;                    // the puck

// puck movement
// PVector puck_movement = new PVector(random(-1,1), random(-1,1));
PVector puck_movement = new PVector(1, -1);

// paddle dimensions and movement
int paddle_width;
int paddle_height;
int paddle_x_offset = 10;
float paddle_y_movement = 10;

// game control 
boolean scored = false;
boolean pause = false;
boolean victory = false;
int score_delay = 1000;
int victory_threshold = 100;
String winner;

// serial port for game controllers
Serial port;


void setup() {
  screen = new GameScreen(700, 700);
  noStroke();

  port = new Serial(this, "/dev/ttyACM0", 9600);

  paddle_width = width/40;
  paddle_height = height/8;

  right_paddle = new Paddle(width - paddle_width - paddle_x_offset, height/2, paddle_width, paddle_height);
  left_paddle = new Paddle(0 + paddle_x_offset, height/2, paddle_width, paddle_height);

  puck = new Puck(width/2, height/2, 10, 7);
}

void draw() {
  if (scored) { delay(score_delay); }  // check if a delay must be applied after score

  if (pause) { noLoop(); }  // check if game must be paused/ended
  
  // check that the puck bounces on the right_paddle
  if (puck.collide_with_paddle(right_paddle)) {
    // puck_movement.x = -puck_movement.x;
    reflection(new PVector(-1,0));
  }
  if (puck.collide_with_paddle(left_paddle))  {
    // puck_movement.x = -puck_movement.x;
    reflection(new PVector(1,0));
  }
  
  // check that puck position respects left-right boundaries
  // if (puck.collide_right(screen.width) || puck.collide_left(0)) { puck_movement.x = -puck_movement.x; }
  // check that puck position respects top-bottom boundaries
  if (puck.collide_bottom(screen.height) || puck.collide_top(0)) { puck_movement.y = -puck_movement.y; }

  puck.move(puck_movement.x, puck_movement.y);
  puck_movement.normalize();

  // scoring and victory
  boolean right_score = puck.collide_left(0);
  boolean left_score = puck.collide_right(screen.width);
  if (right_score || left_score) {
    if (right_score) { screen.scoreboard.right_score(); }
    if (left_score) { screen.scoreboard.left_score(); }
    scored = true;

    if (victory()) {
      victory = true;
      winner = (left_score) ? "left" : "right";
      pause = true;
      screen.draw_victory(winner);
    }
  }
  else { scored = false; }

  while (port.available() > 0) {
    read_serial();
  }
  screen.draw();
  if (victory || scored) { reset_game(); }
  if (victory) { screen.draw_victory(winner); }
  right_paddle.draw();
  left_paddle.draw();
  puck.draw();
}


// void serialEvent(Serial port) {
void read_serial() {
  int input = port.read();
  
  if (input <= 127) {
    print("Left  ");
    print("raw: " + input);
    input = (int)map(input, 0, 127, 0, screen.height - right_paddle.height);
    print(" - ");
    print("mapped: " + input);
    left_paddle.move(input);
  }
  else if (input > 127 && input <= 255) {
    print("Right ");
    print("raw: " + input);
    input = (int)map(input, 128, 255, 0, screen.height - left_paddle.height);
    print(" - ");
    print("mapped: " + input);
    right_paddle.move(input);
  }

  println("----------------------");
}

// @see: http://processing.org/reference/keyCode.html
void keyPressed() {
  // space key for pausing game
  if (key == ' ') {
    if (pause == true) { pause = false; loop(); }
    else if (pause == false) { pause = true; }
  }
  // r key for resetting game
  if (key == 'r' || key == 'R') { 
    pause = false;
    // reset victory
    victory = false;
    // reset winner
    winner = "";
    // reset scores
    screen.scoreboard.reset();
    reset_game();
    loop();
  }
}

void reflection(PVector normal) {
  float dot_product = PVector.dot(puck_movement, normal);
  PVector vector = PVector.mult(normal, 2);
  vector.mult(dot_product);
  puck_movement.sub(vector);
}

boolean victory() {
  return (screen.scoreboard.left == victory_threshold || screen.scoreboard.right == victory_threshold) ? true : false;
}

void reset_game() {
  puck_movement = new PVector(random(-1,1), random(-1,1));
  // reset the paddle at the center of the screen height
  right_paddle.y = (float)height/2-(right_paddle.height/2);
  left_paddle.y = (float)height/2-(left_paddle.height/2);
  // reset the puck at the center of the screen
  puck.x = width/2;
  puck.y = height/2;
}
