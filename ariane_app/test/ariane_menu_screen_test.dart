import 'package:ariane_app/providers/language_provider.dart';
import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_menu_screen.dart';
import 'package:ariane_app/screens/labyrinth_game_page.dart';
import 'package:ariane_app/screens/calcul_game_page.dart';
import 'package:ariane_app/screens/scratch_game_page.dart';
import 'package:provider/provider.dart';

void main() {
  group('ArianeMenuScreen', () {
    testWidgets('Labyrinth card navigates to LabyrinthGamePage', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..setLocale(const Locale('en')),
          child: MaterialApp(
            home: const ArianeMenuScreen(),
            routes: {
              '/labyrinth': (context) => LabyrinthePage(),
            },
          ),
        ),
      );
      final BuildContext context = tester.element(find.byType(ArianeMenuScreen));
      // Find the Labyrinth card and tap it
      await tester.tap(find.text(AppStrings.get(context, 'labyrinthe')));
      await tester.pumpAndSettle();

      // Verify that LabyrinthGamePage is pushed onto the navigator
      expect(find.byType(LabyrinthePage), findsOneWidget);
    });

    testWidgets('Calcul card navigates to CalculGamePage', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..setLocale(const Locale('en')),
          child: MaterialApp(
            home: const ArianeMenuScreen(),
            routes: {
              '/calcul': (context) => CalculPage(),
            },
          ),
        ),
      );
      final BuildContext context = tester.element(find.byType(ArianeMenuScreen));
      // Find the Calcul card and tap it
      await tester.tap(find.text(AppStrings.get(context, 'calcul')));
      await tester.pumpAndSettle();

      // Verify that CalculGamePage is pushed onto the navigator
      expect(find.byType(CalculPage), findsOneWidget);
    });

    testWidgets('Scratch card navigates to ScratchGamePage', (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider()..setLocale(const Locale('en')),
          child: MaterialApp(
            home: const ArianeMenuScreen(),
            routes: {
              '/scratch': (context) => ScratchPage(),
            },
          ),
        ),
      );
      final BuildContext context = tester.element(find.byType(ArianeMenuScreen));
      // Find the Scratch card and tap it
      await tester.tap(find.text(AppStrings.get(context, 'scratch')));
      await tester.pumpAndSettle();

      // Verify that ScratchGamePage is pushed onto the navigator
      expect(find.byType(ScratchPage), findsOneWidget);
    });
  });
}
