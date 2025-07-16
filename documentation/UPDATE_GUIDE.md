# Manuel de Mise à Jour - Ariane App

Ce document fournit une procédure standard pour mettre à jour les composants de l'application `ariane_app`, y compris le framework Flutter, les dépendances et les configurations natives.

## Table des matières
1.  [Introduction](#introduction)
2.  [Mise à Jour de Flutter](#mise-à-jour-de-flutter)
3.  [Mise à Jour des Dépendances](#mise-à-jour-des-dépendances-pub)
4.  [Mises à Jour Spécifiques aux Plateformes](#mises-à-jour-spécifiques-aux-plateformes)
    -   [Android](#android)
    -   [iOS](#ios)
5.  [Vérifications Après la Mise à Jour](#vérifications-après-la-mise-à-jour)

---

### Introduction

Garder le projet à jour est crucial pour la sécurité, la performance et l'accès aux nouvelles fonctionnalités. Suivez ce guide pour minimiser les risques de régressions lors des mises à jour.

---

### Mise à Jour de Flutter

La première étape consiste toujours à mettre à jour le SDK Flutter lui-même.

1.  **Passer sur la dernière version stable** :
    Exécutez la commande suivante pour mettre à jour Flutter vers la dernière version stable disponible.
    ```bash
    flutter upgrade
    ```

2.  **Vérifier l'état de l'installation** :
    Après la mise à jour, lancez `flutter doctor` pour vous assurer que tout est correctement configuré.
    ```bash
    flutter doctor
    ```

---

### Mise à Jour des Dépendances (Pub)

Les dépendances sont gérées dans le fichier `ariane_app/pubspec.yaml`.

1.  **Identifier les dépendances obsolètes** :
    Placez-vous dans le répertoire `ariane_app` et exécutez la commande suivante pour voir une liste de toutes les dépendances qui peuvent être mises à jour.
    ```bash
    cd ariane_app
    flutter pub outdated
    ```

2.  **Mettre à jour les dépendances** :
    Pour mettre à jour toutes les dépendances vers leurs dernières versions compatibles, utilisez :
    ```bash
    flutter pub upgrade
    ```
    
    **Note importante** : Après une mise à jour majeure d'une dépendance (par exemple, de la version `2.5.0` à `3.0.0`), consultez son "Changelog" sur [pub.dev](https://pub.dev/) pour prendre connaissance des "breaking changes" (changements cassants) qui pourraient nécessiter des modifications dans votre code.

3.  **Mettre à jour le paquet local `tflite`** :
    Le paquet dans `local_packages/tflite` est géré manuellement. Si une nouvelle version de ce paquet est disponible, vous devrez remplacer son contenu par la nouvelle version et vérifier qu'il fonctionne toujours comme prévu.

---

### Mises à Jour Spécifiques aux Plateformes

Parfois, les mises à jour de Flutter ou des dépendances nécessitent des ajustements dans les projets natifs Android et iOS.

#### Android

1.  **Mise à jour de Gradle** :
    Android Studio vous notifiera souvent si une nouvelle version du plugin Gradle est disponible. Vous pouvez accepter la mise à jour directement depuis l'IDE.
    Sinon, vous pouvez manuellement modifier les versions dans :
    -   `ariane_app/android/build.gradle.kts` (pour la version du plugin).
    -   `ariane_app/android/gradle/wrapper/gradle-wrapper.properties` (pour la version de la distribution Gradle).

2.  **Nettoyage du projet** :
    Après une mise à jour, il est bon de nettoyer le projet Android.
    ```bash
    cd ariane_app/android
    ./gradlew clean
    cd ../.. 
    ```

#### iOS

1.  **Mise à jour de CocoaPods** :
    Les dépendances iOS sont gérées par CocoaPods.
    ```bash
    cd ariane_app/ios
    pod repo update  # Met à jour le registre local des "pods"
    pod install      # Installe les versions spécifiées dans Podfile.lock
    cd ../..
    ```
    Un `flutter clean` suivi d'un `flutter pub get` effectue généralement ces étapes pour vous.

2.  **Vérifications avec Xcode** :
    Ouvrez `ariane_app/ios/Runner.xcworkspace` avec Xcode. L'IDE peut vous suggérer des mises à jour de configuration du projet, qu'il est généralement recommandé d'appliquer.

---

### Vérifications Après la Mise à Jour

Après toute mise à jour, il est impératif de vérifier que l'application fonctionne toujours correctement.

1.  **Analyse statique du code** :
    ```bash
    flutter analyze
    ```

2.  **Lancer tous les tests** :
    Assurez-vous qu'aucune régression n'a été introduite.
    ```bash
    flutter test
    ```

3.  **Compiler l'application pour chaque plateforme** :
    ```bash
    flutter build appbundle
    flutter build ios --no-codesign
    flutter build web
    ```

4.  **Tests manuels** :
    Lancez l'application sur un émulateur/simulateur et sur un appareil physique pour tester les fonctionnalités clés (le dessin, les jeux, la navigation, etc.).
