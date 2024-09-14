# Rick and Morty Flutter App

A Flutter application demonstrating the use of BLoC architecture to build a Rick and Morty character browser. This project serves as a technical test to showcase proficiency in Flutter development, state management with BLoC, network requests, pagination, search functionality, and testing.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Project Structure](#project-structure)
- [Running the App](#running-the-app)
- [Running Tests](#running-tests)
- [Dependencies](#dependencies)
- [Screenshots](#screenshots)
- [License](#license)

## Overview

This application allows users to browse through characters from the "Rick and Morty" TV show. It fetches data from the [Rick and Morty API](https://rickandmortyapi.com/), displays a list of characters with pagination, allows users to search for characters by name, and view detailed information about each character.

## Features

- **Character Listing**: Browse through a paginated list of characters.
- **Character Details**: View detailed information about each character, including status, species, gender, origin, and location.
- **Search Functionality**: Search for characters by name.
- **Pagination**: Infinite scrolling to load more characters as the user scrolls.
- **Error Handling**: Graceful handling of network errors and empty states.
- **State Management**: Uses BLoC pattern for efficient state management.
- **Unit and Widget Tests**: Comprehensive testing for BLoC logic and UI components.

## Architecture

The application follows the BLoC (Business Logic Component) architecture to separate presentation from business logic, making the code more modular and testable.

- **Presentation Layer**: Flutter widgets (`screens`, `widgets`).
- **Business Logic Layer**: BLoCs (`blocs`), which handle events and emit states.
- **Data Layer**: Repositories (`repositories`) that handle network requests and data parsing.
- **Models**: Data classes (`models`) representing characters and other entities.

## Getting Started

### Prerequisites

- **Flutter SDK**: Version 2.10.0 or higher.
- **Dart SDK**: Version 2.17.0 or higher.
- **Android Studio** or **Visual Studio Code** with Flutter plugins installed.
- **An emulator** or **physical device** for running the app.

### Installation

1. **Clone the Repository**

   ```bash
   https://github.com/AdrianBaqueiro/Rick-And-Morty-Flutter-Version.git
   ```

## Project Structure
```bash
    lib/
    ├── blocs/
    │   ├── character_bloc.dart
    │   ├── character_event.dart
    │   └── character_state.dart
    ├── models/
    │   └── character_model.dart
    ├── repositories/
    │   └── character_repository.dart
    ├── screens/
    │   ├── character_detail_screen.dart
    │   └── character_list_screen.dart
    ├── widgets/
    │   └── character_list_item.dart
    └── main.dart
```

- **blocs/**: Contains BLoC classes for managing state.
- **models/**: Data models representing API entities.
- **repositories/**: Handles data fetching and parsing.
- **screens/**: UI screens for character list and details.
- **widgets/**: Reusable UI components.
- **main.dart**: Entry point of the application.


## Running the App

1. **Connect a Device**
    - **Emulator**: Start an Android or iOS emulator.
    - **Physical Device**: Connect your device via USB and enable USB debugging.

2. **Run the App**

   ```bash
   flutter run
    ```

## Running Tests

1. **Run Unit Tests**

   ```bash
   flutter test
   ```
   
2. **Run Widget Tests**

   ```bash
    flutter test --tags widget
    ```
   
## Dependencies

- **flutter\_bloc**: State management using BLoC pattern.
- **http**: For making network requests.
- **equatable**: Simplifies equality comparisons.
- **mocktail**: For mocking in tests.
- **bloc\_test**: Utilities for testing BLoCs.
- **network\_image\_mock**: Mocks network images in widget tests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.


Note: This application is developed as a technical test to demonstrate proficiency in Flutter and BLoC architecture. It is not intended for commercial use.