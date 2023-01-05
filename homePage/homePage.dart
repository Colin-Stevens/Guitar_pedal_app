import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/connectionSettings/connectionSettings.dart';
import 'package:flutter_application_1/bloc/app_bloc.dart';
import 'package:flutter_application_1/connectionSettings/selectDeviceSettings.dart';
import 'package:flutter_application_1/homePage/createPedalBoardPage.dart';
import 'package:flutter_application_1/homePage/createPedalPage.dart';
import 'package:flutter_application_1/loadingScreen/loadingScreen.dart';
import 'package:flutter_application_1/models/PedalBoard_model.dart';
import 'package:flutter_application_1/settingsPage/settingsPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pedalBoard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Timer connectionTimer;
  int navBarIndex = 0;
  AppBloc bloc;

  /// State Functions
  @override
  void initState() {
    super.initState();
    this.bloc = BlocProvider.of<AppBloc>(context);
    connectionTimer = Timer.periodic(
        Duration(seconds: 5), (Timer t) => checkConnectionStatus());
  }

  @override
  void dispose() {
    connectionTimer.cancel();
    super.dispose();
  }

  /// Device Connection Functions
  checkConnectionStatus() {
    setState(() {
      bloc.state.device.checkConnection();
    });
  }

  /// Generate Different Pages Functions
  genSettingsScreen() {
    return SettingsPage();
  }

  void navBarTap(int index) {
    setState(() {
      navBarIndex = index;
    });
    switch (index) {
      case 0:
        bloc.add(ReturnToPedalGrid());
        break;
      case 1:
        bloc.add(GoToConnectionManager());
        break;
      case 2:
        bloc.add(GoToSettings());
        break;
      default:
        bloc.add(ReturnToPedalGrid());
        break;
    }
  }

  genPedalGrid() {
    List<PedalBoardModel> pedalBoards = bloc.state.pedalBoardlist;
    return GridView.builder(
      itemCount: pedalBoards.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.3,
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10),
      itemBuilder: (_, index) {
        return index <= (pedalBoards.length - 1)
            ? PedalBoardWidget(
                pedalBoards[index].id, pedalBoards[index].isActive)
            : Padding(
                padding: EdgeInsets.all(20),
                child: new FloatingActionButton(
                    onPressed: () {
                      bloc.add(AddPedalBoard(null));
                    },
                    child: new Icon(
                      Icons.add,
                      size: 75,
                    )));
      },
      primary: true,
      padding: const EdgeInsets.all(20),
    );
  }

  genSettings() {
    return SettingsPage();
  }

  genConnectionSettings() {
    if (bloc.state.device.connectionStatus) return ConnectionSettings();
    else return SelectDeviceSettings();
  }

  genPedalBoardPage() {
    return PedalBoard((bloc.state as DisplayPedalBoard).selected);
  }

  genScreenWithNavBar(Function() screen, String title) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.brown.shade900, brightness: Brightness.dark),
        home: Scaffold(
            appBar: AppBar(title: Text(title)),
            body: screen(),
            bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                    backgroundColor: Colors.red,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bluetooth),
                    label: bloc.state.device.connectionStatus
                        ? bloc.state.device.id
                        : "No Device",
                    backgroundColor: Colors.green,
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                    backgroundColor: Colors.pink,
                  ),
                ],
                currentIndex: navBarIndex,
                selectedItemColor: Colors.amber[800],
                onTap: navBarTap)));
  }

  @override
  Widget build(BuildContext context) {
    if (bloc.state is CreatePedalBoard) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 250), child: CreatePedalBoardPage());
    } else if (bloc.state is DisplayPedalBoard) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: genScreenWithNavBar(genPedalBoardPage,
              (bloc.state as DisplayPedalBoard).selected.id));
    } else if (bloc.state is CreatePedal) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 250), child: CreatePedalPage());
    } else if (bloc.state is DisplayConnectionSettings) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: genScreenWithNavBar(
              genConnectionSettings, "Device Connection Settings"));
    } else if (bloc.state is DisplaySettings) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: genScreenWithNavBar(genSettings, "Settings"));
    } else if (bloc.state is DisplayLoadingScreen) {
      return AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: LoadingScreen());
    }
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 250),
        child: genScreenWithNavBar(genPedalGrid, "Home Page"));
  }
}

class PedalBoardWidget extends StatelessWidget {
  final bool isActive;
  final String id;

  const PedalBoardWidget(this.id, this.isActive);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/pedalBoard.png'),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Align(
                alignment: Alignment.topLeft,
                child: new Padding(
                  padding: EdgeInsets.only(top: 10, left: 2),
                  child: Text(
                    id,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          onTap: () {
            BlocProvider.of<AppBloc>(context).add(SelectPedalBoard(id));
          }),
      GestureDetector(
          child: Stack(children: [
            Padding(
                padding: EdgeInsets.only(top: 5, left: 150),
                child: Icon(Icons.power_settings_new,
                    color: isActive ? Colors.green : Colors.white54)),
            Padding(
                padding: EdgeInsets.only(top: 2.5, left: 147.5),
                child: Icon(
                  Icons.circle,
                  color: Colors.black38,
                  size: 30,
                ))
          ]),
          onTap: () {
            BlocProvider.of<AppBloc>(context).add(ActivatePedalBoard(this.id));
          })
    ]);
  }
}
