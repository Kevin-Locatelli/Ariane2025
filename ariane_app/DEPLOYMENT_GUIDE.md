# Guide de Déploiement - Ariane App

Ce document décrit les étapes nécessaires pour compiler et déployer l'application Flutter `ariane_app` sur différentes plateformes.

## Table des matières
1.  [Prérequis](#prérequis)
2.  [Étapes Générales](#étapes-générales-avant-chaque-déploiement)
3.  [Déploiement Android (Google Play Store)](#déploiement-android)
4.  [Déploiement iOS (Apple App Store)](#déploiement-ios)
5.  [Déploiement Web](#déploiement-web)
6.  [Déploiement Automatisé (CI/CD)](#déploiement-automatisé-avec-github-actions)

---

### Prérequis

Avant de commencer, assurez-vous d'avoir les éléments suivants :
- **Flutter SDK** installé et configuré.
- **Accès aux comptes développeurs** :
    - [Google Play Console](https://play.google.com/console) pour Android.
    - [Apple Developer Program](https://developer.apple.com/programs/) pour iOS.
- **Xcode** installé sur un macOS pour le déploiement iOS.
- **Android Studio** installé pour le déploiement Android.
- **Git** pour la gestion de version.

---

### Étapes Générales (avant chaque déploiement)

1.  **Mettre à jour la version de l'application** :
    Modifiez le fichier `ariane_app/pubspec.yaml` pour incrémenter la version.
    ```yaml
    version: 1.0.0+1 
    ```
    - `1.0.0` : Le `versionName`, visible par les utilisateurs.
    - `+1` : Le `versionCode` (build number), un identifiant unique pour chaque build.

2.  **Installer les dépendances** :
    Assurez-vous que toutes les dépendances du projet sont à jour.
    ```bash
    flutter pub get
    ```

3.  **Lancer les tests** :
    Il est crucial de vérifier que tous les tests passent avant de déployer.
    ```bash
    flutter test
    ```

---

### Déploiement Android

Le déploiement sur le Play Store se fait en générant un "Android App Bundle" (`.aab`) signé.

1.  **Créer une clé de signature (Keystore)** :
    Si vous n'en avez pas déjà une, créez une clé pour signer votre application. Cette étape n'est à faire qu'une seule fois.
    ```bash
    keytool -genkey -v -keystore c:\Users\THEKE\upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```
    Conservez ce fichier `.jks` en lieu sûr et ne le perdez jamais.

2.  **Configurer la signature dans Gradle** :
    Créez un fichier `ariane_app/android/key.properties` (ce fichier est ignoré par Git pour des raisons de sécurité) et ajoutez-y les informations de votre keystore :
    ```properties
    storePassword=<MOT_DE_PASSE_DU_KEYSTORE>
    keyPassword=<MOT_DE_PASSE_DE_LA_CLÉ>
    keyAlias=upload
    storeFile=c:\Users\THEKE\upload-keystore.jks
    ```

3.  **Référencer le `key.properties` dans `build.gradle.kts`** :
    Modifiez `ariane_app/android/app/build.gradle.kts` pour utiliser ces informations lors de la compilation en mode `release`.

4.  **Compiler l'App Bundle** :
    Exécutez la commande suivante pour générer le fichier `.aab`.
    ```bash
    flutter build appbundle
    ```

5.  **Uploader sur le Play Store** :
    Le fichier généré se trouvera dans `ariane_app/build/app/outputs/bundle/release/app-release.aab`.
    Uploadez ce fichier sur votre [Google Play Console](https://play.google.com/console) dans la section de votre application.

---

### Déploiement iOS

Le déploiement iOS nécessite un Mac avec Xcode.

1.  **Compiler l'application iOS** :
    ```bash
    flutter build ios
    ```

2.  **Ouvrir le projet dans Xcode** :
    ```bash
    open ariane_app/ios/Runner.xcworkspace
    ```

3.  **Configurer le "Signing & Capabilities"** :
    - Dans Xcode, sélectionnez `Runner` dans le navigateur de projet.
    - Allez dans l'onglet `Signing & Capabilities`.
    - Sélectionnez votre `Team` de développeur Apple.
    - Assurez-vous que le `Bundle Identifier` est correct et unique.

4.  **Archiver l'application** :
    - Dans le menu supérieur, sélectionnez `Product` > `Archive`.
    - Une fois l'archivage terminé, la fenêtre "Organizer" s'ouvrira.

5.  **Distribuer sur l'App Store Connect** :
    - Dans la fenêtre "Organizer", cliquez sur "Distribute App".
    - Suivez les instructions pour uploader votre build sur l'App Store Connect.
    - Depuis l'App Store Connect, vous pourrez soumettre votre application pour révision.

---

### Déploiement Web

Le déploiement web consiste à héberger les fichiers statiques générés par Flutter.

1.  **Compiler l'application Web** :
    ```bash
    flutter build web
    ```

2.  **Déployer les fichiers** :
    Le contenu du dossier `ariane_app/build/web` peut être déployé sur n'importe quel service d'hébergement statique comme :
    - Firebase Hosting
    - Netlify
    - GitHub Pages
    - Vercel

    Il suffit de téléverser le contenu de ce dossier sur le serveur de votre choix.

---

### Déploiement Automatisé avec GitHub Actions

Le fichier `.github/workflows/main.yml` suggère une volonté d'automatisation. Vous pouvez l'étendre pour automatiser les builds et même les déploiements.

Voici un exemple de "job" à ajouter dans votre workflow pour construire l'App Bundle Android à chaque push sur la branche `main` :

```yaml
jobs:
  build_android:
    name: Build Android App Bundle
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v2
        with:
          distribution: 'zulu'
          java-version: '11'
      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
      
      - name: Install dependencies
        run: flutter pub get
        working-directory: ./ariane_app

      - name: Build App Bundle
        run: flutter build appbundle
        working-directory: ./ariane_app

      - name: Upload Artifact
        uses: actions/upload-artifact@v2
        with:
          name: release-bundle
          path: ariane_app/build/app/outputs/bundle/release/app-release.aab
```

**Pour un déploiement complet et automatisé**, vous pouvez utiliser des secrets GitHub pour stocker vos clés de signature et des actions du Marketplace pour uploader directement sur le Play Store ou l'App Store.
- **Android**: Utilisez des actions comme `r0adkll/upload-google-play`.
- **iOS**: La signature et le déploiement sont plus complexes et nécessitent des secrets pour les certificats et les mots de passe.
- **Web**: Le déploiement sur GitHub Pages est très simple avec des actions comme `peaceiris/actions-gh-pages`.
