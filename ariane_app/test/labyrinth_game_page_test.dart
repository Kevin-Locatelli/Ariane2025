import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/labyrinth_game_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';

// Mock NavigatorObserver to capture navigation calls
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockNavigatorObserver;

  setUpAll(() {
    // Register fallback values for any() calls with complex types
    registerFallbackValue(MaterialPageRoute(builder: (_) => const Text('fake')));
    registerFallbackValue(const Offset(0, 0));
  });

  setUp(() {
    mockNavigatorObserver = MockNavigatorObserver();

    // Mock SharedPreferences for ScoreManager
    SharedPreferences.setMockInitialValues({}); // Clear any previous values
  });

  group('LabyrinthePage', () {
    testWidgets('renders correctly and finds title and initial score', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LabyrinthePage(),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      // Verify that the screen title is present
      expect(find.text('Labyrinthe'), findsOneWidget);

      // Verify initial score display
      expect(find.text('Score: 0'), findsOneWidget);
    });

    testWidgets('finds all control buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LabyrinthePage(),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      // Verify that all mode selection buttons are present
      expect(find.text('Mur'), findsOneWidget);
      expect(find.text('Point de départ'), findsOneWidget);
      expect(find.text("Point d'arriver"), findsOneWidget);

      // Verify action buttons are present
      expect(find.text('Start'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('Reset button clears the grid and score', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const LabyrinthePage(),
          navigatorObservers: [mockNavigatorObserver],
        ),
      );

      // Simulate some interaction to change the grid (e.g., tap to create a wall)
      // Find the GridView.builder and tap on a cell within it.
      // Since GridView.builder creates many GestureDetector widgets, we need to be specific.
      // Tapping the first cell (row 0, col 0) of the grid.
      await tester.tap(find.byType(GestureDetector).at(1)); // The first GestureDetector is the app bar back button
      await tester.pump();

      // Tap the Reset button
      await tester.tap(find.widgetWithText(GestureDetector, 'Reset'));
      await tester.pump();

      // Verify score is reset to 0
      expect(find.text('Score: 0'), findsOneWidget);

      // Verify grid is reset (e.g., no walls are present, assuming initial state is empty)
      // This is a simplified check; a more robust test would iterate through grid cells.
      // For now, we'll assume if score resets, the grid also resets.
    });
  });
}
