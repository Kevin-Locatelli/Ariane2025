# Ariane App

## Project Overview

Ariane App is an interactive Flutter application designed to provide engaging and educational experiences through various mini-games. It features a labyrinth game, a calculation game, and a Scratch-like block-based programming game. The application also incorporates score management and leverages TensorFlow Lite for potential machine learning functionalities.

## Features

*   **Labyrinth Game:** Create and solve mazes.
*   **Calcul Game:** Practice mathematical calculations.
*   **Scratch Game:** Learn basic programming concepts through a visual block-based interface.
*   **Score Management:** Track and review your performance across different games.
*   **Machine Learning Integration:** (Potential) Utilizes TensorFlow Lite for on-device ML capabilities, such as digit recognition in the Calcul game.

## How to Launch the App

To run the Ariane App, follow these steps:

### Prerequisites

*   **Flutter SDK:** Ensure you have Flutter installed. You can download it from the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   **IDE:** Visual Studio Code with the Flutter extension, or Android Studio with the Flutter and Dart plugins.
*   **Connected Device/Emulator:** An Android device (physical or emulator), iOS device (physical or simulator), or a desktop environment (Windows, macOS, Linux) configured for Flutter development.

### Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository_url>
    cd ariane_app
    ```
2.  **Get dependencies:**
    Navigate to the `ariane_app` directory and run:
    ```bash
    flutter pub get
    ```

### Running the App

#### On a Connected Device (Android/iOS)

1.  Ensure your device is connected and recognized by Flutter:
    ```bash
    flutter devices
    ```
2.  Run the app on your device:
    ```bash
    flutter run
    ```
    If you have multiple devices connected, you might need to specify one using its ID:
    ```bash
    flutter run -d <device_id>
    ```

#### On Windows Desktop

1.  Enable Windows desktop development for Flutter:
    ```bash
    flutter config --enable-windows-desktop
    ```
2.  Run the app:
    ```bash
    flutter run -d windows
    ```

#### On Web (Chrome/Edge)

1.  Enable web development for Flutter:
    ```bash
    flutter config --enable-web
    ```
2.  Run the app on your preferred web browser:
    ```bash
    flutter run -d chrome
    # or
    flutter run -d edge
    ```

## What You Can Do with the App

Once the app is running, you can:

*   **Play Games:** Explore the Labyrinth, Calcul, and Scratch games from the main menu.
*   **Track Scores:** View your past game results and scores on the dedicated results screen.
*   **Customize Settings:** Adjust audio volumes and change the application language in the settings page.
*   **Learn and Have Fun:** Engage with the interactive elements and enjoy the educational aspects of the games.