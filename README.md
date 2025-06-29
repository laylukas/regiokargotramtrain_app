# 📦 RegioKargoTramTrain App

<div align="center">
  <img src="assets/img/logo_tramtrain.png" alt="TramTrain Logo" width="200"/>
  
  **A modern Flutter application for delivery robot interfaces in the RegioKargo system**
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=for-the-badge)
</div>

---

## 📋 Table of Contents

- [🎯 About the Project](#-about-the-project)
- [✨ Features](#-features)
- [🛠 Technologies](#-technologies)
- [📋 Prerequisites](#-prerequisites)
- [🚀 Installation](#-installation)
- [▶️ Running the App](#️-running-the-app)
- [📁 Project Structure](#-project-structure)
- [🎨 UI Components](#-ui-components)
- [📱 Screens Overview](#-screens-overview)
- [🔧 Development](#-development)
- [📝 Additional Information](#-additional-information)

---

## 🎯 About the Project

The **RegioKargoTramTrain App** is an innovative Flutter application developed as a user interface for delivery robots in the RegioKargo system. It enables users to pick up and send packages, scan QR codes, and manage the entire delivery process.

This project was developed as part of a project study and aims to revolutionize logistics in public transportation by utilizing tram and train connections for goods transport.

---

## ✨ Features

### 🎯 Main Functions
- **Package Pickup**: User-friendly interface for picking up packages
- **Shipping Function**: Integrated solution for package shipping
- **QR Code Integration**: Scanning and displaying QR codes for package recognition
- **Navigation**: Intuitive user guidance through the entire process
- **Map Integration**: Display of locations and routes
- **User Accounts**: Management of user information

### 🎨 Design Features
- **Material Design**: Modern and consistent user interface
- **Responsive Design**: Optimized for different screen sizes
- **Accessibility**: User-friendly for all user groups
- **Custom Widgets**: Reusable UI components

---

## 🛠 Technologies

### Frontend
- **Flutter 3.7.2+**: Cross-Platform UI Framework
- **Dart 3.7.2+**: Programming Language
- **Material Design**: Design System

### Dependencies
- **cupertino_icons**: iOS-Style Icons
- **qr_flutter**: QR Code generation and display

### Platforms
- 🤖 **Android**
- 🍎 **iOS** 
- 🌐 **Web**
- 🖥️ **Windows**
- 🍎 **macOS**
- 🐧 **Linux**

---

## 📋 Prerequisites

### 🖥️ System Requirements
- **Operating System**: Windows 10+, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **Memory**: At least 4 GB RAM (8 GB recommended)
- **Storage**: 3 GB free disk space

### 🛠️ Software Requirements
- **Git**: Version control
  - Download: https://git-scm.com/
- **Flutter SDK 3.7.2+**: Framework
  - Download: https://flutter.dev/docs/get-started/install
- **IDE** (optional but recommended):
  - Visual Studio Code with Flutter Extension
  - Android Studio with Flutter Plugin

### 📱 For Mobile Development
- **Android SDK**: For Android development
- **Xcode**: For iOS development (macOS only)

---

## 🚀 Installation

### 1. Clone Repository
```bash
git clone https://github.com/your-username/regiokargotramtrain_app.git
cd regiokargotramtrain_app
```

### 2. Install Flutter SDK
Follow the official Flutter installation guide:
👉 https://flutter.dev/docs/get-started/install

### 3. Verify Environment
```bash
flutter doctor
```
Make sure all checkmarks are green.

### 4. Install Dependencies
```bash
flutter pub get
```

### 5. Generate Assets
```bash
flutter pub run build_runner build
```

---

## ▶️ Running the App

### 🖥️ Desktop (Development)
```bash
flutter run -d windows    # Windows
flutter run -d macos      # macOS
flutter run -d linux      # Linux
```

### 📱 Mobile (with connected device)
```bash
flutter run -d android    # Android
flutter run -d ios        # iOS
```

### 🌐 Web
```bash
flutter run -d web
```

### 🏗️ Create Release Build
```bash
# Android APK
flutter build apk --release

# iOS (macOS only)
flutter build ios --release

# Web
flutter build web --release

# Windows
flutter build windows --release
```

---

## 📁 Project Structure

```
regiokargotramtrain_app/
├── 📁 lib/                          # Main source code
│   ├── 📄 main.dart                 # App entry point
│   ├── 📁 screens/                  # App screens
│   │   ├── 📄 loading_page.dart     # Loading screen
│   │   ├── 📄 start_page.dart       # Start page
│   │   ├── 📁 account/              # User account screens
│   │   ├── 📁 information/          # Information screens
│   │   ├── 📁 map/                  # Map screens
│   │   ├── 📁 more/                 # More options
│   │   └── 📁 orders/               # Order screens
│   │       ├── 📁 deliver/          # Delivery screens
│   │       └── 📁 pickup/           # Pickup screens
│   ├── 📁 widgets/                  # Reusable UI components
│   │   ├── 📁 buttons/              # Button components
│   │   └── 📁 navigation/           # Navigation components
│   ├── 📁 services/                 # API and services
│   └── 📁 models/                   # Data models
├── 📁 assets/                       # Static resources
│   ├── 📁 img/                      # Images
│   ├── 📁 fonts/                    # Fonts
│   └── 📁 videos/                   # Videos
├── 📁 android/                      # Android-specific files
├── 📁 ios/                          # iOS-specific files
├── 📁 web/                          # Web-specific files
├── 📁 windows/                      # Windows-specific files
├── 📁 linux/                        # Linux-specific files
├── 📁 macos/                        # macOS-specific files
├── 📄 pubspec.yaml                  # Project dependencies
└── 📄 README.md                     # Documentation
```

---

## 🎨 UI Components

### 🔘 Buttons
- **StandardButton**: Base button with hover effects
- **SquareButton**: Square buttons for main actions

### 🧭 Navigation
- **Header**: App header with navigation
- **Navbar**: Bottom navigation bar

### 🎯 Component Features
- **Responsive Design**: Automatic adaptation to screen sizes
- **Hover Effects**: Interactive feedback
- **Material Design**: Consistent design language
- **Accessibility**: Support for accessibility features

---

## 📱 Screens Overview

### 🏠 Main Screens
- **LoadingPage**: Initial loading screen
- **StartPage**: Main menu with "Pickup" and "Shipping" options

### 📦 Order Management
- **QR Scan Introduction**: Introduction to QR code scanning
- **QR Code Display**: Display of generated QR codes
- **QR Scan Success**: Success confirmation after scan
- **Repetition Process**: Repetition process management
- **Pickup Done**: Completion of pickup

### 📊 Additional Areas
- **Account**: User account management
- **Information**: App information
- **Map**: Map view
- **More**: Additional options

### 🛣️ Navigation
The app uses Flutter's Named Routes for clean navigation:
```dart
Navigator.pushNamed(context, '/qr_scan_introduction');
```

---

## 🔧 Development

### 🐛 Debugging
```bash
# Start debug mode
flutter run --debug

# Profiling
flutter run --profile

# Hot Reload during development
# Press 'r' in terminal for Hot Reload
# Press 'R' for Hot Restart
```

### 🧪 Running Tests
```bash
# Unit Tests
flutter test

# Widget Tests
flutter test test/widget_test.dart

# Integration Tests
flutter drive --target=test_driver/app.dart
```

### 📊 Code Analysis
```bash
# Static code analysis
flutter analyze

# Code formatting
flutter format lib/
```

### 🏗️ Build Configuration
The app supports different build modes:
- **Debug**: Development with Hot Reload
- **Profile**: Performance profiling
- **Release**: Optimized for production

---

## 🔧 Configuration

### 🎨 Theming
The app theme is configured in `main.dart`:
```dart
theme: ThemeData(
  useMaterial3: false,
  colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF009940)),
),
```

### 📱 Assets
Assets are defined in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/img/
    - assets/fonts/
    - assets/videos/
```

---

## 🚀 Deployment

### 📱 Mobile App Stores
- **Google Play Store**: APK/AAB via Google Play Console
- **Apple App Store**: IPA via App Store Connect

### 🌐 Web Deployment
- **Firebase Hosting**
- **GitHub Pages**
- **Netlify**

### 🖥️ Desktop Distribution
- **Windows**: MSI/EXE Installer
- **macOS**: DMG/PKG
- **Linux**: AppImage/Snap/Flatpak

---

## 🤝 Contributing

We welcome contributions! Please read our contribution guidelines:

1. **Fork** the repository
2. **Create** a branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

---

## 📜 License

This project is licensed under the MIT License. See `LICENSE` file for details.

---

## 📞 Contact

**Project Study Team**
- 🏫 Institution: [Your University]
- 📧 Email: [Contact Email]
- 🌐 Website: [Project Website]

---

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Material Design Team** for the design guidelines
- **All Contributors** who contributed to this project

---

## 🗺️ Roadmap

### Version 1.1
- [ ] Push Notifications
- [ ] Offline Functionality
- [ ] Advanced QR Code Features

### Version 1.2
- [ ] Multi-Language Support
- [ ] Dark Mode
- [ ] Accessibility Improvements

### Version 2.0
- [ ] Backend Integration
- [ ] Real-time Tracking
- [ ] Advanced Analytics

---

<div align="center">
  <p><strong>Built with ❤️ for the future of urban logistics</strong></p>
</div>
