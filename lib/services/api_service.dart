import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/subject_model.dart';
import '../models/result_model.dart';

class ApiService {
  static const String baseUrl = 'https://6af5d372f6270fa08d68b17c.mockapi.io';

  Future<List<Subject>> fetchSubjects() async {
    final response = await http.get(Uri.parse('$baseUrl/subjects'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => Subject.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки предметов: ${response.statusCode}');
    }
  }

  Future<void> saveResult(TestResult result) async {
    final response = await http.post(
      Uri.parse('$baseUrl/results'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(result.toJson()),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Ошибка сохранения результата: ${response.statusCode}');
    }
  }

  Future<List<TestResult>> fetchResults() async {
    final response = await http.get(Uri.parse('$baseUrl/results'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => TestResult.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки истории: ${response.statusCode}');
    }
  }
}
