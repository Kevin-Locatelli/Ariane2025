import 'package:ariane_app/providers/language_provider.dart';
import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_screen.dart';
import 'package:provider/provider.dart';

void main() {
  group('ArianeScreen', () {
    testWidgets('renders correctly and finds title', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return const ArianeScreen();
              }
            ),
          ),
        ),
      );

      // Verify that the screen title is present
      expect(find.text('Ariane'), findsOneWidget);
    });

    testWidgets('finds the COMMENCER button', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return const ArianeScreen();
              }
            ),
          ),
        ),
      );

      // Verify that the COMMENCER button is present
      final BuildContext context = tester.element(find.byType(ArianeScreen));
      expect(find.widgetWithText(ElevatedButton, AppStrings.get(context, 'commencer')), findsOneWidget);
    });
  });
}
