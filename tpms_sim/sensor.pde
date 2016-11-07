
class Sensor {
  int dir;
  ModuleFloat angle;

  Sensor(float offset) {
    angle = new ModuleFloat(offset, 2*PI);
  }

  void update(float _angle) {
    if (dir != 0) {
      angle.add(_angle);
    } else {
      angle.sub(_angle);
    }
  }

  float getAngle() {
    return angle.value;
  }
}