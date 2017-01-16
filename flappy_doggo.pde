PImage startImage;
PImage backImg;
PImage dogImg;
PImage wallImg;
boolean gameStarted = false;
int x = -200; 
int y;
int vy = 0;
int[] wx = new int[2];
int[] wy = new int[2];
int score = 0;
int highScore;
void setup() {
  size(600, 800);
  backImg = loadImage("background.png");
  dogImg = loadImage("Doge-head.png");
  wallImg = loadImage("wall.png");
  startImage = loadImage("start_screen.png");
  textSize(40);
  fill(0);
}
void draw() {
  if (gameStarted == true) {
    imageMode(CORNER);
    //moving background
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0);
    x -= 6;
    //bird moving
    vy += 1;
    y += vy;
    if (x == -1800) {
      x = 0;
    }
    //drawing the walls
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      image(wallImg, wx[i], wy[i] - (wallImg.height/2+100));
      image(wallImg, wx[i], wy[i] + (wallImg.height/2+100));
      if (wx[i] < 0) {
        wy[i] = (int)random(200, height-200);
        wx[i] = width;
      }
      if (wx[i] == width/2) {
        score++;
        highScore = max(score, highScore);
      }
      if (y > height || y < 0 || (abs(width/2-wx[i])< 25 && abs(y-wy[i])>90)) {
        gameStarted = false;
      }
      wx[i] -= 5;
    }
    image(dogImg, width/2, y);
    text("bones: "+score, 5, 40);
  } else {
    imageMode(CENTER);
    image(startImage, width/2, height/2);
    text("Best score: " + highScore, 50, width+150);
    if (score > 0 || highScore > 0) {
      text("Bones colected: "+ score, 50, width+90);
      textSize(80);
      text("GAME OVER", 60, width);
      textSize(40);
    }
  }
}
void keyPressed() {
  vy = -17;
  if (gameStarted == false) {
    wx[0] = 600;
    wy[0] = height/2;
    wx[1] = 900;
    wy[1] = 600;
    score = 0;
    x = 0;
    y = height/2;
    gameStarted = true;
  }
}