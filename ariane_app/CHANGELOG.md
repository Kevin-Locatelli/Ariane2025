# Journal des Versions - Ariane

Toutes les modifications notables apportées à ce projet seront documentées dans ce fichier.

## [1.1.0] - 2025-07-16

### ✨ Fonctionnalités (Features)
- Le nom de l'application a été changé de "ariane_app" à "Ariane" sur toutes les plateformes (Android, iOS, Web, Windows, macOS, Linux).
- L'icône de l'application a été mise à jour sur Android et iOS.

### 🐛 Corrections (Fixes)
- Correction d'une erreur de compilation due à des importations manquantes dans les pages `calcul_game_page.dart` et `labyrinth_game_page.dart` après l'ajout de tooltips.

### 🔧 Maintenance & Accessibilité
- Mise à jour des dépendances vers les dernières versions stables, y compris `flutter_lints` v6.0.0.
- Activation de la minification (`isMinifyEnabled`) et de la réduction des ressources (`isShrinkResources`) dans la configuration de build Android pour améliorer la sécurité et la performance.
- Amélioration du contraste de la couleur de succès (`kSuccessColor`) pour une meilleure lisibilité (critère RGAA).
- Ajout d'étiquettes sémantiques (`tooltip`) sur les boutons icônes pour les rendre accessibles aux lecteurs d'écran (critère RGAA).
- Augmentation de la taille des zones de clic sur certains boutons pour une meilleure ergonomie.
- Création d'un guide d'accessibilité (`ACCESSIBILITY.md`) pour documenter les bonnes pratiques.
