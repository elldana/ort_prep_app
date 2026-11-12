import 'package:equatable/equatable.dart';

import '../../models/subject_model.dart';

abstract class QuizState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizInProgress extends QuizState {
  final Subject subject;
  final int currentIndex;
  final int score;
  final int? selectedOptionIndex;

  QuizInProgress({
    required this.subject,
    required this.currentIndex,
    required this.score,
    this.selectedOptionIndex,
  });

  Question get currentQuestion => subject.questions[currentIndex];
  bool get isAnswered => selectedOptionIndex != null;
  bool get isLastQuestion => currentIndex == subject.questions.length - 1;

  @override
  List<Object?> get props => [
    subject,
    currentIndex,
    score,
    selectedOptionIndex,
  ];
}

class QuizSubmitting extends QuizState {}

class QuizCompleted extends QuizState {
  final String subjectTitle;
  final int score;
  final int total;

  QuizCompleted({
    required this.subjectTitle,
    required this.score,
    required this.total,
  });

  @override
  List<Object?> get props => [subjectTitle, score, total];
}

class QuizError extends QuizState {
  final String message;
  QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
