import 'package:ariane_app/providers/language_provider.dart';
import 'package:ariane_app/utils/app_strings.dart';
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
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                return const ParametrePage();
              }
            ),
          ),
        ),
      );
      final BuildContext context = tester.element(find.byType(ParametrePage));
      expect(find.text(AppStrings.get(context, 'parametres')), findsOneWidget);
      expect(find.text(AppStrings.get(context, 'audio')), findsOneWidget);
      expect(find.text(AppStrings.get(context, 'musique')), findsOneWidget);
      expect(find.text(AppStrings.get(context, 'effets_sonores')), findsOneWidget);
      expect(find.text(AppStrings.get(context, 'systeme')), findsOneWidget);
      expect(find.text('${AppStrings.get(context, 'langue')} :'), findsOneWidget);
    });
  });
}
