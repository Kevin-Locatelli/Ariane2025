import 'package:ariane_app/providers/language_provider.dart';
import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_all_results_screen.dart';
import 'package:provider/provider.dart';

void main() {
  group('ArianeAllResultsScreen', () {
    testWidgets('renders correctly and finds title', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..setLocale(const Locale('en')),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return const ArianeAllResultsScreen();
              }
            ),
          ),
        ),
      );
      final BuildContext context = tester.element(find.byType(ArianeAllResultsScreen));
      // Verify that the screen title is present
      expect(find.text(AppStrings.get(context, 'tous_les_resultats')), findsOneWidget);
    });

    testWidgets('finds the clear results button', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..setLocale(const Locale('en')),
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return const ArianeAllResultsScreen();
              }
            ),
          ),
        ),
      );
      final BuildContext context = tester.element(find.byType(ArianeAllResultsScreen));
      // Verify that the clear results button is present
      expect(find.widgetWithText(ElevatedButton, AppStrings.get(context, 'effacer_les_resultats')), findsOneWidget);
    });
  });
}
