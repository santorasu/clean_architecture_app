# Clean Architecture App

A scalable and robust Flutter application built using **Clean Architecture** principles.

## App Functionality

- **User List Screen**: 
  - Displays a list of users fetched from a remote API.
  - **Pull-to-refresh** functionality to manually reload the user data.
  - **Infinite scrolling/pagination** to seamlessly load more users as you scroll to the bottom.
  - **Search functionality** to instantly filter users by their first and last name.
  - **Double-tap to exit**: Safely closes the app when the back button is pressed twice within 2 seconds.
- **User Detail Screen**: 
  - Shows comprehensive details about a selected user.
  - Implements image caching and smooth loading states for profile pictures.
- **Splash Screen**: A welcoming initial screen displayed during app launch.

## Architecture

This project strictly adheres to **Clean Architecture** to ensure modularity, scalability, and testability. The codebase is divided into three main layers:

- **Core**: Contains shared resources such as utilities, network clients (`Dio`), UI constants (colors, fonts, icons), and routing logic.
- **Data**: Responsible for all data operations. It includes models, API services (`UserApiService`), and repository implementations.
- **Presentation**: The UI layer. It contains all screens, widgets, and state management logic (Providers/ViewModels) organized by feature.

## Tech Stack & Libraries

- **State Management**: [flutter_riverpod](https://pub.dev/packages/flutter_riverpod)
- **Networking**: [dio](https://pub.dev/packages/dio)
- **Responsive UI**: [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
- **Image Handling**: [cached_network_image](https://pub.dev/packages/cached_network_image), [flutter_svg](https://pub.dev/packages/flutter_svg)
- **Utilities**: 
  - [connectivity_plus](https://pub.dev/packages/connectivity_plus) (Network status monitoring)
  - [fluttertoast](https://pub.dev/packages/fluttertoast) (In-app notifications)
  - [shared_preferences](https://pub.dev/packages/shared_preferences) (Local persistent storage)
