ArrayList<Particle> myParticles;
ArrayList<Spring> mySprings;
 
void setup() {
  size(800, 600);
  myParticles = new ArrayList<Particle>();
 
  int nPoints = 50;
  float radius = 100;
  for (int i=0; i<nPoints; i++) {
    float t = (float)i/nPoints * TWO_PI;
    float rx = width/2 + radius * cos(t);
    float ry = width/2 + radius * sin(t);
    myParticles.add( new Particle(rx, ry));
  }
 
 
  // stitch the particles together into a blob.
  mySprings = new ArrayList<Spring>();
  for (int i=0; i<(nPoints/2); i++) {
    Particle p = myParticles.get(i);
    Particle q = myParticles.get((i+1)%nPoints);
    Spring s0 = new Spring (p, q);
    mySprings.add (s0);
  }

  int connections[] = {-7,-5,-3,-2,2,3,5,7};
  for (int j=1; j<connections.length; j++) {
    for (int i=0; i<nPoints; i++) {
      Particle p = myParticles.get(i);
      Particle q = myParticles.get((nPoints + i + connections[j])%nPoints);
      Spring s0 = new Spring (p, q);
      mySprings.add (s0);
    }
  }
   
}
 
int whichPointIsGrabbed = -1;
void mousePressed() {
  // find the closest particle
  float maxDist = 9999;
  for (int i=0; i<myParticles.size(); i++) {
    float dx = mouseX - myParticles.get(i).px;
    float dy = mouseY - myParticles.get(i).py;
    float dh = sqrt(dx*dx + dy*dy);
    if (dh < maxDist) {
      maxDist = dh;
      whichPointIsGrabbed = i;
    }
  }
}
 
 
void draw() {
  background (0);
 
  float gravityForceX = 0;
  float gravityForceY = 0.1;
 
  // update the particles
  for (int i=0; i<myParticles.size(); i++) {
    myParticles.get(i).bPeriodicBoundaries = false;
    myParticles.get(i).update(); // update all locations
  }
 
  if (mousePressed) {
    myParticles.get(whichPointIsGrabbed).px = mouseX;
    myParticles.get(whichPointIsGrabbed).py = mouseY;
  }
  for (int i=0; i<myParticles.size(); i++) {
    myParticles.get(i).addForce(gravityForceX, gravityForceY);
  }
   
  // update the springs
  for (int i=0; i<mySprings.size(); i++) {
    mySprings.get(i).update(); // draw all springs
  }
   
 
  // Render the springs and particles
  for (int i=0; i<mySprings.size(); i++) {
    mySprings.get(i).render(); // draw all springs
  }
  for (int i=0; i<myParticles.size(); i++) {
    myParticles.get(i).render(); // draw all particles
  }
}