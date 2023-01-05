import 'package:flutter_application_1/models/pedal_model.dart';
class PedalBoardModel {
  String id;
  String config;
  bool isActive;
  List<Pedal> pedals = [];

  PedalBoardModel(this.id, this.config, this.isActive);
  PedalBoardModel.noConfig()
      : this.id = "",
        this.config = "No Config",
        this.isActive = false;

  // PedalBoardModel.fromJson(Map<String, dynamic> json)
  //     : id = json['PedalModel_id'],
  //       config = json['PedalModel_config'],
  //       isActive = json['PedalModel_isActive'];

  // Map<String, dynamic> toJson() => {
  //       'PedalModel_id': id,
  //       'PedalModel_config': config,
  //       'PedalModel_isActive': isActive,
  //     };
}
