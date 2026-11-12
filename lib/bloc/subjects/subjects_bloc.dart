import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/api_service.dart';
import 'subjects_event.dart';
import 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final ApiService apiService;

  SubjectsBloc(this.apiService) : super(SubjectsInitial()) {
    on<LoadSubjects>((event, emit) async {
      emit(SubjectsLoading());
      try {
        final subjects = await apiService.fetchSubjects();
        final results = await apiService.fetchResults();
        emit(
          SubjectsLoaded(
            subjects: subjects,
            recentResults: results.reversed.toList(),
          ),
        );
      } catch (e) {
        emit(SubjectsError(e.toString()));
      }
    });
  }
}
