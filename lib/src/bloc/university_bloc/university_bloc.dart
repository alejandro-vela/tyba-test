import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:tyba_test/src/bloc/university_bloc/university_bloc_event.dart';
import 'package:tyba_test/src/bloc/university_bloc/university_bloc_state.dart';
import 'package:tyba_test/src/repository/models/university.dart';

import '../../../global_locator.dart';
import '../../repository/endpoints/university_repository.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  UniversityBloc() : super(GetUniversityInitial());
  List<UniversityModel>? staticData = [];

  var universityRepository = global<UniversityRepository>();

  @override
  Stream<UniversityState> mapEventToState(UniversityEvent event) async* {
    if (event is GetUniversitysEvent) {
      yield* _universitiesToState(event);
    } else if (event is NoneEvent) {
      yield NoneState();
    }
  }

  Stream<UniversityState> _universitiesToState(
      GetUniversitysEvent event) async* {
    try {
      if (event.page == 1) {
        var response =
            staticData = await universityRepository.getUniversities();
        if (response != null) {
          List<UniversityModel> results = [];
          for (var i = 0; i < 20 * event.page; i++) {
            results.add(response[i]);
          }
          yield NoneState();
          yield HasUniversityState(universities: results);
        }
      } else {
        List<UniversityModel> results = [];
        for (var i = 0; i < 20 * event.page; i++) {
          results.add(staticData![i]);
        }
        yield NoneState();
        yield HasUniversityState(universities: results);
      }
    } catch (e) {
      yield FinishWithError(
          error:
              'Tenemos problemas para obtener los Universidades, intenta mas tarde');
    }
  }
}
