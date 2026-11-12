import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/subjects/subjects_bloc.dart';
import 'bloc/subjects/subjects_event.dart';
import 'services/api_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const OrtPrepApp());
}

class OrtPrepApp extends StatelessWidget {
  const OrtPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubjectsBloc(ApiService())..add(LoadSubjects()),
      child: MaterialApp(
        title: 'ОРТ Подготовка',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
