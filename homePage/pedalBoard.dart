import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/app_bloc.dart';
import 'package:flutter_application_1/models/PedalBoard_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PedalBoard extends StatefulWidget {
  const PedalBoard(this.pedalBoardModel);
  final PedalBoardModel pedalBoardModel;

  @override
  _PedalBoard createState() => _PedalBoard();
}

class _PedalBoard extends State<PedalBoard> {
  Color oddTileColor = Colors.white54;
  Color evenTileColor = Colors.white70;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ReorderableListView(
        //shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        children: <Widget>[
          for (int index = 0;
              index < this.widget.pedalBoardModel.pedals.length;
              index += 1)
            Padding(
              padding: EdgeInsets.only(top: 10),
              key: Key('${this.widget.pedalBoardModel.pedals[index].name}'),
              child: ListTile(
                //Key can be used to prevent adding same pedal
                tileColor: index.isOdd ? oddTileColor : evenTileColor,
                title:
                    Text('${this.widget.pedalBoardModel.pedals[index].name}'),
              ),
            )
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final Pedal pedal =
                this.widget.pedalBoardModel.pedals.removeAt(oldIndex);
            this.widget.pedalBoardModel.pedals.insert(newIndex, pedal);
          });
        },
      ),
      Align(
          alignment: Alignment.bottomLeft,
          child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<AppBloc>(context).add(AddPedal(null));
              },
              child: Icon(Icons.add)))
    ]);
  }
}
