
float h = 0.1;
float x;
float y;
int step;

float y_eul;
float y_heun;
float y_rk4;

float ee;
float eh;
float erk;


ODE ode;

void setup() {
  size(550,450);
  background(0);

  stroke(255);
  line(0, height/2, width, height/2);

  x = 0;
  y = 1;
  y_eul = y;
  y_heun = y;
  y_rk4 = y;
  step = 0;
  
  ode = new ODE();
}

void draw() {

  noStroke();

  y_eul = ode.eul(x, y_eul, h);
  y_heun = ode.heun(x, y_heun, h);
  y_rk4 = ode.rk4(x, y_rk4, h);

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