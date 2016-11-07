
class Abs {
  ModuleFloat angle;
  ModuleInt pulse;
  float reminder;
  int ppr; // pulse per rotation

  Abs(float offset, int _ppr, int npulse) {
    angle = new ModuleFloat(offset, 2*PI);
    pulse = new ModuleInt(0, npulse);
    ppr = _ppr;
    reminder = 0;
  }

  void update(float _angle) {
    float d;
    int i;
    angle.add(_angle);
    d = ppr*_angle/(2*PI) + reminder;
    i = int(d);
    // print(angle.value, i, reminder*2*PI/ppr, "\n");
    reminder = (d-i);
    pulse.add(i);
  }

  float getPulse() {
    return pulse.value;
  }
  float getAngle() {
    return angle.value;
  }
}