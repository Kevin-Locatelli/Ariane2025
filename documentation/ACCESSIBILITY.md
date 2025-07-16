# Guide d'Accessibilité - Ariane App

Ce document a pour but de guider l'amélioration continue de l'accessibilité (a11y) de l'application, en s'inspirant des principes du RGAA (Référentiel Général d'Amélioration de l'Accessibilité).

## Améliorations Apportées

Des premières modifications ont été effectuées pour améliorer l'accessibilité de base de l'application.

### 1. Contraste des Couleurs

-   **Problème :** La couleur utilisée pour indiquer le succès (`kSuccessColor`) avait un ratio de contraste insuffisant avec le texte blanc, rendant le texte difficile à lire pour les personnes malvoyantes.
-   **Solution :** La couleur a été remplacée par un vert plus foncé (`#1B5E20`) qui garantit un ratio de contraste de **8:1**, bien au-dessus du minimum requis par le RGAA (4.5:1).

### 2. Sémantique des Composants Interactifs

-   **Problème :** Plusieurs boutons ne contenaient que des icônes, sans description textuelle. Les utilisateurs de lecteurs d'��cran (comme VoiceOver sur iOS ou TalkBack sur Android) ne pouvaient pas savoir à quoi servaient ces boutons.
-   **Solution :** Des étiquettes sémantiques (via la propriété `tooltip`) ont été ajoutées à tous les boutons "Retour" et au bouton de suppression de bloc dans le jeu Scratch. Le lecteur d'écran annonce désormais "Retour en arrière" ou "Supprimer le bloc", rendant l'interface compréhensible.

### 3. Taille des Zones de Clic

-   **Problème :** Certains boutons avaient une hauteur de zone cliquable inférieure à la taille recommandée de 48x48 pixels, ce qui pouvait les rendre difficiles à utiliser pour les personnes ayant des troubles de la motricité.
-   **Solution :** Le `padding` vertical des boutons dans les pages de jeu (Calcul, Labyrinthe) a été augmenté pour garantir une zone de clic confortable et conforme aux standards.

## Comment Tester l'Accessibilité ?

L'accessibilité doit être testée régulièrement. Voici comment vous pouvez le faire :

### 1. Utilisez les Lecteurs d'Écran

Activez le lecteur d'écran de votre téléphone et naviguez dans l'application.
-   **Sur iOS :** Allez dans `Réglages > Accessibilité > VoiceOver` et activez-le.
-   **Sur Android :** Allez dans `Paramètres > Accessibilité > TalkBack` et activez-le.

Naviguez dans chaque écran et vérifiez que :
-   Tous les boutons sont correctement étiquetés.
-   Les champs de saisie sont clairs.
-   L'ordre de navigation est logique.

### 2. Utilisez l'Inspecteur d'Accessibilité de Flutter

Flutter DevTools inclut un inspecteur d'accessibilité qui vous permet de visualiser l'arbre sémantique de vos widgets.

-   Lancez votre application.
-   Ouvrez les **Flutter DevTools**.
-   Cliquez sur l'onglet **"Flutter Inspector"**.
-   Activez le bouton **"Enable accessibility issues"**.

L'inspecteur mettra en évidence les problèmes courants, comme des zones de clic trop petites ou des contrastes de texte insuffisants.

## Prochaines Étapes Recommandées

-   **Étiqueter les zones dynamiques :** Pour des jeux comme le Labyrinthe ou le Calcul, utilisez le widget `Semantics` pour donner des descriptions contextuelles (ex: "Zone de dessin pour le chiffre", "Grille du labyrinthe").
-   **Gestion du focus :** Assurez-vous que le focus est géré logiquement après des actions, par exemple en le déplaçant vers le premier élément d'une nouvelle page.
-   **Mise à l'échelle du texte :** Vérifiez que l'interface reste utilisable lorsque l'utilisateur augmente la taille de la police dans les paramètres de son téléphone.
