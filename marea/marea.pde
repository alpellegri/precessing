float h;
float t;
float[] u;

PVector Position;
PVector Position2;

int mode;

class _ODE implements ODE {
  float c;
  float[] f(float t, float[] u) {
    int m = u.length;
    float[] dudt = new float[m];

    float r1 = sqrt(u[0] * u[0] + u[2] * u[2]);
    float k1 = 1000 / (r1 * r1 * r1);

    float r2 = sqrt(u[4] * u[4] + u[6] * u[6]);
    float k2 = 1000 / (r2 * r2 * r2);
    float sx12 = (u[4] - u[0]);
    float sy12 = (u[6] - u[2]);
    float vx12 = (u[5] - u[1]);
    float vy12 = (u[7] - u[3]);
    float v12 = sqrt(vx12 * vx12 + vy12 * vy12);
    float s12 = sqrt(sx12 * sx12 + sy12 * sy12);
    float kf = .3 / (v12 * v12 * v12); // v12*.3;
    float kk = 0;                      //(5-s12)*.1;

    // x body 1
    /* x  */ dudt[0] = u[1];
    /* x' */ dudt[1] = -k1 * u[0] + kf * (u[5] - u[1]) + kk;
    // y body 1
    /* y  */ dudt[2] = u[3];
    /* y' */ dudt[3] = -k1 * u[2] + kf * (u[7] - u[3]) + kk;

    // x body 2
    /* x  */ dudt[4] = u[5];
    /* x' */ dudt[5] = -k2 * u[4] - kf * (u[5] - u[1]) - kk;
    // y body 2
    /* y  */ dudt[6] = u[7];
    /* y' */ dudt[7] = -k2 * u[6] - kf * (u[7] - u[3]) - kk;

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

  h = .01;
  t = 0;
  u = new float[]{200, 0, 0, 2, 205, 0, 0, 2.4};
  Position = new PVector(0, 0);
  Position2 = new PVector(0, 0);

  odes = new OdeSolver(ode);
  mode = 0;
}

void draw() {

  // background(0);
  noStroke();

  u = odes.rk4(t, u, h);
  Position.set(u[0], u[2]);
  Position2.set(u[4], u[6]);

  t += h;

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
} //<>//

void keyPressed() {
  if (key == ' ') {
    mode++;
    mode %= 3;
  }
}
