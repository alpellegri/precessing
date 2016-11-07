class Tpms { //<>//
  // 
  int N;
  // pulse angle observer
  ModuleInt[] PulseAngle;
  // pulse observer
  ModuleInt[] Pulse;
  int npulse;
  int ppr;
  float[][] correlator;

  Tpms(int _N, int _npulse, int _ppr) {
    int i;

    N = _N;
    npulse = _npulse;
    ppr = _ppr;
    PulseAngle = new ModuleInt[N];
    Pulse = new ModuleInt[N];
    for (i=0; i<N; i++) {
      PulseAngle[i] = new ModuleInt(0, ppr);
      Pulse[i] = new ModuleInt(0, npulse);
    }
    correlator = new float[N][N];
  }

  void update(Sensor[] _sensor, Abs[] _abs, int trig)
  {
    int i, j;

    ModuleFloat da = new ModuleFloat(0, 2*PI);
    // delta pulse
    ModuleInt dp = new ModuleInt(0, npulse);

    if (1==1) {
      int pulses;
      for (i=0; i<N; i++) {
        pulses = _abs[i].getPulse();
        dp.value = pulses;
        dp.sub(Pulse[i].value);
        // update obesevers;
        Pulse[i].value = pulses;
        PulseAngle[i].add(dp.value);
        // print(i + " >" + pulses + " d: " + dp.value + " pa: " + PulseAngle[i].value + "\n");
      }
    }

    if (0 == 1) {
      da.value = _sensor[0].getAngle();
      // da.sub(_abs[0].getAngle());
      da.sub(PulseAngle[0].value*2*PI/ppr);
      print("[00] " + da.value);

      da.value = _sensor[1].getAngle();
      // da.sub(_abs[0].getAngle());
      da.sub(PulseAngle[0].value*2*PI/ppr);
      print(" [01] " + da.value);

      da.value = _sensor[0].getAngle();
      // da.sub(_abs[1].getAngle());
      da.sub(PulseAngle[1].value*2*PI/ppr);
      print(" [10] " + da.value);

      da.value = _sensor[1].getAngle();
      // da.sub(_abs[1].getAngle());
      da.sub(PulseAngle[1].value*2*PI/ppr);
      print(" [11] " + da.value);
      print("\n");
    }

    if (trig == 1) {
      for (j=0; j<N; j++) {
        for (i=0; i<N; i++) {
          da.value = _sensor[j].getAngle();
          da.sub(PulseAngle[i].value*2*PI/ppr);
          correlator[j][i] = da.value;
          print("[" + j + i + "] " + da.value + " ");
        }
      }
      print("\n");
    }
  }

  void display() {
  }
}
  