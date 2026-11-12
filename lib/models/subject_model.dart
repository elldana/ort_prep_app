class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'].toString(),
      questionText: json['questionText'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correctIndex'] ?? 0,
    );
  }
}

class Subject {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;

  Subject({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    final questionsJson = json['questions'] as List<dynamic>? ?? [];
    return Subject(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questions: questionsJson.map((q) => Question.fromJson(q)).toList(),
    );
  }
}
