//==========================================================
class Spring {
  Particle p;
  Particle q;
  float restLength;
  float springConstant;
 
  Spring (Particle p1, Particle p2) {
    p = p1;
    q = p2;
 
    float dx = p.px - q.px;
    float dy = p.py - q.py;
    restLength = sqrt(dx*dx + dy*dy);
    springConstant = 0.1;
  }
 
  void update() {
    float dx = p.px - q.px;
    float dy = p.py - q.py;
    float dh = sqrt(dx*dx + dy*dy);
 
    if (dh > 1) {
      float distention = dh - restLength;
      float restorativeForce = springConstant * distention; // F = -kx
      float fx = (dx/dh) * restorativeForce;
      float fy = (dy/dh) * restorativeForce;
      p.addForce (-fx, -fy);
      q.addForce ( fx, fy);
    }
  }
 
  void render() {
    stroke(255);
    line(p.px, p.py, q.px, q.py);
  }
}