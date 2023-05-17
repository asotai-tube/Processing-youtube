float t = 0;
float maxT = 60;
float lightW = 0.2;
float side = 50;

void setup() {
  size(800, 600); 
}
  
void bg() {
  background(100, 200, 255); 
}

void shadow(float topX, float topY, float l) {
  resetMatrix();
  translate(topX, topY);
  
  float leftX = -l/2;
  float leftY = l*sqrt(3)/2;
  float rightX = l/2;
  float rightY = l*sqrt(3)/2;
  
  float offset = 7;
  
  noStroke();
  fill(30, 30, 30);
  beginShape();
    vertex(-offset, -2*offset);
    vertex(side+offset, -2*offset);
    vertex(rightX+side+2*offset*sqrt(3), rightY+offset*sqrt(3));
    vertex(leftX-2*offset*sqrt(3), leftY+offset*sqrt(3));
    vertex(-offset, -2*offset);
  endShape();
  
  resetMatrix();
}

void tri(float topX, float topY, float l, float tRatio) {
  resetMatrix();
  translate(topX, topY);
  
  float leftX = -l/2;
  float leftY = l*sqrt(3)/2;
  float rightX = l/2;
  float rightY = l*sqrt(3)/2;
  
  // triangle (fill)
  noStroke();
  fill(255, 255, 0);
  triangle(0, 0, leftX, leftY, rightX, rightY);
  
  // light
  fill(255, 255, 255);
  
  float tRatio1 = min(1, tRatio);
  float tRatio2 = tRatio - lightW;
  float topLeftX = lerp(rightX, 0, tRatio1);
  float topLeftY = lerp(rightY, 0, tRatio1);
  float bottomLeftX = lerp(rightX, leftX, tRatio1);
  float bottomLeftY = leftY;
  
  if (tRatio2 <= 0) {
    triangle(
      topLeftX, topLeftY,
      bottomLeftX, bottomLeftY,
      rightX, rightY
    );
  } else {
    float bottomRightX = lerp(rightX, leftX, tRatio2);
    float bottomRightY = rightY;
    float topRightX = lerp(rightX, 0, tRatio2);
    float topRightY = lerp(rightY, 0, tRatio2);
    
    beginShape();
      vertex(topLeftX, topLeftY);
      vertex(topRightX, topRightY);
      vertex(bottomRightX, bottomRightY);
      vertex(bottomLeftX, bottomLeftY);
      vertex(topLeftX, topLeftY);
    endShape();
  }
  
  // triangle's side
  fill(200, 200, 0);
  beginShape();
    vertex(0, 0);
    vertex(side, 0);
    vertex(rightX+side, rightY);
    vertex(rightX, rightY);
    vertex(0, 0);
  endShape();
  
  resetMatrix();
}

float f(float x, float r) {
  return sqrt(r*r - x*x);
}

void effect(float x, float y, float minR, float maxR, float tRatio) {
  resetMatrix();
  translate(x, y);
  
  float t_ = 2 * (constrain(tRatio, 0.5, 1.0) - 0.5);
  float radian = radians(90 * t_);
  rotate(radian);
  
  // effect (fill)
  stroke(250, 250, 0);
  strokeWeight(2);
  
  float r = lerp(minR, maxR, 0.5+0.5*sin(2*PI*tRatio));
  for(int x_ = 0; x_ <= r; x_++) {
    float bottomY = -f(x_, r) + r;
    float topY = f(x_, r) - r;
    line(-r+x_, bottomY, -r+x_, topY);
    line(r-x_, bottomY, r-x_, topY);
  }
  
  // effect (stroke)
  stroke(0, 0, 0);
  strokeWeight(5);
  noFill();
  arc(-r, -r, 2*r, 2*r, 0, radians(90));
  arc(r, -r, 2*r, 2*r, radians(90), radians(180));
  arc(r, r, 2*r, 2*r, radians(180), radians(270));
  arc(-r, r, 2*r, 2*r, radians(270), radians(360));
  
  resetMatrix();
}

void draw() {
  bg();
  
  float tRatio = t/maxT;
  
  shadow(300, 100+sqrt(3)*100, 200);
  shadow(500, 100+sqrt(3)*100, 200);
  shadow(400, 100, 200);
  
  tri(300, 100+sqrt(3)*100, 200, (1+lightW)*tRatio);
  tri(500, 100+sqrt(3)*100, 200, (1+lightW)*tRatio);
  tri(400, 100, 200, (1+lightW)*tRatio);
  
  effect(150, 100, 100, 150, tRatio);
  effect(700, 250, 50, 100, tRatio);
  effect(250, 500, 50, 100, tRatio);
  
  if (t++ == maxT) {
    t = 0;
  }
}
