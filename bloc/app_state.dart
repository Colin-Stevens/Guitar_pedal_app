part of 'app_bloc.dart';

List<PedalBoardModel> genPedalBoardListFromJson(Map<String, dynamic> json) {
  return (json['pedalBoardlist'] as List<PedalBoardModel>);
}

ConnectionManager genDeviceFromJson(Map<String, dynamic> json) {
  return (json['device'] as ConnectionManager);;
}

PedalBoardModel genPedalBoardModelFromJson(Map<String, dynamic> json){
  return (json['selected'] as PedalBoardModel);
}

abstract class AppState extends Equatable {
  final List<PedalBoardModel> pedalBoardlist;
  final ConnectionManager device;
  final String stateID;

  AppState(this.pedalBoardlist, this.device, this.stateID);
  AppState.fromJson(Map<String, dynamic> json, String stateID)
      : this.pedalBoardlist = genPedalBoardListFromJson(json),
        this.device = genDeviceFromJson(json),
        this.stateID = stateID;

  @override
  List<Object> get props => [pedalBoardlist, device, stateID];

  Map<String, dynamic> toJson() {
    return {
      'pedalBoardlist': pedalBoardlist,
      'device': device,
      'stateID': stateID
    };
  }
}

class CreatePedalBoard extends AppState {
  CreatePedalBoard(
      List<PedalBoardModel> pedalBoardlist, ConnectionManager device)
      : super(pedalBoardlist, device, 'CreatePedalBoard');
  CreatePedalBoard.fromJson(Map<String, dynamic> json, String stateID)
      : super.fromJson(json, stateID);
}

class DisplayPedalBoardGrid extends AppState {
  DisplayPedalBoardGrid(
      List<PedalBoardModel> pedalBoardlist, ConnectionManager device)
      : super(pedalBoardlist, device, 'DisplayPedalBoardGrid');
  DisplayPedalBoardGrid.fromJson(Map<String, dynamic> json, String stateID)
      : super.fromJson(json, stateID);
}

class ActivatePedalBoardState extends AppState {
  ActivatePedalBoardState(
      List<PedalBoardModel> pedalBoardlist, ConnectionManager device)
      : super(pedalBoardlist, device, 'ActivatePedalBoardState');
  ActivatePedalBoardState.fromJson(Map<String, dynamic> json, String stateID)
      : super.fromJson(json, stateID);
}

class DisplayPedalBoard extends AppState {
  final PedalBoardModel selected;

  DisplayPedalBoard(List<PedalBoardModel> pedalBoardlist,
      ConnectionManager device, this.selected)
      : super(pedalBoardlist, device, 'DisplayPedalBoard');
  DisplayPedalBoard.fromJson(Map<String, dynamic> json, String stateID)
      : this.selected = genPedalBoardModelFromJson(json), super.fromJson(json, stateID);

  @override
  List<Object> get props => [super.props, device, selected];

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'selected': selected};
  }
}

class CreatePedal extends AppState {
  final PedalBoardModel selected;

  CreatePedal(List<PedalBoardModel> pedalBoardlist, ConnectionManager device,
      this.selected)
      : super(pedalBoardlist, device, 'CreatePedal');
  CreatePedal.fromJson(Map<String, dynamic> json, String stateID)
      : this.selected = genPedalBoardModelFromJson(json), super.fromJson(json, stateID);

  @override
  List<Object> get props => [super.props, device, selected];

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'selected': selected};
  }
}

class DisplayConnectionSettings extends AppState {
  DisplayConnectionSettings(
      List<PedalBoardModel> pedalBoardlist, ConnectionManager device)
      : super(pedalBoardlist, device, 'DisplayConnectionSettings');
  DisplayConnectionSettings.fromJson(Map<String, dynamic> json, String stateID)
      : super.fromJson(json, stateID);
}

class DisplaySettings extends AppState {
  DisplaySettings(
      List<PedalBoardModel> pedalBoardlist, ConnectionManager device)
      : super(pedalBoardlist, device, 'DisplaySettings');
  DisplaySettings.fromJson(Map<String, dynamic> json, String stateID)
      : super.fromJson(json, stateID);
}

class DisplayLoadingScreen extends AppState {
  DisplayLoadingScreen(
      List<PedalBoardModel> pedalBoardlist, ConnectionManager device)
      : super(pedalBoardlist, device, 'DisplayLoadingScreen');

  DisplayLoadingScreen.fromJson(Map<String, dynamic> json, String stateID)
      : super.fromJson(json, stateID);
}
