import 'package:flutter_application_1/models/atribute_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';

class TonePedal extends Pedal {
  TonePedal()
      : super("Tone Pedal", [
          PedalAtribute(0, 10, 0.5, 'Bass'),
          PedalAtribute(0, 10, 1, "Trebble"),
          PedalAtribute(0, 10, 1, "Mid"),
        ]);
}
