import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/app_bloc.dart';
import 'package:flutter_application_1/bloc/app_repository.dart';
import 'package:flutter_application_1/loadingScreen/loadingScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'homePage/homePage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// void main() {
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AppRepository(),
        child: BlocProvider(
            create: (context) =>
                AppBloc(RepositoryProvider.of<AppRepository>(context))
                  ..add(LoadAppEvent()),
            child: HomePage()));
  }
}

class ScreenManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is DisplayLoadingScreen) {
        return LoadingScreen();
      } else if (state is DisplayPedalBoardGrid) {
        return HomePage();
      } else {
        return HomePage();
      }
    });
  }
}
