import 'package:ariane_app/providers/language_provider.dart';
import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_result_screen.dart';
import 'package:provider/provider.dart';

void main() {
  group('ArianeResultScreen', () {
    testWidgets('renders correctly with given parameters', (WidgetTester tester) async {
      const int testScore = 100;
      const String testMessage = 'Well done!';
      const String testGameName = 'Test Game';

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..setLocale(const Locale('en')),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return ArianeResultScreen(
                  score: testScore,
                  message: testMessage,
                  gameName: testGameName,
                );
              }
            ),
          ),
        ),
      );

      // Verify that the title contains the game name
      expect(find.byWidgetPredicate((widget) => widget is Text && widget.data!.contains(testGameName)), findsOneWidget);

      // Verify that the message and score are displayed
      expect(find.text(testMessage), findsOneWidget);
      expect(find.text('Score: $testScore'), findsOneWidget);

      // Verify that the 'Retour au menu' button is present
      final BuildContext context = tester.element(find.byType(ArianeResultScreen));
      expect(find.widgetWithText(ElevatedButton, AppStrings.get(context, 'retour_au_menu')), findsOneWidget);
    });
  });
}
