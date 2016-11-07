
float h = 0.1;
float x;
float y;
int step;

float y_eul;
float heun_k1;
float heun_k2;
float y_heun;
float k1;
float k2;
float k3;
float k4;
float y_rk4;

float ee;
float eh;
float erk;

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
}

float f(float x, float y)
{
  float val;

  // y′ = x + 2y
  // val = x + 2*y;
  // val = x;
  val = y;

  return val;
}

void draw() {

  noStroke();

  y_eul += h*f(x, y_eul);

  heun_k1 = h*f(x, y_heun);
  heun_k2 = h*f(x+h, y_heun + heun_k1);
  y_heun += (heun_k1 + heun_k2)/2;

  k1 = h*f(x, y_rk4);
  k2 = h*f(x+h/2, y_rk4 + k1/2);
  k3 = h*f(x+h/2, y_rk4 + k2/2);
  k4 = h*f(x+h, y_rk4 + k3);
  y_rk4 += (k1 + 2*(k2+k3) + k4)/6;

  x += h;

  // y′ = x + 2y
  // y = 0.25*exp(2*x) - 0.5*x - 0.25;
  // y = x*x/2;
  y = exp(x);

  ee = y_eul-y;
  eh = y_heun-y;
  erk = y_rk4-y;
  print("x: " + x + " y: " + y + " e: " + ee + " h: " + eh + " rk: " + erk + "\n");

  stroke(255); //<>//
  point(step, height/2-ee);
  stroke(255,0,0);
  point(step, height/2-eh);
  stroke(0,255,0);
  point(step, height/2-erk);

  step++; //<>//
}