
# ✈️ Wanderlust | Premium Travel UI & State Architecture
### Crafted by **HassanBuilds**

A visually stunning Travel Application designed with a focus on **Fluid UI** and **Reactive State Management**. This project demonstrates how to handle complex user interactions and data filtering using the **Provider** pattern.



---

## 🌟 Key Features
* **Dynamic Discovery**: Browse destinations with smooth scrolling and hero animations.
* **Provider State Management**: Centralized logic for managing favorites, search filters, and user selections.
* **Reactive UI**: The interface updates instantly when state changes, without manual setStates.
* **Clean Folder Architecture**: Organized by feature and logic for maximum scalability.

---

## 🏗 The Architecture
This project is built using a **ChangeNotifier** approach with Provider to ensure a "Single Source of Truth":

* **`lib/providers/`**: Manages the app state (e.g., `TravelProvider.dart`).
* **`lib/models/`**: Defines the `Destination` and `User` data structures.
* **`lib/screens/`**: High-fidelity UI screens like `DiscoveryScreen` and `DetailsScreen`.
* **`lib/widgets/`**: Reusable UI components for a consistent design language.



---

## 🛠 Tech Stack
* **Framework**: Flutter (Dart)
* **State Management**: Provider (ChangeNotifier)
* **UI Pattern**: Atomic Design (Small widgets building large screens)
* **Assets**: High-resolution imagery and custom SVG icons.

---

## 📝 About the Provider Implementation
In this project, I moved away from `setState()` to implement a more professional architecture. By using **Provider**, I achieved:
1. **Efficiency**: Only the widgets that need the data are rebuilt.
2. **Readability**: Logic is separated from the UI, making it easier to debug.
3. **Scalability**: New features like "Booking" or "Favorites" can be added in minutes.

---

## 🚀 Installation
```bash
git clone [https://github.com/hassanbuilds/travel-app-provider.git](https://github.com/hassanbuilds/travel-app-provider.git)
flutter pub get
flutter run
