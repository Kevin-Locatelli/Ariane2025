import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/calcul_game_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CalculPage', () {
    setUp(() {
      // Mock SharedPreferences for ScoreManager
      SharedPreferences.setMockInitialValues({}); // Clear any previous values
    });

    testWidgets('renders correctly and finds title and instructions', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CalculPage(),
        ),
      );

      // Verify that the screen title is present
      expect(find.text('Calcul'), findsOneWidget);

      // Verify instructions are present
      expect(find.text('Saisi dans la zone de texte le résultat du calcul :'), findsOneWidget);
    });

    testWidgets('finds Reset and Valider buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CalculPage(),
        ),
      );

      // Verify that the Reset button is present
      expect(find.text('Reset'), findsOneWidget);

      // Verify that the Valider button is present
      expect(find.text('Valider'), findsOneWidget);
    });

    testWidgets('generates a question on init', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CalculPage(),
        ),
      );

      // Expect to find a question in the format 'X + Y = ?'
      // Since the numbers are random, we can't check for specific numbers,
      // but we can check for the pattern.
      expect(find.textContaining(RegExp(r'\d+ \+ \d+ = \?')), findsOneWidget);
    });

    // Note: Testing the drawing and recognition logic (_recognizeDigit) is complex
    // in a widget test as it involves CustomPainter and TFLite Interpreter.
    // This would typically require integration tests or dedicated unit tests
    // for the recognition logic itself, potentially mocking the TFLite interpreter.
  });
}
