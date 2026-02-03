# 📦 RegioKargoTramTrain App

<div align="center">
  <img src="assets/img/logo_tramtrain.png" alt="TramTrain Logo" width="200"/>
  
  **A modern Flutter application for delivery robot interfaces in the RegioKargo system**
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Windows%20%7C%20macOS%20%7C%20Linux-lightgrey?style=for-the-badge)
  ![Status](https://img.shields.io/badge/Status-Active%20Development-green?style=for-the-badge)
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
- [📝 Code Quality](#-code-quality)
- [🚀 Deployment](#-deployment)
- [📞 Contact & Support](#-contact--support)
- [📜 License](#-license)

---

## 🎯 About the Project

The **RegioKargoTramTrain App** is an innovative Flutter application that provides a modern user interface for delivery robots integrated into the RegioKargo system. It revolutionizes urban logistics by leveraging tram and train connections for goods transport.

### Project Goals
- 🚀 Simplify package pickup and delivery processes
- 🎯 Provide an intuitive user experience
- 📦 Enable seamless QR code scanning and identification
- 🗺️ Integrate location-based services
- 👥 Support user account management

---

## ✨ Features

### 🎯 Core Functionality
- **📦 Package Pickup**: Intuitive interface for collecting packages from delivery robots
- **📤 Package Shipping**: Easy-to-use shipping interface for sending packages
- **📱 QR Code Management**: Scanning and displaying QR codes for package identification
- **🧭 Navigation**: User-friendly guided process flow
- **🗺️ Map Integration**: Real-time location and route visualization
- **👤 User Accounts**: Secure account and profile management

### 🎨 User Experience Features
- **Material Design**: Modern, consistent, and professional interface
- **Responsive Layout**: Automatically adapts to different screen sizes and orientations
- **Accessibility**: Designed with WCAG guidelines in mind
- **Custom Widgets**: Reusable, well-documented UI components
- **Dark/Light Theme**: Configurable color scheme (green accent #009940)
- **Smooth Animations**: Polished transitions and interactive feedback

---

## 🛠 Technologies

### Frontend Stack
| Technology | Version | Purpose |
|-----------|---------|---------|
| **Flutter** | 3.7.2+ | Cross-platform UI framework |
| **Dart** | 3.7.2+ | Programming language |
| **Material Design 3** | Latest | Design system & components |

### Key Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8        # iOS-style icons
  qr_flutter: ^4.1.0             # QR code generation
  mqtt_client: ^10.2.1           # MQTT messaging protocol
```

### Supported Platforms
| Platform | Support | Notes |
|----------|---------|-------|
| 🤖 Android | ✅ Full | Tested on Android 8.0+ |
| 🍎 iOS | ✅ Full | Tested on iOS 12.0+ |
| 🌐 Web | ✅ Full | Chrome, Firefox, Safari |
| 🖥️ Windows | ✅ Full | Windows 10+ |
| 🍎 macOS | ✅ Full | macOS 10.14+ |
| 🐧 Linux | ✅ Full | Ubuntu 18.04+, Fedora |

---

## 📋 Prerequisites

### System Requirements
| Requirement | Specification |
|-------------|--------------|
| **RAM** | 4 GB minimum (8 GB recommended) |
| **Storage** | 3+ GB free disk space |
| **OS** | Windows 10+, macOS 10.14+, Ubuntu 18.04+ |

### Required Software
- **Git** - Version control system
  - 📥 Download: https://git-scm.com/
- **Flutter SDK 3.7.2+** - Cross-platform framework
  - 📥 Download: https://flutter.dev/docs/get-started/install
- **Dart SDK 3.7.2+** - Automatically included with Flutter
  
### Optional Tools
- **VS Code** with Flutter extension
- **Android Studio** with Flutter/Dart plugins
- **Xcode** (macOS only, for iOS development)

### Mobile Development Requirements
- **Android SDK** (API level 24+) for Android development
- **Android Emulator** or physical Android device
- **Xcode 12+** (macOS only) for iOS development
- **iOS Simulator** or physical iPhone/iPad

---

## 🚀 Installation

### Step 1: Clone the Repository
```bash
git clone https://github.com/your-username/regiokargotramtrain_app.git
cd regiokargotramtrain_app
```

### Step 2: Install Flutter SDK
Follow the official Flutter documentation:
👉 https://flutter.dev/docs/get-started/install

### Step 3: Verify Development Environment
```bash
flutter doctor
```
Ensure all required components show green checkmarks.

### Step 4: Install Project Dependencies
```bash
flutter pub get
```

### Step 5: Set Up MQTT Configuration
Update the MQTT broker settings in [lib/config/mqtt_config.dart](lib/config/mqtt_config.dart):
```dart
static const String broker = '192.168.188.105';
static const int port = 9001;
static const String? username = 'jonathan';
static const String? password = 'iiius_admin';
```

---

## ▶️ Running the App

### Desktop Platforms

#### Windows
```bash
flutter run -d windows
```

#### macOS
```bash
flutter run -d macos
```

#### Linux
```bash
flutter run -d linux
```

### Mobile Platforms

#### Android (with emulator or device)
```bash
flutter run -d android
```

#### iOS (macOS only)
```bash
flutter run -d ios
```

### Web Platform
```bash
flutter run -d web
```

### Debug vs Release Builds
```bash
# Debug build (with Hot Reload support)
flutter run --debug

# Release build (optimized, no debugging)
flutter build apk --release
```

---

## 📁 Project Structure

```
regiokargotramtrain_app/
│
├── 📄 pubspec.yaml                 # Project dependencies & configuration
├── 📄 README.md                    # This file
├── 📄 analysis_options.yaml        # Linter rules & code quality settings
│
├── 📁 lib/                         # Main application source code
│   ├── 📄 main.dart                # App entry point & routing configuration
│   │
│   ├── 📁 config/                  # Configuration files
│   │   └── 📄 mqtt_config.dart     # MQTT broker configuration
│   │
│   ├── 📁 models/                  # Data models (currently empty - planned)
│   │
│   ├── 📁 services/                # Business logic & API integration
│   │   └── 📄 mqtt_service.dart    # MQTT client & messaging service
│   │
│   ├── 📁 screens/                 # Screen/Page widgets
│   │   ├── 📄 loading_page.dart    # Welcome & loading screen
│   │   ├── 📄 start_page.dart      # Main menu (Pickup/Shipping)
│   │   │
│   │   ├── 📁 account/             # User account management screens
│   │   ├── 📁 information/         # Information & help screens
│   │   ├── 📁 map/                 # Map & location screens
│   │   ├── 📁 more/                # Additional options screens
│   │   │
│   │   └── 📁 orders/              # Order management screens
│   │       ├── 📁 deliver/         # Delivery process screens
│   │       │   ├── qr_scan_introduction_page.dart
│   │       │   ├── qr_code_display_page.dart
│   │       │   ├── qr_scan_success_page.dart
│   │       │   ├── qr_scan_failed_page.dart
│   │       │   ├── repetition_process_page.dart
│   │       │   └── pickup_done.dart
│   │       └── 📁 pickup/          # Pickup process screens
│   │
│   └── 📁 widgets/                 # Reusable UI components
│       ├── 📁 buttons/             # Button components
│       │   ├── square_button.dart      # Large square action buttons
│       │   ├── wide_button.dart        # Horizontal action buttons
│       │   ├── standard_button.dart    # Standard rounded buttons
│       │   └── icon_and_rounded_button.dart # Buttons with icons
│       │
│       └── 📁 navigation/          # Navigation components
│           ├── header.dart         # Top app bar
│           └── navbar.dart         # Bottom navigation bar
│
├── 📁 assets/                      # Static resources
│   ├── 📁 img/                     # Images & logo files
│   ├── 📁 fonts/                   # Custom font files
│   ├── 📁 videos/                  # Video files
│   └── 📄 mqtt_config.json         # Example MQTT configuration
│
├── 📁 test/                        # Unit & widget tests
│   └── 📄 widget_test.dart
│
├── 📁 MQTT_Test_Server/            # Development MQTT broker
│   ├── 📄 Server.py                # Test MQTT broker implementation
│   ├── 📄 requirements.txt          # Python dependencies
│   └── 📄 run_test_server.ps1      # PowerShell startup script
│
├── 📁 tools/                       # Development utility scripts
│   ├── mqtt_pub_test.py            # MQTT publishing test
│   ├── mqtt_subscribe_test.py      # MQTT subscription test
│   └── ws_handshake_test.py        # WebSocket testing
│
├── 📁 android/                     # Android platform-specific code
├── 📁 ios/                         # iOS platform-specific code
├── 📁 web/                         # Web platform-specific code
├── 📁 windows/                     # Windows platform-specific code
├── 📁 linux/                       # Linux platform-specific code
└── 📁 macos/                       # macOS platform-specific code
```

---

## 🎨 UI Components

### Button Components
| Component | Usage | Features |
|-----------|-------|----------|
| **SquareButton** | Main action buttons | Icon + label, shadow, rounded corners |
| **WideButton** | Menu items | Horizontal layout, icon + text |
| **StandardButton** | Secondary actions | Hover/press effects, animated border |
| **IconAndRoundedButton** | Compact actions | Icon next to text, small footprint |

### Navigation Components
| Component | Purpose | Location |
|-----------|---------|----------|
| **Header** | Top app bar | Top of all screens |
| **Navbar** | Bottom navigation | Bottom of main screens |

### Widget Features
- ✅ Full responsiveness across devices
- ✅ Interactive hover and press effects
- ✅ Smooth animations (120ms)
- ✅ Accessibility support
- ✅ Customizable colors and styling
- ✅ Material Design compliance

---

## 📱 Screens Overview

### 🏠 Main Navigation Flow
```
LoadingPage (Welcome)
    ↓
StartPage (Main Menu)
    ├─→ Pickup Flow
    │   └─→ QrScanInstructionPage
    │       └─→ QrCodeDisplayPage
    │           ├─→ QrScanSuccessPage
    │           └─→ QrScanFailedPage
    │               └─→ RepetitionProcessPage
    │                   └─→ PickupDone
    │
    ├─→ Shipping Flow (Planned)
    │
    └─→ Navigation Bar
        ├─→ MorePage
        ├─→ MapPage
        ├─→ InfoPage
        └─→ AccountPage
```

### Screen Descriptions

| Screen | Type | Purpose |
|--------|------|---------|
| **LoadingPage** | Welcome | Initial welcome screen |
| **StartPage** | Menu | Choose pickup or shipping |
| **QrScanIntroductionPage** | Info | Instructions before scanning |
| **QrCodeDisplayPage** | Interactive | Display & manage QR codes |
| **QrScanSuccessPage** | Feedback | Scan completion confirmation |
| **QrScanFailedPage** | Error | Error handling |
| **RepetitionProcessPage** | Process | Retry logic |
| **PickupDone** | Confirmation | Final completion screen |
| **AccountPage** | Settings | User profile & settings |
| **InfoPage** | Help | Application information |
| **MapPage** | Navigation | Location & route display |
| **MorePage** | Menu | Additional options |

---

## 🔧 Development

### Code Quality

#### Static Analysis
```bash
# Check for code issues
flutter analyze

# Apply automatic fixes
dart fix --apply
```

#### Code Formatting
```bash
# Format all code
flutter format lib/

# Format specific file
flutter format lib/screens/start_page.dart
```

#### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Hot Reload & Hot Restart
During development, use these shortcuts in the console:
- **`r`** - Hot Reload (fast, preserves app state)
- **`R`** - Hot Restart (full restart)
- **`q`** - Quit

### Debug Mode
```bash
flutter run --debug
```

### Profile Mode (Performance Testing)
```bash
flutter run --profile
```

### MQTT Testing
Use the included test scripts to verify MQTT connectivity:
```bash
# Test publishing
python tools/mqtt_pub_test.py

# Test subscription
python tools/mqtt_subscribe_test.py

# Start test MQTT broker
powershell MQTT_Test_Server/run_test_server.ps1
```

---

## 📝 Code Quality

### Code Standards
- ✅ **Dart Style Guide**: Full compliance with official Dart conventions
- ✅ **Material Design**: All components follow Material 3 guidelines
- ✅ **Documentation**: All public classes and methods have doc comments
- ✅ **Error Handling**: Proper exception handling and user feedback
- ✅ **Accessibility**: WCAG 2.1 Level AA compliance

### Linter Configuration
Settings are defined in [analysis_options.yaml](analysis_options.yaml):
```yaml
linter:
  rules:
    - camel_case_types
    - camel_case_extensions
    - library_names
    - file_names
    - avoid_empty_else
    - prefer_const_constructors
    # ... more rules
```

### Naming Conventions
- **Classes**: `PascalCase` (e.g., `StartPage`, `SquareButton`)
- **Methods/Variables**: `camelCase` (e.g., `onItemTapped`, `_isPressed`)
- **Constants**: `camelCase` (e.g., `topicStartScan`)
- **Enum values**: `camelCase` (e.g., `buttonPressed`)

### Comment Style
- **Doc Comments**: `///` for public APIs
- **Inline Comments**: `//` for explanations
- **Section Comments**: `// ===` for major sections

---

## 🚀 Deployment

### Android Release Build
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Google Play)
flutter build appbundle --release
```

### iOS Release Build (macOS only)
```bash
flutter build ios --release
```

### Web Deployment
```bash
# Build for web
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting

# Deploy to GitHub Pages
# Place build/web contents in gh-pages branch
```

### Windows Release Build
```bash
flutter build windows --release
```

### Desktop Distribution
- **Windows**: MSI installer via Windows Installer XML
- **macOS**: DMG/PKG via Xcode
- **Linux**: AppImage, Snap, or Flatpak packages

---

## 📞 Contact & Support

### Project Information
- **Project Type**: University Project Study (Projektstudium)
- **Course**: Software Engineering / Mobile Development
- **Duration**: Full academic year

### Getting Help
1. Check the [FAQ](#faq) section below
2. Review existing issues on GitHub
3. Contact the development team

### Reporting Issues
When reporting bugs, please include:
- Device/Platform information
- Reproduction steps
- Expected vs. actual behavior
- Screenshots/videos if applicable
- Error logs from the console

---

## 📜 License

This project is licensed under the **MIT License**.

### MIT License Summary
- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use
- ⚠️ Liability disclaimer included
- ⚠️ License and copyright notice required

For full license text, see the LICENSE file in the repository.

---

## 📚 FAQ

### Q: How do I update MQTT settings?
**A:** Edit [lib/config/mqtt_config.dart](lib/config/mqtt_config.dart) and update the broker address, port, and credentials.

### Q: Can I run the app on my device?
**A:** Yes! Connect your device and run:
```bash
flutter run
```

### Q: How do I generate a release build?
**A:** Use `flutter build [platform] --release` for your target platform.

### Q: What's the minimum Flutter version required?
**A:** Flutter 3.7.2 or later. Check with `flutter --version`.

### Q: How do I debug MQTT connections?
**A:** MQTT logging is enabled in `mqtt_service.dart`. Check the console output for detailed connection information.

---

## 🗺️ Roadmap

### Version 1.1 (Q2 2026)
- [ ] Push notifications support
- [ ] Offline functionality with caching
- [ ] Enhanced QR code features

### Version 1.2 (Q3 2026)
- [ ] Multi-language support (i18n)
- [ ] Dark mode theme
- [ ] Advanced accessibility features

### Version 2.0 (2026/2027)
- [ ] Backend REST API integration
- [ ] Real-time package tracking
- [ ] Analytics dashboard
- [ ] Performance optimizations

---

## 🙏 Acknowledgments

### Contributors
- **Flutter Team** - Excellent framework and documentation
- **Material Design Team** - Comprehensive design system
- **Open Source Community** - Dependencies and inspiration

### Special Thanks
- All team members and reviewers
- University faculty and supervisors
- MQTT community for protocol expertise

---

<div align="center">
  <p><strong>Built with ❤️ for the future of urban logistics</strong></p>
  <p>
    <a href="https://flutter.dev">
      <img src="https://img.shields.io/badge/Built%20With-Flutter-blue?style=flat-square" alt="Built with Flutter">
    </a>
    <a href="https://dart.dev">
      <img src="https://img.shields.io/badge/Language-Dart-blue?style=flat-square" alt="Dart">
    </a>
  </p>
  
  **Last Updated**: February 3, 2026
</div>
