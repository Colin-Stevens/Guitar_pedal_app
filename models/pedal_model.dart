import 'package:flutter_application_1/models/atribute_model.dart';

class Pedal {
  String name;
  List<PedalAtribute> effects;

  Pedal(this.name, this.effects);

  String getConfig() {
    String config = "$name;";
    for (PedalAtribute effect in effects) {
      config += "${effect.id};${effect.currValue};";
    }
    return config;
  }
}
