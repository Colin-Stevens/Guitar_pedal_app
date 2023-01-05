import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/bloc/app_bloc.dart';
import 'package:flutter_application_1/models/PedalBoard_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePedalBoardPage extends StatefulWidget {
  @override
  _CreatePedalBoardPage createState() => _CreatePedalBoardPage();
}

class _CreatePedalBoardPage extends State<CreatePedalBoardPage> {
  String name;
  String peddalBoardConfig;
  AppBloc bloc;

  @override
  initState() {
    super.initState();
    this.bloc = BlocProvider.of<AppBloc>(context);
    this.peddalBoardConfig = "No Config";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.brown.shade900, brightness: Brightness.dark),
        home: Scaffold(
          appBar: AppBar(title: Text('Create a new Pedal')),
          body: Container(
              child: Align(
            alignment: Alignment.topLeft,
            child: TextField(
              onChanged: (text) {
                this.name = text;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter pedal name',
              ),
            ),
          )),
          floatingActionButton: new FloatingActionButton(
              onPressed: () {
                bloc
                  ..add(AddPedalBoard(PedalBoardModel(
                      this.name, this.peddalBoardConfig, false)));
              },
              child: new Icon(Icons.backspace)),
        ));
  }
}
