import 'dart:ffi';

class PedalAtribute {
  double minValue;
  double maxValue;
  double stepSize;
  double currValue;
  String id;

  PedalAtribute.setCurrentValue(
      this.minValue, this.maxValue, this.stepSize, this.currValue, this.id);
  PedalAtribute(this.minValue, this.maxValue, this.stepSize, this.id)
      : this.currValue = minValue;
}
