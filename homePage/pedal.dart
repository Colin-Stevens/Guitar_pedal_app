import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/atribute_model.dart';

class PedalWidget extends StatelessWidget {
  final String pedalImage;
  final List<PedalAtribute> effects;
  const PedalWidget(this.pedalImage, this.effects);

  @override
  Widget build(BuildContext context) {
    return Column(children: [Row(
      children: [
        Image(image: AssetImage('assets/images/${this.pedalImage}.png')),
      ],
    )]);
  }
}
