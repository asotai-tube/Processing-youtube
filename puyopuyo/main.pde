int h = 0;
int state = 0;

void setup() {
  // set screen size
  size(800, 600);
}

void puyo(float x, float y) {
  translate(x, y);
  
  // puyo's body (fill)
  noStroke();
  fill(0, 220, 0);
  ellipse(0, 0, 300, 290);
  fill(0, 200, 0);
  ellipse(0, 30, 200, 170);
  
  translate(-70, -50);
  rotate(radians(30));
  
  // puyo's right eye
  stroke(0, 150, 0);
  strokeWeight(6);
  fill(255, 255, 255);
  ellipse(0, 0, 125, 160);
  fill(0, 180, 0);
  ellipse(-8, -10, 90, 120);
  
  rotate(radians(-30));
  translate(140, 0);
  rotate(radians(-30));
  
  // puyo's left eye
  stroke(0, 150, 0);
  strokeWeight(6);
  fill(255, 255, 255);
  ellipse(0, 0, 125, 160);
  fill(0, 180, 0);
  ellipse(8, -10, 90, 120);
  
  rotate(radians(30));
  translate(-70, 50);
  
  // puyo's body (stroke)
  stroke(0, 150, 0);
  strokeWeight(15);
  noFill();
  ellipse(0, 0, 300, 290);
  
  // puyo's brightness
  noStroke();
  fill(255, 255, 255, 100);
  ellipse(0, -65, 150, 140);
  
  translate(-x, -y);
}

void effect(float x, float y, int cnt, float t /*0~1*/) {
  stroke(0, 150, 0);
  strokeWeight(7);
  fill(0, 220, 0, 100);
  
  float deltaDegree = 90 * t;
  for (int i = 0; i < cnt; i++) {
    float dist = 30 + 120*t;
    float radius = 100 - 90*t;

    float radian = radians(i*360/cnt + deltaDegree);
    float dx = dist * cos(radian);
    float dy = dist * sin(radian);
    
    circle(x+dx, y+dy, radius);
  }
}

void shadow(float x, float y, float t) {
  noStroke();
  
  float col = 255 - 100*t;
  fill(col ,col ,col);
  
  float w = 250 * t;
  float h = 80 * t;
  ellipse(x, y, w, h);
}

void bg() {
  background(255, 255, 255);
}

void nextState() {
  h = 0;
  state++;
}

void initState() {
  h = 0;
  state = 1;
}

void draw() {
  bg();
  
  switch(state) {
  case 0:
    fill(0, 0, 0);
    textSize(48);
    text("Click here", 300, 300);
    break;
  case 1:
    if (h >= 300) {
      shadow(100, 550, float(h-300)/300);
      shadow(400, 550, float(h-300)/300);
    }
    puyo(100, -200+h);
    puyo(400, -200+h);
    h += 10;
    if (h >= 600) {
      nextState();
    }
    break;
  case 2:
    shadow(100, 550, 1);
    shadow(400, 550, 1);
    puyo(100, 400);
    puyo(400, 400);
    puyo(700, -200+h);
    puyo(400, -200+h);
    h += 10;
    if (h >= 300) {
      nextState();
    }
    break;
  case 3:
    shadow(100, 550, 1);
    shadow(400, 550, 1);
    shadow(700, 550, float(h)/300);
    puyo(100, 400);
    puyo(400, 400);
    puyo(700, 100+h);
    puyo(400, 100);
    h += 10;
    if (h >= 300) {
      nextState();
    }
    break;
  case 4:
    if ((h/7) % 2 == 0) {
      shadow(100, 550, 1);
      shadow(400, 550, 1);
      shadow(700, 550, 1);
      puyo(100, 400);
      puyo(400, 400);
      puyo(700, 400);
      puyo(400, 100);
    }
    h++;
    if (h == 60) {
      nextState();
    }
    break;
  case 5:
    float t = float(h) / 30;
    effect(100, 400, 12, t);
    effect(400, 400, 12, t);
    effect(700, 400, 12, t);
    effect(400, 100, 12, t);
    h++;
    if (h == 30) {
      initState();
    }
    break;
  }
}

void mousePressed() {
  initState();
}
