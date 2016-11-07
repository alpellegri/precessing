
ModuleInt ix = new ModuleInt(0,256);
ModuleInt ix_last = new ModuleInt(0,256);
ModuleInt iy = new ModuleInt(0,16);
ModuleInt iy_last = new ModuleInt(0,16);
ModuleInt id = new ModuleInt(0,16);

ModuleFloat fx = new ModuleFloat(0,8*2*PI);
ModuleFloat fx_last = new ModuleFloat(0,8*2*PI);
ModuleFloat fy = new ModuleFloat(0,2*PI);
ModuleFloat fy_last = new ModuleFloat(0,2*PI);
ModuleFloat fd = new ModuleFloat(0,2*PI);

int i;

void setup() { //<>//
  size(1024, 640);
  background(0);
  translate(0, height/2);
  stroke(255);
  line(0, 0, width, 0);
  frameRate(20);
}

void test1()
{
  ix_last.value = ix.value;
  ix.add(-1);
  iy_last.value = iy.value;
  iy.add(-1);
  id.value = iy.value;
  id.sub(iy_last);
  // print(ix.value, iy.value, id.value, "\n");
  stroke(255,0,0);
  point(i, -ix.value);
  stroke(0,255,0);
  point(i, -iy.value);
}

void test2()
{
  fx_last.value = fx.value;
  fx.add(-1);
  fy_last.value = fy.value;
  fy.add(-1);
  fd.value = fy.value;
  fd.sub(fy_last);
  // print(fx.value, fy.value, fd.value, "\n");
  stroke(255,0,0);
  point(i, -fx.value);
  stroke(0,255,0);
  point(i, -fy.value);
}

void draw() {
  i++;
  if (i>=width) {
    background(0);
    i=0;
  }
  translate(0, height/2);
  //test1();
  test2();
  print(i, "\n");
} //<>//

void keyPressed() {
  if (key =='q') {
  }
  if (key =='a') {
  }
  if (key =='n') {
  }
  if (key =='m') {
  }
}