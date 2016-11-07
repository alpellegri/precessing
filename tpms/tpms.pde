 //<>//
float[] a;

Sensor[] sensor;
Abs[] abs;

float t, dt, v;
float r;
float w0, f0;
float[] w;
int N=1;
int i;
int k;

void setup() {
  frameRate(4000);
  size(1024, 640);
  background(0);
  t=0;
  r=0.5;
  v=150; // km/h
  w0=(v/r)/3.6;
  // w0=2*PI;
  k=1000;
  println(w0);
  f0 = w0/(2*PI);
  println(f0);

  a = new float[N];
  w = new float[N];

  sensor = new Sensor[N];
  for (i=0; i<N; i++) {
    sensor[i] = new Sensor(0);
  }
  // init
  sensor[0].dir = 0;
  // sensor[1].dir = 1;

  abs = new Abs[N];
  for (i=0; i<N; i++) {
    abs[i] = new Abs(0, 48, 255);
  }

  for (i=0; i<N; i++) {
    w[i] = w0;
  }

  dt=.001;

  background(0);
  stroke(150,150,150,50);
  translate(0, height/2);
  for (i=0; i<N; i++) {
    line(0, 200*i, width, 200*i);
  }
  line(0, -200, width, -200);
  for (i=0; i<width; i=i+k) {
    line(i, -height/2, i, height/2);
  }
}

void draw() {
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

  // update display
  translate(0, height/2); //<>//
  if (k*t > width) {
    t = 0;
    background(0);
    stroke(150,150,150,50);
    for (i=0; i<N; i++) {
      line(0, 200*i, width, 200*i);
    }
    for (i=0; i<width; i=i+k) {
      line(i, -height/2, i, height/2);
    }
  }

  for (i=0; i<N; i++) {
    stroke(200,0,0,90);
    point(k*t, 200*i-sensor[i].getAngle());
    stroke(0,200,0,90);
    point(k*t, 200*i-abs[i].getPulse());
  }
  stroke(0,0,200,90);
  point(k*t, -200-a[0]);

  t+=dt;
}

void keyPressed() {
  if (key =='q') {
    w[0] += .01;
    w[1] += .01;
    println(w[0], w[1]);
  }
  if (key =='a') {
    w[0] -= .01;
    w[1] -= .01;
    println(w[0], w[1]);
  }
  if (key =='n') {
    w[0] -= .01;
    w[1] += .01;
    println(w[0], w[1]);
  }
  if (key =='m') {
    w[0] += .01;
    w[1] -= .01;
    println(w[0], w[1]);
  }
}