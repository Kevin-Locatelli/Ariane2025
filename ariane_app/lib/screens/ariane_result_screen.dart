import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';
import 'package:ariane_app/screens/ariane_menu_screen.dart';

class ArianeResultScreen extends StatelessWidget {
  final int score;
  final String message;
  final String gameName;

  const ArianeResultScreen({
    Key? key,
    required this.score,
    required this.message,
    required this.gameName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Résultat du $gameName',
          style: TextStyle(
            color: Colors.black,
            fontSize: kFontSizeMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(kPaddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: kFontSizeLarge,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: kSizedBoxHeightLarge),
              Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: kFontSizeMedium,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: kSizedBoxHeightLarge * 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName('/'),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                  ),
                ),
                child: Text(
                  'Retour au menu',
                  style: TextStyle(
                    fontSize: kFontSizeSmall,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}