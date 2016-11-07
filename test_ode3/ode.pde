class ODE {
  ODE() {
  }

  float f(float x, float y) {
    float dydx;
  
    // y′ = x + 2y
    // val = x + 2*y;
    // val = x;
    dydx = y;
  
    return dydx;
  }

  float eul(float x0, float y0, float h)
  {
    float y;
  
    y = y0 + h*f(x0, y0);
  
    return y;
  }
  
  float heun(float x0, float y0, float h)
  {
    float k1;
    float k2;
    float y;
  
    k1 = f(x0, y0);
    k2 = f(x0+h, y0 + h*k1);
    y = y0 + h*(k1 + k2) / 2.0;
  
    return y;
  }
  
  float rk4(float x0, float y0, float h)
  {
    float k1;
    float k2;
    float k3;
    float k4;
    float y;
    float h2;
  
    k1 = f(x0, y0);
    h2 = h/2;
    k2 = f(x0+h2, y0 + h2*k1);
    k3 = f(x0+h2, y0 + h2*k2);
    k4 = f(x0+h, y0 + h*k3);
    y = y0 + h*(k1 + 2.0*(k2+k3) + k4) / 6.0;
  
    return y;
  }
}