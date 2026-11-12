class TestResult {
  final String? id;
  final String subjectTitle;
  final int score;
  final int total;
  final String createdAt;

  TestResult({
    this.id,
    required this.subjectTitle,
    required this.score,
    required this.total,
    required this.createdAt,
  });

  factory TestResult.fromJson(Map<String, dynamic> json) {
    return TestResult(
      id: json['id']?.toString(),
      subjectTitle: json['subjectTitle'] ?? '',
      score: json['score'] ?? 0,
      total: json['total'] ?? 0,
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectTitle': subjectTitle,
      'score': score,
      'total': total,
      'createdAt': createdAt,
    };
  }
}
