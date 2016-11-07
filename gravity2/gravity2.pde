float h;
float t;
float[] u;
int step;

PVector Position;
PVector Velocity;

class _ODE implements ODE {
  float c;
  float[] f(float t, float[] u) {
    int m = u.length;
    float[] dudt = new float[m];
    
    float r = (u[0]*u[0]+u[2]*u[2]);
    float k = 1/(r*sqrt(r));

    // x body
    /* x  */ dudt[0] = u[1];
    /* x' */ dudt[1] = -k*u[0];
    // y body
    /* y  */ dudt[2] = u[3];
    /* y' */ dudt[3] = -k*u[2];

    return dudt;
  }
}

ODE ode = new _ODE();

OdeSolver odes;

void setup() {
  size(850,650);
  background(0);

  stroke(255);

  h = .01;
  t = 0;
  u = new float[] {1, 0, 0, 0.5};
  Position = new PVector(0,0);
  Velocity = new PVector(0,0);
  step = 0;

  odes = new OdeSolver(ode);
}

void draw() {

  // background(0);
  noStroke();

  u = odes.rk4(t, u, h);
  Position.set(u[0], u[2]);
  Position.mult(300);
  Velocity.set(u[1], u[3]);
  Velocity.mult(20);

  t += h;

  stroke(255);
  noFill();
  translate(width/2, height/2);
  // translate(width/2-Position.x, height/2+Position.y);
  ellipse(0, 0, 8, 8);
  ellipse(Position.x, -Position.y, 2, 2);
  stroke(255,0,0);
  line(Position.x, -Position.y, Position.x + Velocity.x, -(Position.y + Velocity.y));
  stroke(255,0,0); //<>//

  step++;
}