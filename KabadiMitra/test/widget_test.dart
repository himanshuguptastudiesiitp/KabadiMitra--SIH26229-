import 'package:flutter_test/flutter_test.dart';
import 'package:kabadiwala_connect/main.dart';

void main() {
  testWidgets('app boots to login', (WidgetTester tester) async {
    await tester.pumpWidget(const KabadiwalaApp());
    expect(find.text('कबाड़ी मित्र'), findsWidgets);
  });
}
