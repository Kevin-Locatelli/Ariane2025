import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_result_screen.dart';

void main() {
  group('ArianeResultScreen', () {
    testWidgets('renders correctly with given parameters', (WidgetTester tester) async {
      const int testScore = 100;
      const String testMessage = 'Well done!';
      const String testGameName = 'Test Game';

      await tester.pumpWidget(
        const MaterialApp(
          home: ArianeResultScreen(
            score: testScore,
            message: testMessage,
            gameName: testGameName,
          ),
        ),
      );

      // Verify that the title contains the game name
      expect(find.text('Résultat du $testGameName'), findsOneWidget);

      // Verify that the message and score are displayed
      expect(find.text(testMessage), findsOneWidget);
      expect(find.text('Score: $testScore'), findsOneWidget);

      // Verify that the 'Retour au menu' button is present
      expect(find.widgetWithText(ElevatedButton, 'Retour au menu'), findsOneWidget);
    });
  });
}
