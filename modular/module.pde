class ModuleInt {
  int mod;
  int value;

  ModuleInt(int _value, int _mod) {
    value = _value;
    mod = _mod;
  }
  void add(ModuleInt a) {
    value += a.value;
    value += mod;
    value %= mod;
  }
  void sub(ModuleInt a) {
    value -= a.value;
    value += mod;
    value %= mod;
  }
  void add(int a) {
    value += a;
    value += mod;
    value %= mod;
  }
  void sub(int a) {
    value -= a;
    value += mod;
    value %= mod;
  }
}

class ModuleFloat {
  float mod;
  float value;

  ModuleFloat(float _value, float _mod) {
    value = _value;
    mod = _mod;
  }
  void add(ModuleFloat a) {
    int n;
    value += a.value;
    value += mod;
    n = int(value/mod);
    value -= n*mod;
  }
  void sub(ModuleFloat a) {
    int n;
    value -= a.value;
    value += mod;
    n = int(value/mod);
    value -= n*mod;
  }
  void add(float a) {
    int n;
    value += a;
    value += mod;
    n = int(value/mod);
    value -= n*mod;
  }
  void sub(float a) {
    int n;
    value -= a;
    value += mod;
    n = int(value/mod);
    value -= n*mod;
  }
}