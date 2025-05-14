✅ Prerequisites
Make sure the following tools are installed on your machine:

Flutter SDK

Dart SDK (comes with Flutter)

Android Studio / VS Code (or any Flutter-supported IDE)

A device or emulator for running the app

Step 1: Clone the Repository
git clone https://github.com/your-username/tmdb_app.git
cd tmdb_app

Step 2: Install Dependencies
flutter pub get

Step 3: Run the App
Connect a device or start an emulator, then run:
flutter run

Main Features
🔍 Search Screen — Search for movies using the TMDb API.
🏠 Home Screen — Displays popular or trending movies.
🎬 Movie Detail Page — Shows detailed info and reviews.
💬 Review Section — Displays user reviews from TMDb.
💫 Splash Screen — Lottie animation for better UX.

Used Packages

| Package Name               | Version  | Description                                                              |
| -------------------------- | -------- | ------------------------------------------------------------------------ |
| **`dio`**                  | ^5.8.0+1 | A powerful HTTP client used for making network requests to the TMDb API. |
| **`provider`**             | ^6.1.5   | Used for state management and ViewModel communication across the UI.     |
| **`cached_network_image`** | ^3.4.1   | Loads and caches images efficiently to improve performance and UX.       |
| **`google_fonts`**         | ^6.2.1   | Enables use of custom Google Fonts to enhance typography and UI design.  |
| **`lottie`**               | ^3.3.1   | Used to display Lottie animations (e.g., animated splash screen).        |

