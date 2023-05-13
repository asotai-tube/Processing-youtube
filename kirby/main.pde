// variable for animation
float r = 0;
float h = 0;
float t = 0;

void setup() {
  // sceen size
  size(800, 600);
  // no border
  noStroke();
}

void draw() {
  // set background color
  background(0, 200, 255);
  
  // change background color
  fill(0, 220, 255);
  triangle(200, 0, 600, 0, 400, 500);
  
  // left cloud
  float h1 = 700 - (h % 800);
  fill(255, 255, 255);
  circle(50, h1, 70);
  circle(400, h1, 70);
  rect(50, h1-35, 350, 70);
  
  // right cloud
  float h2 = 700 - ((h + 300) % 800);
  fill(255, 255, 255);
  circle(400, h2, 70);
  circle(750, h2, 70);
  rect(400, h2-35, 350, 70);
  
  translate(370, 330);
  
  rotate(r);
  
  // kirby's shadow
  fill(0, 0, 0);
  rotate(radians(225));
  ellipse(-120, 0, 300, 200);
  rotate(radians(90));
  ellipse(-120, 0, 300, 200);
  rotate(radians(90));
  ellipse(-120, 0, 300, 200);
  rotate(radians(90));
  ellipse(-120, 0, 300, 200);
  rotate(radians(225));
  circle(0, 0, 400);
  
  rotate(-r);
  
  translate(30, -30);
  
  rotate(r);
  
  // kirby's body
  fill(255, 0, 0);
  rotate(radians(225));
  ellipse(-120, 0, 300, 200);
  rotate(radians(90));
  ellipse(-120, 0, 300, 200);
  fill(255, 100, 180);
  rotate(radians(90));
  ellipse(-120, 0, 300, 200);
  rotate(radians(90));
  ellipse(-120, 0, 300, 200);
  rotate(radians(225));
  circle(0, 0, 400);
  
  // kirby's eyes
  float t1 = t % 100;
  if (10 <= t1 && t1 < 20) {
    fill(0, 0, 0);
    rect(-70, -30, 40, 10);
    rect(30, -30, 40, 10);
  }
  else {
    fill(0, 0, 0);
    circle(-50, -70, 40);
    circle(-50, 0, 40);
    rect(-70, -70, 40, 70);
    fill(0, 0, 200);
    circle(-50, 0, 30);
    fill(255, 255, 255);
    circle(-50, -70, 30);
    
    fill(0, 0, 0);
    circle(50, -70, 40);
    circle(50, 0, 40);
    rect(30, -70, 40, 70);
    fill(0, 0, 200);
    circle(50, 0, 30);
    fill(255, 255, 255);
    circle(50, -70, 30);
  }
  
  // kirby's cheeks
  fill(255, 0, 0);
  ellipse(-120, 20, 80, 40);
  ellipse(120, 20, 80, 40);
  
  // kirby's mouth
  fill(0, 0, 0);
  beginShape();
    float d1 = 15/sqrt(2);
    vertex(-20, 25);
    vertex(20, 25);
    vertex(20+d1, 40+d1);
    vertex(d1, 60+d1);
    vertex(-d1, 60+d1);
    vertex(-20-d1, 40+d1);
    vertex(-20, 25);
  endShape();
  circle(-20, 40, 30);
  circle(20, 40, 30);
  circle(0, 60, 30);
  
  // kirby's tongue
  fill(150, 0, 0);
  beginShape();
    float d2 = 10/sqrt(2);
    vertex(-27, 47);
    vertex(27, 47);
    vertex(d2, 60+d2);
    vertex(-d2, 60+d2);
  endShape();
  circle(0, 60, 20);
  
  // add variable for animation
  r += 0.02;
  h += 2;
  t += 1;
}
