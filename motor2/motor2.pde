double h;
double t;
double[] u;

double H = .5;
int offset;

/* mec */
double K = 1;
double X0 = 20;
double Ro = 0;
double M = 20;
double F = 1;

class _ODE implements ODE {
  double c;
  double[] f(double t, double[] u) {
    int m = u.length;
    double[] dudt = new double[m];

    /* u'' */ dudt[0] = (F -Ro*u[1] +K*(X0 - u[1])) / M;
    /* u'  */ dudt[1] = u[0];

    return dudt;
  }
}

ODE ode = new _ODE();

OdeSolver odes;

void setup() {
  size(850,650);
  background(0);
  stroke(100);
  line(0, height/2, width, height/2);
  line(0, height/2-100, width, height/2-100);
  line(0, height/2+100, width, height/2+100);

  frameRate(3000);

  t = 0;
  u = new double[] {0, 0};

  odes = new OdeSolver(ode);
  offset = 0;
  // offset = period*0.99*duty;
}

void draw() {
  float x;

  h = H;

  u = odes.rk4(t, u, h);

  t += h;
  println(t);

  x = (float)(t-offset);
  if (t>offset) {
    translate(0, height/2);
    stroke(0,255,0);
    point(x, (float)(-u[0]));
    stroke(255,0,0);
    point(x, (float)(-u[1]));
  }
} //<>//

void keyPressed() {
}