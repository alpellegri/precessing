float h; //<>//
float t;
float[] x;
float[] y;
int step;

PVector Position;
PVector a;

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

ODE_Vect ode_vectx = new _ODE_Vect();
ODE_Vect ode_vecty = new _ODE_Vect();

OdeSolver_Vect odes_x;
OdeSolver_Vect odes_y;

void setup() {
  size(850,650);
  background(0);

  stroke(255);

  h = 0.1;
  t = 0;
  x = new float[] {30, 0};
  y = new float[] {0, 1};
  step = 0;
  Position = new PVector(0, 0);
  a = new PVector(0, 0);

  odes_x = new OdeSolver_Vect(ode_vectx);
  odes_y = new OdeSolver_Vect(ode_vecty);
} //<>//

void draw() {

  background(0);
  noStroke();

  Position.set(x[0], y[0]);
  a = Position.get();
  a.normalize();
  a.mult(-100/Position.magSq());

  // x = odes_x.eul(t, x, h);
  // y = odes_y.eul(t, y, h);
  // x = odes_x.heun(t, x, h);
  // y = odes_y.heun(t, y, h);
  // x = odes_x.rk4(t, x, h);
  // y = odes_y.rk4(t, y, h);
  odes_x.update(a.x);
  odes_y.update(a.y);
  x = odes_x.rk4(t, x, h);
  y = odes_y.rk4(t, y, h);

  t += h;

  stroke(255); //<>//
  ellipse(width/2, height/2, 8, 8);
  xpos = width/2+Position.x;
  ypos = height/2-Position.y;
  ellipse(xpos, ypos, 2, 2);
  stroke(255,0,0);
  // line(xpos, ypos, xpos+200*a.x, ypos-200*a.y);

  step++; //<>//
}