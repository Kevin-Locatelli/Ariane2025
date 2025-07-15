import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/ariane_menu_screen.dart';
import 'package:ariane_app/screens/labyrinth_game_page.dart';
import 'package:ariane_app/screens/calcul_game_page.dart';
import 'package:ariane_app/screens/scratch_game_page.dart';

void main() {
  group('ArianeMenuScreen', () {
    testWidgets('Labyrinth card navigates to LabyrinthGamePage', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const ArianeMenuScreen(),
        routes: {
          '/labyrinth': (context) => LabyrinthePage(),
        },
      ));

      // Find the Labyrinth card and tap it
      await tester.tap(find.text('Labyrinthe'));
      await tester.pumpAndSettle();

      // Verify that LabyrinthGamePage is pushed onto the navigator
      expect(find.byType(LabyrinthePage), findsOneWidget);
    });

    testWidgets('Calcul card navigates to CalculGamePage', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const ArianeMenuScreen(),
        routes: {
          '/calcul': (context) => CalculPage(),
        },
      ));

      // Find the Calcul card and tap it
      await tester.tap(find.text('Calcul'));
      await tester.pumpAndSettle();

      // Verify that CalculGamePage is pushed onto the navigator
      expect(find.byType(CalculPage), findsOneWidget);
    });

    testWidgets('Scratch card navigates to ScratchGamePage', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const ArianeMenuScreen(),
        routes: {
          '/scratch': (context) => ScratchPage(),
        },
      ));

      // Find the Scratch card and tap it
      await tester.tap(find.text('Scratch'));
      await tester.pumpAndSettle();

      // Verify that ScratchGamePage is pushed onto the navigator
      expect(find.byType(ScratchPage), findsOneWidget);
    });
  });
}
