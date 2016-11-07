
class Abs {
  ModuleFloat angle;
  ModuleInt pulse;
  float reminder;
  int npulse;
  int ppr; // pulse per rotation

  Abs(float offset, int _ppr, int _npulse) {
    npulse = _npulse;
    ppr = _ppr;
    reminder = 0;
    angle = new ModuleFloat(offset, 2*PI);
    pulse = new ModuleInt(0, npulse);
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

  int getPulse() {
    return pulse.value;
  }
  float getAngle() {
    return angle.value;
  }
}