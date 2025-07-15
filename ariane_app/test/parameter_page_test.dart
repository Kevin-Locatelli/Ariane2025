import 'package:ariane_app/providers/language_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ariane_app/screens/parameter_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  group('ParametrePage', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
          child: const MaterialApp(home: ParametrePage()),
        ),
      );
      expect(find.text('Paramètres'), findsOneWidget);
      expect(find.text('Audio'), findsOneWidget);
      expect(find.text('Musique'), findsOneWidget);
      expect(find.text('Effets sonores'), findsOneWidget);
      expect(find.text('Système'), findsOneWidget);
      expect(find.text('Langue :'), findsOneWidget);
    });
  });
}
