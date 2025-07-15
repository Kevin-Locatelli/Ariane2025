# Application Ariane

## Aperçu du projet

L'application Ariane est une application Flutter interactive conçue pour offrir des expériences engageantes et éducatives à travers divers mini-jeux. Elle propose un jeu de labyrinthe, un jeu de calcul et un jeu de programmation par blocs de type Scratch. L'application intègre également la gestion des scores et utilise TensorFlow Lite pour des fonctionnalités potentielles d'apprentissage automatique.

## Fonctionnalités

*   **Jeu de labyrinthe :** Créez et résolvez des labyrinthes.
*   **Jeu de calcul :** Entraînez-vous aux calculs mathématiques.
*   **Jeu Scratch :** Apprenez les concepts de base de la programmation grâce à une interface visuelle basée sur des blocs.
*   **Gestion des scores :** Suivez et consultez vos performances dans les différents jeux.
*   **Intégration de l'apprentissage automatique :** (Potentiel) Utilise TensorFlow Lite pour les capacités d'apprentissage automatique sur l'appareil, telles que la reconnaissance de chiffres dans le jeu de calcul.

## Comment lancer l'application

Pour exécuter l'application Ariane, suivez ces étapes :

### Prérequis

*   **Flutter SDK :** Assurez-vous que Flutter est installé. Vous pouvez le télécharger depuis le [site officiel de Flutter](https://flutter.dev/docs/get-started/install).
*   **IDE :** Visual Studio Code avec l'extension Flutter, ou Android Studio avec les plugins Flutter et Dart.
*   **Appareil/Émulateur connecté :** Un appareil Android (physique ou émulateur), un appareil iOS (physique ou simulateur), ou un environnement de bureau (Windows, macOS, Linux) configuré pour le développement Flutter.

### Configuration

1.  **Cloner le dépôt :**
    ```bash
    git clone <URL_du_dépôt>
    cd ariane_app
    ```
2.  **Obtenir les dépendances :**
    Accédez au répertoire `ariane_app` et exécutez :
    ```bash
    flutter pub get
    ```

### Exécuter l'application

#### Sur un appareil connecté (Android/iOS)

1.  Assurez-vous que votre appareil est connecté et reconnu par Flutter :
    ```bash
    flutter devices
    ```
2.  Exécutez l'application sur votre appareil :
    ```bash
    flutter run
    ```
    Si plusieurs appareils sont connectés, vous devrez peut-être en spécifier un en utilisant son ID :
    ```bash
    flutter run -d <ID_de_l'appareil>
    ```

#### Sur le bureau Windows

1.  Activez le développement de bureau Windows pour Flutter :
    ```bash
    flutter config --enable-windows-desktop
    ```
2.  Exécutez l'application :
    ```bash
    flutter run -d windows
    ```

#### Sur le Web (Chrome/Edge)

1.  Activez le développement Web pour Flutter :
    ```bash
    flutter config --enable-web
    ```
2.  Exécutez l'application sur votre navigateur Web préféré :
    ```bash
    flutter run -d chrome
    # ou
    flutter run -d edge
    ```

## Ce que vous pouvez faire avec l'application

Une fois l'application lancée, vous pouvez :

*   **Jouer à des jeux :** Explorez les jeux Labyrinthe, Calcul et Scratch depuis le menu principal.
*   **Suivre les scores :** Consultez vos résultats et scores de jeu précédents sur l'écran des résultats dédié.
*   **Personnaliser les paramètres :** Ajustez le volume audio et changez la langue de l'application dans la page des paramètres.
*   **Apprendre et s'amuser :** Interagissez avec les éléments interactifs et profitez des aspects éducatifs des jeux.
