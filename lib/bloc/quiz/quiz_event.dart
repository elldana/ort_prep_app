import 'package:equatable/equatable.dart';

import '../../models/subject_model.dart';

abstract class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartQuiz extends QuizEvent {
  final Subject subject;
  StartQuiz(this.subject);

  @override
  List<Object?> get props => [subject];
}

class SelectAnswer extends QuizEvent {
  final int selectedIndex;
  SelectAnswer(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

class NextQuestion extends QuizEvent {}
