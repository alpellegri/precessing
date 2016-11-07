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
    dydx[1] = y[1];
  
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
    float h2 = h/2;

    f0 = f(x0, y0);
    for (i=0; i<m; i++)
    {
      y1[i] = y0[i] + h2*f0[i];
    }

    f1 = f(x0+h2, y1);
    for (i=0; i<m; i++)
    {
      y2[i] = y0[i] + h2*f1[i];
    }

    f2 = f(x0+h2, y2);
    for (i=0; i<m; i++)
    {
      y3[i] = y0[i] + h*f2[i];
    }

    f3 = f(x0+h, y3);

    for (i=0; i<m; i++)
    {
      y[i] = y0[i] + h*(f0[i] + 2.0*(f1[i] + f2[i]) + f3[i]) / 6.0;
    }

    return y;
  }
}