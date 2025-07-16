import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';

class ArianeResultScreen extends StatelessWidget {
  final int score;
  final String message;
  final String gameName;

  const ArianeResultScreen({
    super.key,
    required this.score,
    required this.message,
    required this.gameName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: AppStrings.get(context, 'back_button_tooltip'),
        ),
        centerTitle: true,
        title: Text(
          '${AppStrings.get(context, 'resultat_du_jeu')} $gameName',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
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
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              SizedBox(height: kSizedBoxHeightLarge),
              Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: kFontSizeMedium,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
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
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                  ),
                ),
                child: Text(
                  AppStrings.get(context, 'retour_au_menu'),
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
