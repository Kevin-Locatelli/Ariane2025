import 'package:ariane_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:ariane_app/constants.dart';
import 'package:ariane_app/utils/score_manager.dart';

class ArianeAllResultsScreen extends StatefulWidget {
  const ArianeAllResultsScreen({super.key});

  @override
  State<ArianeAllResultsScreen> createState() => _ArianeAllResultsScreenState();
}

class _ArianeAllResultsScreenState extends State<ArianeAllResultsScreen> {
  List<Map<String, dynamic>> _scores = [];

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final loadedScores = await ScoreManager.loadScores();
    setState(() {
      _scores = loadedScores;
    });
  }

  Future<void> _clearScores() async {
    await ScoreManager.clearScores();
    _loadScores(); // Reload scores after clearing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary, size: kIconSize),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          AppStrings.get(context, 'tous_les_resultats'),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: kFontSizeMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPaddingLarge),
        child: Column(
          children: [
            Expanded(
              child: _scores.isEmpty
                  ? Center(
                      child: Text(
                        AppStrings.get(context, 'aucun_resultat'),
                        style: TextStyle(
                          fontSize: kFontSizeMedium,
                          color: kTextColorSecondary,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _scores.length,
                      itemBuilder: (context, index) {
                        final scoreEntry = _scores[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: kPaddingSmall),
                          elevation: kElevation,
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(kPaddingMedium),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jeu: ${scoreEntry['gameName']}',
                                  style: TextStyle(
                                    fontSize: kFontSizeSmall,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.bodyMedium!.color,
                                  ),
                                ),
                                SizedBox(height: kSizedBoxHeightSmall),
                                Text(
                                  'Score: ${scoreEntry['score']}',
                                  style: TextStyle(fontSize: kFontSizeSmall, color: Theme.of(context).textTheme.bodyMedium!.color),
                                ),
                                SizedBox(height: kSizedBoxHeightSmall),
                                Text(
                                  'Message: ${scoreEntry['message']}',
                                  style: TextStyle(fontSize: kFontSizeSmall, color: Theme.of(context).textTheme.bodyMedium!.color),
                                ),
                                SizedBox(height: kSizedBoxHeightSmall),
                                Text(
                                  'Date: ${DateTime.parse(scoreEntry['timestamp']).toLocal().toString().split('.')[0]}',
                                  style: TextStyle(
                                    fontSize: kFontSizeExtraSmall,
                                    color: kTextColorSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(height: kSizedBoxHeightLarge),
            ElevatedButton(
              onPressed: _clearScores,
              style: ElevatedButton.styleFrom(
                backgroundColor: kErrorColor,
                padding: EdgeInsets.symmetric(horizontal: kPaddingExtraLarge, vertical: kPaddingMedium),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kBorderRadiusLarge),
                ),
              ),
              child: Text(
                AppStrings.get(context, 'effacer_les_resultats'),
                style: TextStyle(
                  fontSize: kFontSizeSmall,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: kSizedBoxHeightLarge),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/')); // Go back to main menu
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
    );
  }
}
