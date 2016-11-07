//==========================================================
class Particle {
  float px;
  float py;
  float vx;
  float vy;
  float damping;
  float mass;
  boolean bLimitVelocities = true;
  boolean bPeriodicBoundaries = false;
 
  // Constructor for the Particle
  Particle (float x, float y) {
    px = x;
    py = y;
    vx = vy = 0;
    damping = 0.93;
    mass = 1.0;
  }
 
  // Add a force in. One step of Euler integration.
  void addForce (float fx, float fy) {
    float ax = fx / mass;
    float ay = fy / mass;
    vx += ax;
    vy += ay;
  }
 
  // Update the position. Another step of Euler integration.
  void update() {
    vx *= damping;
    vy *= damping;
    limitVelocities();
    handleBoundaries();
    px += vx;
    py += vy;
  }
 
 
  void limitVelocities() {
    if (bLimitVelocities) {
      float speed = sqrt(vx*vx + vy*vy);
      float maxSpeed = 6.0;
      if (speed > maxSpeed) {
        vx *= maxSpeed/speed;
        vy *= maxSpeed/speed;
      }
    }
  }
 
  void handleBoundaries() {
    if (bPeriodicBoundaries) {
      if (px > width ) px -= width;
      if (px < 0     ) px += width;
      if (py > height) py -= height;
      if (py < 0     ) py += height;
    }
    else {
      if (px+vx > width ) {
        vx = -vx;
        px = min(px, width);
      }
      if (px+vx < 0     ) {
        vx = -vx;
        px = max(px, 0);
      }
      if (py+vy > height) {
        vy = -vy;
        py = min(py, height);
      }
      if (py+vy < 0     ) {
        vy = -vy;
        py = max(py, 0);
      }
    }
  }
 
  void render() {
    fill(255,0,0);
    ellipse(px, py, 7, 7);
  }
}