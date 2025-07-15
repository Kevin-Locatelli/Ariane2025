import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ariane_app/providers/language_provider.dart';

class AppStrings {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'fr': {
      'title': 'Ariane',
      'commencer': 'COMMENCER',
      'parametres': 'Paramètres',
      'audio': 'Audio',
      'musique': 'Musique',
      'effets_sonores': 'Effets sonores',
      'systeme': 'Système',
      'langue': 'Langue',
      'labyrinthe': 'Labyrinthe',
      'calcul': 'Calcul',
      'scratch': 'Scratch',
      'resultats': 'Résultats',
      'jeux': 'Jeux',
      'labyrinthe_description': 'Créer ton labyrinthe et laisse Michel le résoudre tout seul',
      'calcul_description': 'Résout les calculs de Michel',
      'scratch_description': 'Aide Michel à trouver son chemin',
      'tous_les_resultats': 'Tous les Résultats',
      'aucun_resultat': 'Aucun résultat enregistré.',
      'effacer_les_resultats': 'Effacer les résultats',
      'retour_au_menu': 'Retour au menu',
      'resultat_du_jeu': 'Résultat du jeu',
    },
    'en': {
      'title': 'Ariane',
      'commencer': 'START',
      'parametres': 'Settings',
      'audio': 'Audio',
      'musique': 'Music',
      'effets_sonores': 'Sound Effects',
      'systeme': 'System',
      'langue': 'Language',
      'labyrinthe': 'Labyrinth',
      'calcul': 'Calculation',
      'scratch': 'Scratch',
      'resultats': 'Results',
      'jeux': 'Games',
      'labyrinthe_description': 'Create your labyrinth and let Michel solve it by himself',
      'calcul_description': 'Solve Michel\'s calculations',
      'scratch_description': 'Help Michel find his way',
      'tous_les_resultats': 'All Results',
      'aucun_resultat': 'No results saved.',
      'effacer_les_resultats': 'Clear results',
      'retour_au_menu': 'Back to menu',
      'resultat_du_jeu': 'Game Result',
    },
  };

  static String get(BuildContext context, String key) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final lang = languageProvider.currentLocale.languageCode;
    return _localizedStrings[lang]![key] ?? key;
  }
}