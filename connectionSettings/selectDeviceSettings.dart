import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDeviceSettings extends StatelessWidget {
  final Color oddTileColor = Colors.white54;
  final Color evenTileColor = Colors.white70;
  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    List<String> availableDevices = bloc.state.device.getAvailbeDevices();
    return Stack(
      children: [
        ListView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            children: <Widget>[
              for (int index = 0; index < availableDevices.length; index += 1)
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  //key: Key('${availableDevices[index]}'),
                  child: ListTile(
                    //Key can be used to prevent adding same pedal
                    tileColor: index.isOdd ? oddTileColor : evenTileColor,
                    title: Text('${availableDevices[index]}'),
                    onTap: (){bloc.state.device.connectToDevice(availableDevices[index]);},),
                  ),
            ])
      ],
    );
  }
}
