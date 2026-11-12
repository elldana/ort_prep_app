import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/result_model.dart';
import '../../services/api_service.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final ApiService apiService;

  QuizBloc(this.apiService) : super(QuizInitial()) {
    on<StartQuiz>((event, emit) {
      emit(
        QuizInProgress(
          subject: event.subject,
          currentIndex: 0,
          score: 0,
          selectedOptionIndex: null,
        ),
      );
    });

    on<SelectAnswer>((event, emit) {
      final currentState = state;
      if (currentState is QuizInProgress && !currentState.isAnswered) {
        final isCorrect =
            event.selectedIndex == currentState.currentQuestion.correctIndex;
        emit(
          QuizInProgress(
            subject: currentState.subject,
            currentIndex: currentState.currentIndex,
            score: isCorrect ? currentState.score + 1 : currentState.score,
            selectedOptionIndex: event.selectedIndex,
          ),
        );
      }
    });

    on<NextQuestion>((event, emit) async {
      final currentState = state;
      if (currentState is QuizInProgress) {
        if (!currentState.isLastQuestion) {
          emit(
            QuizInProgress(
              subject: currentState.subject,
              currentIndex: currentState.currentIndex + 1,
              score: currentState.score,
              selectedOptionIndex: null,
            ),
          );
        } else {
          emit(QuizSubmitting());
          try {
            final result = TestResult(
              subjectTitle: currentState.subject.title,
              score: currentState.score,
              total: currentState.subject.questions.length,
              createdAt: DateTime.now().toIso8601String(),
            );
            await apiService.saveResult(result);
            emit(
              QuizCompleted(
                subjectTitle: result.subjectTitle,
                score: result.score,
                total: result.total,
              ),
            );
          } catch (e) {
            emit(QuizError(e.toString()));
          }
        }
      }
    });
  }
}
