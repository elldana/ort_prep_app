import 'package:flutter_test/flutter_test.dart';
import 'package:ort_prep_app/main.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const OrtPrepApp());
    expect(find.text('Подготовка к ОРТ'), findsOneWidget);
  });
}
