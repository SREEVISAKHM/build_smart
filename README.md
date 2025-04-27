# BUILD SMART

Chatbot Mobile Application 

## Project Overview
This project is a mobile chatbot application developed using **Flutter** for both iOS and Android platforms. It integrates with a mock backend  to enable chatbot interactions, document indexing, and user profile management. The app uses **MVVM** architecture and **Riverpod** for efficient state management. It also includes local storage mechanisms for caching conversation history and user preferences.


## Technical Requirements and Features


## Architecture
The application follows the **MVVM (Model-View-ViewModel)** architecture for clean code separation, making the codebase maintainable and scalable. **Riverpod** is used for state management to efficiently manage state across both iOS and Android platforms.
   ### MVVM Pattern  
   - **Model**: Data layer 
   - **View**: UI components  
   - **ViewModel**: Business logic 



### Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/SREEVISAKHM/build_smart.git

2. Install Dependencies
   ```bash
   flutter pub get

3. Run the App
   in Dev Env

   ```bash
   flutter run --dart-define=env=dev --dart-define=dev_tools_enabled=true

4. Other  Flavors

   # production
   ```bash 
   flutter run --dart-define=env=prod
   


Run the Application for different flavors setuped inside vs code / android studio eg:

   ```bash
   flutter run --dart-define=env=dev --dart-define=dev_tools_enabled=true



### Build the app bundle (for Android)   
  ```bash
  flutter build appbundle --dart-define=env=dev --dart-define=dev_tools_enabled=true
