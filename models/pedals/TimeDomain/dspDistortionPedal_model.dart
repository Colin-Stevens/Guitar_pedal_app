import 'package:flutter_application_1/models/atribute_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';

class DspDistortionPedal extends Pedal {
  DspDistortionPedal() : super("Overdrive Pedal",
  [PedalAtribute(0, 10, 0.5,'Gain'),
  PedalAtribute(0, 10, 1, "Smooth")]);
}
