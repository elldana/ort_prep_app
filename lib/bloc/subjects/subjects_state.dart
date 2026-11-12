import 'package:equatable/equatable.dart';

import '../../models/subject_model.dart';
import '../../models/result_model.dart';

abstract class SubjectsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubjectsInitial extends SubjectsState {}

class SubjectsLoading extends SubjectsState {}

class SubjectsLoaded extends SubjectsState {
  final List<Subject> subjects;
  final List<TestResult> recentResults;

  SubjectsLoaded({required this.subjects, required this.recentResults});

  @override
  List<Object?> get props => [subjects, recentResults];
}

class SubjectsError extends SubjectsState {
  final String message;

  SubjectsError(this.message);

  @override
  List<Object?> get props => [message];
}
