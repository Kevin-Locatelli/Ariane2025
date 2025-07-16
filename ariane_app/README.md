# Application Ariane

## Description de l'application

L'application Ariane est une application mobile multi-plateforme développée avec Flutter. Elle est conçue pour offrir des expériences interactives et éducatives à travers une série de mini-jeux, notamment :

*   **Jeu de Labyrinthe :** Permet aux utilisateurs de créer un labyrinthe et de regarder un algorithme le résoudre.
*   **Jeu de Calcul :** Un jeu où l'utilisateur doit dessiner la réponse à une opération mathématique, qui est ensuite reconnue par un modèle d'intelligence artificielle.
*   **Jeu de Scratch :** Une introduction à la programmation par blocs visuels pour guider un personnage.

L'application intègre également un système de gestion des scores pour suivre la progression et des paramètres personnalisables comme le changement de langue.

## Technologies Utilisées

*   **Framework :** [Flutter](https://flutter.dev/)
*   **Langage :** [Dart](https://dart.dev/)
*   **Gestion d'état :** [Provider](https://pub.dev/packages/provider)
*   **Intelligence Artificielle :** [TensorFlow Lite](https://www.tensorflow.org/lite) via le paquet `tflite_flutter` pour la reconnaissance de chiffres manuscrits.
*   **Stockage local :** [shared_preferences](https://pub.dev/packages/shared_preferences) pour sauvegarder les scores et les préférences.
*   **Tests :** `flutter_test` et `mocktail`.

## Instructions pour Compiler et Lancer

### Prérequis

*   **Flutter SDK :** Assurez-vous que Flutter est installé. Suivez les instructions sur le [site officiel de Flutter](https://flutter.dev/docs/get-started/install).
*   **IDE :** Visual Studio Code avec l'extension Flutter, ou Android Studio avec les plugins Flutter et Dart.
*   **Appareil/Émulateur :** Un appareil ou émulateur Android/iOS, ou un environnement de bureau (Windows, macOS, Linux) configuré.

### Étapes

1.  **Cloner le dépôt :**
    ```bash
    git clone git@github.com:Kevin-Locatelli/Ariane2025.git
    cd Ariane2025/ariane_app
    ```

2.  **Installer les dépendances :**
    Exécutez la commande suivante à la racine du dossier `ariane_app` :
    ```bash
    flutter pub get
    ```

3.  **Lancer l'application :**
    Assurez-vous qu'un appareil est connecté et reconnu par Flutter (`flutter devices`), puis lancez l'application :
    ```bash
    flutter run
    ```
    Pour une plateforme spécifique :
    *   **Web :** `flutter run -d chrome`
    *   **Windows :** `flutter run -d windows`

## Documentation

Pour plus de détails sur le projet, veuillez consulter les manuels suivants situés à la racine du projet (`Ariane2025/`):

*   `USER_MANUAL.md`: Guide d'utilisation de l'application.
*   `DEPLOYMENT_GUIDE.md`: Instructions pour le déploiement sur les différentes plateformes.
*   `UPDATE_GUIDE.md`: Procédures pour la mise à jour du projet et de ses dépendances.
*   `ARCHITECTURE_AND_TRACEABILITY.md`: Analyse de l'architecture et de la traçabilité.
*   `ACCESSIBILITY.md`: Guide des bonnes pratiques d'accessibilité (RGAA).

## Auteurs

*   Kevin Locatelli
