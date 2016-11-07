float h; //<>//
float x;
float[] y;
int step;

class _ODE_Vect implements ODE_Vect {
  float[] f(float x, float[] y) {
    int m = y.length;
    float[] dydx = new float[m];

    dydx[0] = y[1];
    dydx[1] = -2*(y[0]);
  
    return dydx;
  }
}

ODE_Vect ode_vect = new _ODE_Vect();

OdeSolver_Vect odes_vect;

void setup() {
  size(550,450);
  background(0);

  stroke(255);
  line(0, height/2, width, height/2);

  h = 0.1;
  x = 0;
  y = new float[] {100,0};
  step = 0;

  odes_vect = new OdeSolver_Vect(ode_vect);
}

void draw() {

  noStroke();

  // y = odes_vect.eul(x, y, h);
  y = odes_vect.heun(x, y, h);
  // y = odes_vect.rk4(x, y, h);

  x += h;

  stroke(255);
  point(step, height/2-y[0]);

  step++; //<>//
}