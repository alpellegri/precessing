public interface ODE { //this is the interface declaration
    public float[] f(float t, float[] u);
}

class OdeSolver {
  ODE ode;
  OdeSolver(ODE _ode) {
    ode = _ode;
  }
  float[] eul(float t0, float[] u0, float h)
  {
    int i;
    int n = u0.length;
    float[] f0;
    float[] u = new float[n];

    f0 = ode.f(t0, u0);
    for (i=0; i<n; i++) {
      u[i] = u0[i] + h*f0[i];
    }

    return u;
  }
  
  float[] heun(float t0, float[] u0, float h)
  {
    int i;
    int n = u0.length;
    float[] f0;
    float[] f1;
    float[] u1 = new float[n];
    float[] u = new float[n];

    f0 = ode.f(t0, u0);
    for (i=0; i<n; i++) {
      u1[i] = u0[i] + h*f0[i];
    }

    f1 = ode.f(t0+h, u1);
    for (i=0; i<n; i++) {
      u[i] = u0[i] + h*(f0[i] + f1[i]) / 2.0;
    }

    return u;
  }
  
  float[] rk2(float t0, float[] u0, float h)
  {
    int i;
    int n = u0.length;
    float[] f0;
    float[] f1;
    float[] u1 = new float[n];
    float[] u = new float[n];
    float h2 = h/2;

    f0 = ode.f(t0, u0);
    for (i=0; i<n; i++) {
      u1[i] = u0[i] + h2*f0[i];
    }

    f1 = ode.f(t0+h2, u1);
    for (i=0; i<n; i++) {
      u[i] = u0[i] + h*f1[i];
    }

    return u;
  }
  
  float[] rk4(float t0, float[] u0, float h)
  {
    int i;
    int n = u0.length;
    float[] f0;
    float[] f1;
    float[] f2;
    float[] f3;
    float[] ut = new float[n];
    float[] u = new float[n];
    float h2 = h/2;

    f0 = ode.f(t0, u0);
    for (i=0; i<n; i++) {
      ut[i] = u0[i] + h2*f0[i];
    }

    f1 = ode.f(t0+h2, ut);
    for (i=0; i<n; i++) {
      ut[i] = u0[i] + h2*f1[i];
    }

    f2 = ode.f(t0+h2, ut);
    for (i=0; i<n; i++) {
      ut[i] = u0[i] + h*f2[i];
    }

    f3 = ode.f(t0+h, ut);

    for (i=0; i<n; i++) {
      u[i] = u0[i] + h*(f0[i] + 2.0*(f1[i] + f2[i]) + f3[i]) / 6.0;
    }

    return u;
  }
}