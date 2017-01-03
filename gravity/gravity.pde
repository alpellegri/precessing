float h;
float t;
float[] u;

PVector Position;
PVector Position2;

int mode;
int cnt;
int module;
int emodule;

class _ODE implements ODE {
  float c;
  float[] f(float t, float[] u) {
    int m = u.length;
    float[] dudt = new float[m];

    float r1 = sqrt(u[0] * u[0] + u[2] * u[2]);
    float k1 = 1000 / (r1 * r1 * r1);

    float r12 = (u[4] * u[4] + u[6] * u[6]);
    float k12 = 1000 / (r12 * sqrt(r12));
    float x12 = (u[4] - u[0]);
    float y12 = (u[6] - u[2]);
    float r22 = (x12 * x12 + y12 * y12);
    float k22 = 1 / (r22 * sqrt(r22));

    // x body 1
    /* x  */ dudt[0] = u[1];
    /* x' */ dudt[1] = -k1 * u[0] + k22 * x12 / 100;
    // y body 1
    /* y  */ dudt[2] = u[3];
    /* y' */ dudt[3] = -k1 * u[2] + k22 * y12 / 100;

    // x body 2
    /* x  */ dudt[4] = u[5];
    /* x' */ dudt[5] = -k12 * u[4] - k22 * x12;
    // y body 2
    /* y  */ dudt[6] = u[7];
    /* y' */ dudt[7] = -k12 * u[6] - k22 * y12;

    return dudt;
  }
}

ODE ode = new _ODE();

OdeSolver odes;

void setup() {
  size(850, 650);
  background(0);

  stroke(255);
  frameRate(3000);

  h = .2;
  t = 0;
  u = new float[]{200, 0, 0, 2, 205, 0, 0, 2.4};
  Position = new PVector(0, 0);
  Position2 = new PVector(0, 0);

  odes = new OdeSolver(ode);
  mode = 0;
  cnt = 0;
  emodule = 1;
  module = int(pow(2, emodule));
}

void draw() {

  u = odes.rk4(t, u, h);
  Position.set(u[0], u[2]);
  Position2.set(u[4], u[6]);

  t += h;

  cnt++;
  if ((cnt % module) == 0) {
    background(0);
    noStroke();
    noFill();
    if (mode == 0) {
      translate(width / 2, height / 2);
    } else if (mode == 1) {
      translate(width / 2 - Position.x, height / 2 + Position.y);
    } else {
      translate(width / 2 - Position2.x, height / 2 + Position2.y);
    }
    stroke(255);
    ellipse(0, 0, 8, 8);
    stroke(0, 255, 0);
    ellipse(Position.x, -Position.y, 2, 2);
    stroke(255, 0, 0);
    ellipse(Position2.x, -Position2.y, 2, 2);
  }
} //<>//

void keyPressed() {
  if (key == ' ') {
    mode++;
    mode %= 3;
  }
  if (key == 'a') {
    emodule++;
    module = int(pow(2, emodule));
  }
  if (key == 'z') {
    emodule--;
    if (emodule == 0) {
      emodule = 1;
    }
    module = int(pow(2, emodule));
  }
}
