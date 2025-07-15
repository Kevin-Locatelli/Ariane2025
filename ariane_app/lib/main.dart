import 'package:ariane_app/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:ariane_app/screens/ariane_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          locale: languageProvider.currentLocale,
          theme: ThemeData(
            primaryColor: Colors.blue[900],
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.blue[900],
              secondary: Colors.amber,
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(color: Colors.black),
            ),
          ),
          home: ArianeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
