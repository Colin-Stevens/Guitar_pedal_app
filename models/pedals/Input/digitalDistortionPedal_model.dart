import 'package:flutter_application_1/models/atribute_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';

class DigitalDistortionPedal extends Pedal {
  DigitalDistortionPedal() : super("Digital Distortion Pedal",
  [PedalAtribute(0, 10, 0.5, 'Gain')]);
}
