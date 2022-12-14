import 'package:bloc/bloc.dart';
import 'package:tyba_test/src/bloc/university_bloc/university_bloc_event.dart';
import 'package:tyba_test/src/bloc/university_bloc/university_bloc_state.dart';

import '../../../global_locator.dart';
import '../../repository/endpoints/university_repository.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  UniversityBloc() : super(GetUniversityInitial());

  var universityRepository = global<UniversityRepository>();

  @override
  Stream<UniversityState> mapEventToState(UniversityEvent event) async* {
    if (event is GetUniversitysEvent) {
      yield* _universitiesToState(event);
    } else if (event is NoneEvent) {
      yield NoneState();
    }
  }

  Stream<UniversityState> _universitiesToState(UniversityEvent event) async* {
    try {
      var response = await universityRepository.getUniversities();

      if (response != null) {
        yield HasUniversityState(universities: response);
      } else {
        yield FinishWithError(
            error:
                'Tenemos problemas para obtener las Universidades, intenta mas tarde');
      }
    } catch (e) {
      yield FinishWithError(
          error:
              'Tenemos problemas para obtener los Universidades, intenta mas tarde');
    }
  }
}
