// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Mover object
Bob b1;
Bob b2;
Bob b3;

Spring s1;
Spring s2;
Spring s3;

float t;

void setup() {
  size(640, 360);
  // Create objects at starting location
  // Note third argument in Spring constructor is "rest length"
  b2 = new Bob(width/2-50, height/2);
  b1 = new Bob(width/2, height/2-50);
  b3 = new Bob(width/2+50, height/2);

  s1 = new Spring(b1,b2,150);
  s2 = new Spring(b1,b3,150);
  // s3 = new Spring(b1,b3,250);
  t = 0;
}

void draw() {
  background(255); 

  s1.update();
  s2.update();
  // s3.update();
  
  s1.display();
  s2.display();
  //s3.display();

  b1.update();
  b1.display();
  //b2.update();
  b2.display();
  //b3.update();
  b3.display();

  b2.drag(height/2+10*sin(t)+10*sin(t/10));
  b3.drag(height/2+10*sin(t)+10*sin(t/10));
  
  t += 1;
}

void mousePressed() {
  //b2.clicked(mouseX, mouseY);
  //b3.clicked(mouseX, mouseY);
}

void mouseReleased() {
  //b2.stopDragging();
  //b3.stopDragging();
}