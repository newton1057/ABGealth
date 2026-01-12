// Basic Flutter widget smoke test for ABGealth app.

import 'package:flutter_test/flutter_test.dart';
import 'package:demood/main.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DemoodApp());

    // Verify the app renders the login screen (text appears in header and button)
    expect(find.text('Iniciar sesión'), findsWidgets);
    expect(find.text('demood'), findsOneWidget);
  });
}
