import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/scratch_game_page.dart';
import 'package:flutter/material.dart';

void main() {
  group('ScratchPage', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ScratchPage()));
      expect(find.text('Scratch'), findsOneWidget);
      expect(find.text('Blocs disponibles:'), findsOneWidget);
      expect(find.text('Séquence de code:'), findsOneWidget);
      expect(find.text('Glissez les blocs ici'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
    });
  });
}
