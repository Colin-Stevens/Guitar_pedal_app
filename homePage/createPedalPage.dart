import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/bloc/app_bloc.dart';
import 'package:flutter_application_1/models/PedalBoard_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';
import 'package:flutter_application_1/models/pedals/FreqDomain/dspDistortionPedal_model.dart';
import 'package:flutter_application_1/models/pedals/Input/alcPedal_model.dart';
import 'package:flutter_application_1/models/pedals/Input/analogDistortionPedal_model.dart';
import 'package:flutter_application_1/models/pedals/Input/digitalDistortionPedal_model.dart';
import 'package:flutter_application_1/models/pedals/Input/noiseGate_model.dart';
import 'package:flutter_application_1/models/pedals/TimeDomain/dspDistortionPedal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePedalPage extends StatefulWidget {
  final List<Pedal> pedals = [
    TonePedal(),
    ALC(),
    AnalogDistortionPedal(),
    DigitalDistortionPedal(),
    NoiseGate(),
    DspDistortionPedal()
  ];
  @override
  _CreatePedalPage createState() => _CreatePedalPage();
}

class _CreatePedalPage extends State<CreatePedalPage> {
  AppBloc bloc;
  PedalBoardModel selectedBoard;
  Color oddTileColor = Colors.white54;
  Color evenTileColor = Colors.white70;
  @override
  initState() {
    super.initState();
    this.bloc = BlocProvider.of<AppBloc>(context);
    selectedBoard = (bloc.state as CreatePedal).selected;
  }

  genListOfPedals() {
    return <Widget>[
      for (int index = 0; index < this.widget.pedals.length; index++)
        Padding(
          padding: EdgeInsets.only(top: 10),
          key: Key('${this.widget.pedals[index].name}'),
          child: ListTile(
            //Key can be used to prevent adding same pedal
            tileColor: index.isOdd ? oddTileColor : evenTileColor,
            title: Text('${this.widget.pedals[index].name}'),
            onTap: () {
              bloc..add(AddPedal(this.widget.pedals[index]));
            },
          ),
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.brown.shade900, brightness: Brightness.dark),
        home: Scaffold(
          appBar: AppBar(title: Text('Select a pedal')),
          body: ListView(
            //shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: genListOfPedals(),
          ),
          floatingActionButton: new FloatingActionButton(
              onPressed: () {
                bloc..add(SelectPedalBoard((bloc.state as CreatePedal).selected.id));
              },
              child: new Icon(Icons.backspace)),
        ));
  }
}
