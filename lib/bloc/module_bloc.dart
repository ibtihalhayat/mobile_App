/*
import 'package:mobile_app/events/add_module.dart';
import 'package:mobile_app/events/delete_module.dart';
import 'package:mobile_app/events/module_event.dart';
import 'package:mobile_app/events/set_modules.dart';
import 'package:mobile_app/events/update_module.dart';
import 'package:mobile_app/models/module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModuleBloc extends Bloc<ModuleEvent, List<Module>> {
  @override
  List<Module> get initialState => List<Module>();

  @override
  Stream<List<Module>> mapEventToState(ModuleEvent event) async* {
    if (event is SetModules) {
      yield event.moduleList;
    } else if (event is AddModule) {
      List<Module> newState = List.from(state);
      if (event.newModule != null) {
        newState.add(event.newModule);
      }
      yield newState;
    } else if (event is DeleteModule) {
      List<Module> newState = List.from(state);
      newState.removeAt(event.moduleIndex);
      yield newState;
    } else if (event is UpdateModule) {
      List<Module> newState = List.from(state);
      newState[event.moduleIndex] = event.newModule;
      yield newState;
    }
  }
}*/
