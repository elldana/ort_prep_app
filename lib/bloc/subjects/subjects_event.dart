import 'package:equatable/equatable.dart';

abstract class SubjectsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSubjects extends SubjectsEvent {}
