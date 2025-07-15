import 'package:ariane_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_all_results_screen.dart';
import 'package:provider/provider.dart';

void main() {
  group('ArianeAllResultsScreen', () {
    testWidgets('renders correctly and finds title', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
          child: const MaterialApp(
            home: ArianeAllResultsScreen(),
          ),
        ),
      );

      // Verify that the screen title is present
      expect(find.text('Tous les Résultats'), findsOneWidget);
    });

    testWidgets('finds the clear results button', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
          child: const MaterialApp(
            home: ArianeAllResultsScreen(),
          ),
        ),
      );

      // Verify that the clear results button is present
      expect(find.widgetWithText(ElevatedButton, 'Effacer les résultats'), findsOneWidget);
    });
  });
}
