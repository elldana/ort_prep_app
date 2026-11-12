import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/subjects/subjects_bloc.dart';
import '../bloc/subjects/subjects_event.dart';
import '../bloc/subjects/subjects_state.dart';
import '../bloc/quiz/quiz_bloc.dart';
import '../bloc/quiz/quiz_event.dart';
import '../services/api_service.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Подготовка к ОРТ'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<SubjectsBloc>().add(LoadSubjects()),
          ),
        ],
      ),
      body: BlocBuilder<SubjectsBloc, SubjectsState>(
        builder: (context, state) {
          if (state is SubjectsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubjectsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ошибка: ${state.message}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<SubjectsBloc>().add(LoadSubjects()),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is SubjectsLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Выберите раздел ОРТ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...state.subjects.map(
                  (subject) => Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        child: const Icon(Icons.school, color: Colors.indigo),
                      ),
                      title: Text(
                        subject.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${subject.description}\nВопросов: ${subject.questions.length}',
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        if (subject.questions.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('В этом разделе пока нет вопросов'),
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) =>
                                  QuizBloc(ApiService())
                                    ..add(StartQuiz(subject)),
                              child: const QuizScreen(),
                            ),
                          ),
                        ).then((_) {
                          if (context.mounted) {
                            context.read<SubjectsBloc>().add(LoadSubjects());
                          }
                        });
                      },
                    ),
                  ),
                ),
                if (state.recentResults.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text(
                    'История попыток (с сервера)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...state.recentResults
                      .take(5)
                      .map(
                        (res) => Card(
                          color: Colors.grey.shade50,
                          child: ListTile(
                            leading: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text(res.subjectTitle),
                            trailing: Text(
                              '${res.score} / ${res.total}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
