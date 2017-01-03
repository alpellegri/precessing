
float h;
float x;
float y;
int step;

float y_eul;
float y_heun;
float y_rk4;

float ee;
float eh;
float erk;

class _ODE implements ODE {
  float f(float x, float y) {
    float dydx;

    // y′ = x + 2y
    // val = x + 2*y;
    // val = x;
    dydx = y;

    return dydx;
  }
}

ODE ode = new _ODE();

OdeSolver odes;

void setup() {
  size(550,450);
  background(0);

  stroke(255);
  line(0, height/2, width, height/2);

  h = 0.1;
  x = 0;
  y = 1;
  y_eul = y;
  y_heun = y;
  y_rk4 = y;
  step = 0;
  
  odes = new OdeSolver(ode);
}

void draw() {

  noStroke();

  y_eul = odes.eul(x, y_eul, h);
  y_heun = odes.heun(x, y_heun, h);
  y_rk4 = odes.rk4(x, y_rk4, h);

  x += h;

  // y′ = x + 2y
  // y = 0.25*exp(2*x) - 0.5*x - 0.25;
  // y = x*x/2;
  y = exp(x);

  ee = y_eul-y;
  eh = y_heun-y;
  erk = y_rk4-y;
  print("x: " + x + " y: " + y + " e: " + ee + " h: " + eh + " rk: " + erk + "\n");

  stroke(255);
  point(step, height/2-ee);
  stroke(255,0,0); //<>//
  point(step, height/2-eh);
  stroke(0,255,0);
  point(step, height/2-erk);

  step++; //<>//
}