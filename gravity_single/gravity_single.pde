float h; //<>//
float t;
float[] x;
float[] y;
int step;

PVector Position;
PVector Force;

float xpos, ypos;

class _ODE_Vect implements ODE_Vect {
  float c;
  void update(float _c) {
    c = _c;
  }
  float[] f(float x, float[] y) {
    int m = y.length;
    float[] dydx = new float[m];

    dydx[0] = y[1];
    dydx[1] = c;

    return dydx;
  }
}

ODE_Vect ode_vect = new _ODE_Vect();

OdeSolver_Vect odes_x;
OdeSolver_Vect odes_y;

void setup() {
  size(850,650);
  background(0);

  stroke(255);
  // line(0, height/2, width, height/2);

  h = 1;
  t = 0;
  x = new float[] {100, 1};
  y = new float[] {100, 0};
  step = 0;
  Position = new PVector(0, 0);
  Force = new PVector(0, 0);

  odes_x = new OdeSolver_Vect(ode_vect);
  odes_y = new OdeSolver_Vect(ode_vect);
} //<>//

void draw() {

  // background(0);
  noStroke();

  Position.set(x[0], y[0]);
  Force = Position.get();
  Force.normalize();
  Force.mult(-100/Position.magSq());

  // x = odes_x.eul(t, x, h);
  // y = odes_y.eul(t, y, h);
  // x = odes_x.heun(t, x, h);
  // y = odes_y.heun(t, y, h);
  // x = odes_x.rk4(t, x, h);
  // y = odes_y.rk4(t, y, h);
  odes_x.update(0);
  x = odes_x.heun(t, x, h);
  odes_y.update(-1);
  y = odes_y.heun(t, y, h);

  if (x[0] <= 0)
  {
     x[1] = -x[1];
  }
  if (y[0] <= 0)
  {
     y[1] = -y[1];
  }

  t += h;

  stroke(255);
  xpos = Position.x;
  ypos = height/2-Position.y;
  point(xpos, ypos);

  step++; //<>//
}