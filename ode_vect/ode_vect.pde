float h = 0.1; //<>// //<>//
float x;
float[] y;
int step;

float[] y_eul;
float[] y_heun;
float[] y_rk4;

float ee;
float eh;
float erk;


class ODE_Vect {
  ODE_Vect() {
  }

  float[] f(float x, float[] y) {
    int m = y.length;
    float[] dydx = new float[m];
  
    // y′ = x + 2y
    // val = x + 2*y;
    // val = x;
    dydx[0] = y[0];
    // dydx[1] = y[1];
  
    return dydx;
  }

  float[] eul(float x0, float[] y0, float h)
  {
    int i;
    int m = y0.length;
    float[] f0;
    float[] y = new float[m];

    f0 = f(x0, y0);
    for (i=0; i<m; i++)
    {
      y[i] = y0[i] + h*f0[i];
    }

    return y;
  }
  
  float[] heun(float x0, float[] y0, float h)
  {
    int i;
    int m = y0.length;
    float[] f0;
    float[] f1;
    float[] y1 = new float[m];
    float y[] = new float[m];

    f0 = f(x0, y0);
    for (i=0; i<m; i++)
    {
      y1[i] = y0[i] + h*f0[i];
    }

    // k2 = h*f(x0+h, y0 + k1);
    f1 = f(x0+h, y1);

    for (i=0; i<m; i++)
    {
      y[i] = y0[i] + h*(f0[i] + f1[i]) / 2.0;
    }

    return y;
  }
  
  float[] rk4(float x0, float[] y0, float h)
  {
    int i;
    int m = y0.length;
    float[] f0;
    float[] f1;
    float[] f2;
    float[] f3;
    float[] y1 = new float[m];
    float[] y2 = new float[m];
    float[] y3 = new float[m];
    float[] y = new float[m];

    // k1 = h*f(x0, y0);
    // k2 = h*f(x0+h/2, y0 + k1/2);
    // k3 = h*f(x0+h/2, y0 + k2/2);
    // k4 = h*f(x0+h, y0 + k3);
    // y = y0 + (k1 + 2*(k2+k3) + k4)/6;
    f0 = f(x0, y0);
    for (i=0; i<m; i++)
    {
      y1[i] = y0[i] + h*f0[i]/2.0;
    }

    f1 = f(x0+h/2, y1);
    for (i=0; i<m; i++)
    {
      y2[i] = y0[i] + h*f1[i]/2.0;
    }

    f2 = f(x0+h/2, y2);
    for (i=0; i<m; i++)
    {
      y3[i] = y0[i] + h*f2[i]/2.0;
    }

    f3 = f(x0+h, y3);

    for (i=0; i<m; i++)
    {
      y[i] = y0[i] + h*(f0[i] + 2.0*(f1[i] + f2[i]) + f3[i]) / 6.0;
    }

    return y;
  }
}

ODE_Vect ode_vect;

void setup() {
  size(550,450);
  background(0);

  stroke(255);
  line(0, height/2, width, height/2);

  x = 0;
  y = new float[] {1};
  y_eul = y;
  y_heun = y;
  y_rk4 = y;
  step = 0;
  
  ode_vect = new ODE_Vect();
}

void draw() {

  noStroke();

  y_eul = ode_vect.eul(x, y_eul, h);
  y_heun = ode_vect.heun(x, y_heun, h);
  y_rk4 = ode_vect.rk4(x, y_rk4, h);

  x += h;

  // y′ = x + 2y
  // y = 0.25*exp(2*x) - 0.5*x - 0.25;
  // y = x*x/2;
  y[0] = exp(x);
  // y[1] = exp(x);

  ee = y_eul[0]-y[0];
  eh = y_heun[0]-y[0];
  erk = y_rk4[0]-y[0];
  print("x: " + x + " y: " + y + " e: " + ee + " h: " + eh + " rk: " + erk + "\n");

  stroke(255);
  point(step, height/2-ee);
  stroke(255,0,0); //<>//
  point(step, height/2-eh);
  stroke(0,255,0);
  point(step, height/2-erk);

  step++;
}