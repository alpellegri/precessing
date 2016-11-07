
float[] a;

Sensor[] sensor;
Abs[] abs;

Tpms tpms;

float t, tt, dt, v;
float r;
float w0, f0;
float[] w;
int N=2;
int k;

void setup() {
  int i;

  frameRate(800);
  size(1024, 640);
  background(0);

  t=0;
  tt=0;
  r=0.5;
  v=150; // km/h
  w0=(v/r)/3.6;
  k=100;
  // println(w0);
  f0 = w0/(2*PI);
  println(f0);

  a = new float[N];
  w = new float[N];

  sensor = new Sensor[N];
  for (i=0; i<N; i++) {
    sensor[i] = new Sensor(random(0, 2*PI));
  }
  // init
  sensor[0].dir = 1;
  sensor[1].dir = 1;

  abs = new Abs[N];
  for (i=0; i<N; i++) {
    abs[i] = new Abs(random(0, 2*PI), 48, 256);
  }

  tpms = new Tpms(2, 256, 48);
  for (i=0; i<N; i++) {
    w[i] = w0;
  }

  dt=.001;

  background(0);
  stroke(150,150,150,50);
  translate(0, height/2);
  for (i=0; i<N; i++) {
    line(0, 100*i, width, 100*i);
  }
  line(0, -100, width, -100);
  for (i=0; i<width; i=i+k) {
    line(i, -height/2, i, height/2);
  }
}

void draw() {
  int trig;
  int i,j;

  // update display
  translate(0, height/2);
  if (k*t >= width) {
    t -= width/k;
    background(0);
    stroke(150,150,150,50);
    for (i=0; i<N; i++) {
      line(0, 100*i, width, 100*i);
    }
    for (i=0; i<width; i=i+k) {
      line(i, -height/2, i, height/2);
    }
  }

  for (i=0; i<N; i++) {
    // update angle
    a[i] += w[i] * dt;
    if (a[i] >= 2*PI) {
      a[i] -= 2*PI;
    }
    if (a[i] < 0) {
      a[i] += 2*PI;
    }
    sensor[i].update(w[i] * dt);
    abs[i].update(w[i] * dt);
  }
  // println(a[0]);

  // tpms solver
  if (tt >= 1.0) {
    tt -= 1.0;
    trig = 1;
  } else {
    trig = 0;
  }
  tt += dt;
  tpms.update(sensor, abs, trig);

  stroke(0,0,200,90);
  point(k*t, -100-a[0]);

  for (i=0; i<N; i++) {
    stroke(200,0,0,90);
    point(k*t, 100*i-sensor[i].getAngle());
    stroke(0,200,0,90);
    if (sensor[i].dir != 0) {
      point(k*t, 100*i-abs[i].getPulse());
    } else {
      point(k*t, 100*i-(255-abs[i].getPulse()));
    }
  }

  for (j=0; j<N; j++) {
    for (i=0; i<N; i++) {
      point(k*t, 150+100*j+50*i-5*tpms.correlator[j][i]);
    }
  }

  t+=dt;
}

void keyPressed() {
  if (key =='q') {
    w[0] += .1;
    w[1] += .1;
    println(w[0], w[1]);
  }
  if (key =='a') {
    w[0] -= .1;
    w[1] -= .1;
    println(w[0], w[1]);
  }
  if (key =='n') {
    w[0] -= .1;
    w[1] += .1;
    println(w[0], w[1]);
  }
  if (key =='m') {
    w[0] += .1;
    w[1] -= .1;
    println(w[0], w[1]);
  }
}
  