public interface ODE { //this is the interface declaration
    public double[] f(double t, double[] u);
}

class OdeSolver {
  ODE ode;
  OdeSolver(ODE _ode) {
    ode = _ode;
  }
  double[] eul(double t0, double[] u0, double h)
  {
    int i;
    int n = u0.length;
    double[] f0;
    double[] u = new double[n];

    f0 = ode.f(t0, u0);
    for (i=0; i<n; i++) {
      u[i] = u0[i] + h*f0[i];
    }

    return u;
  }
  
  double[] heun(double t0, double[] u0, double h)
  {
    int i;
    int n = u0.length;
    double[] f0;
    double[] f1;
    double[] u1 = new double[n];
    double[] u = new double[n];

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
  
  double[] rk2(double t0, double[] u0, double h)
  {
    int i;
    int n = u0.length;
    double[] f0;
    double[] f1;
    double[] u1 = new double[n];
    double[] u = new double[n];
    double h2 = h/2;

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
  
  double[] rk4(double t0, double[] u0, double h)
  {
    int i;
    int n = u0.length;
    double[] f0;
    double[] f1;
    double[] f2;
    double[] f3;
    double[] ut = new double[n];
    double[] u = new double[n];
    double h2 = h/2;

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