import 'package:flutter_application_1/models/atribute_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';

class AnalogDistortionPedal extends Pedal {
  AnalogDistortionPedal() : super("Analog Distortion Pedal",
  [PedalAtribute(0, 10, 0.5, 'Gain')]);
}
