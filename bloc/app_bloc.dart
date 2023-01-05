import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/app_repository.dart';
import 'package:flutter_application_1/connectionSettings/connectionManager.dart';
import 'package:flutter_application_1/models/PedalBoard_model.dart';
import 'package:flutter_application_1/models/pedal_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends HydratedBloc<AppEvent, AppState> {
  final AppRepository appRepository;
  AppBloc(this.appRepository)
      : super(DisplayLoadingScreen([], ConnectionManager())) {
    on<AddPedalBoard>((event, emit) {
      if (state is CreatePedalBoard) {
        List<PedalBoardModel> tmp = [];
        tmp.addAll(state.pedalBoardlist);
        tmp.add(event.newPedal);

        emit(DisplayPedalBoardGrid(tmp, state.device));
      } else {
        emit(CreatePedalBoard(state.pedalBoardlist, state.device));
      }
    });
    on<ReturnToPedalGrid>((event, emit) {
      emit(DisplayPedalBoardGrid(state.pedalBoardlist, state.device));
    });
    on<ActivatePedalBoard>((event, emit) {
      if (state is DisplayPedalBoardGrid) {
        for (PedalBoardModel currPedalBoard in state.pedalBoardlist) {
          currPedalBoard.isActive = currPedalBoard.id == event.id;
        }
        emit(ActivatePedalBoardState(state.pedalBoardlist, state.device));
        // DO Activating stuff
        emit(DisplayPedalBoardGrid(state.pedalBoardlist, state.device));
      }
    });
    on<SelectPedalBoard>((event, emit) {
      PedalBoardModel selected;
      for (PedalBoardModel currPedalBoard in state.pedalBoardlist) {
        currPedalBoard.id == event.id
            ? selected = currPedalBoard
            : selected = selected;
      }
      emit(DisplayPedalBoard(state.pedalBoardlist, state.device, selected));
    
    });
    on<AddPedal>((event, emit) {
      if (state is CreatePedal) {
        (state as CreatePedal).selected.pedals.add(event.newPedal);
        emit(DisplayPedalBoard(state.pedalBoardlist, state.device,
            (state as CreatePedal).selected));
      } else {
        emit(CreatePedal(
            state.pedalBoardlist,
            state.device,
            (state as DisplayPedalBoard).selected));
      }
    });
    on<GoToConnectionManager>((event, emit) {
      emit(DisplayConnectionSettings(state.pedalBoardlist, state.device));
    });
    on<GoToSettings>((event, emit) {
      emit(DisplaySettings(state.pedalBoardlist, state.device));
    });
    on<LoadAppEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(DisplayPedalBoardGrid(state.pedalBoardlist, state.device));
    });
  }

  @override
  AppState fromJson(Map<String, dynamic> json) {
    String stateID = (json['stateID'] as String);
    switch (stateID) {
      case "CreatePedalBoard":
        return CreatePedalBoard.fromJson(json, stateID);
      case "DisplayPedalBoardGrid":
        return DisplayPedalBoardGrid.fromJson(json, stateID);
      case "ActivatePedalBoardState":
        return ActivatePedalBoardState.fromJson(json, stateID);
      case "DisplayPedalBoard":
        return DisplayPedalBoard.fromJson(json, stateID);
      case "CreatePedal":
        return CreatePedal.fromJson(json, stateID);
      case "DisplayConnectionSettings":
        return DisplayConnectionSettings.fromJson(json, stateID);
      case "DisplaySettings":
        return DisplaySettings.fromJson(json, stateID);
      case "DisplayLoadingScreen":
        return DisplayLoadingScreen.fromJson(json, stateID);
      default:
        return DisplayLoadingScreen([], ConnectionManager());
    }
    // try {
    //   final listOfTodo = (json['todo'] as List)
    //       .map((e) => Todo.fromJson(e as Map<String, dynamic>))
    //       .toList();

    //   todoRepository.todoList = listOfTodo;
    //   return TodoLoaded(listOfTodo);
    // } catch (e) {
    //   return null;
    // }
  }

  @override
  Map<String, dynamic> toJson(AppState state) {
    return state.toJson();
  }
}
