# Tools Box Example Application

A comprehensive Flutter application demonstrating all features of the `tools_box` package.

## Features Demonstrated

This example showcases the following utilities from the `tools_box` package:

### 1. StringUtils (String Utilities)
- Email validation (`isEmail`)
- Phone number validation (`isPhoneNumber`)
- String capitalization (`capitalize`, `capitalizeAllOf`)
- Numeric checking (`isNumeric`)
- String manipulation (`reverse`, `truncate`, `removeWhitespace`)
- URL validation (`isURL`)

### 2. ValidationUtils (Form Validation)
- Email validation with error messages
- Phone number validation
- Password strength validation
- Required field validation
- ID card and URL validation

### 3. WidgetExtensions (Widget Extension Methods)
- Padding utilities (`paddingAll`, `paddingSymmetric`, `only`)
- Layout helpers (`center`, `align`, `expand`, `flexible`, `positioned`)
- Interaction handlers (`onTap`)
- Visual effects (`opacity`, `clipRRect`, `decorated`, `visible`)
- Navigation aids (`hero`, `tooltip`, `safeArea`)

### 4. BuildContextExtensions (BuildContext Utilities)
- Screen dimensions (`screenWidth`, `screenHeight`)
- Theme access (`theme`, `textTheme`, `colorScheme`)
- Keyboard management (`isKeyboardVisible`, `hideKeyboard`)
- UI feedback (`showSnackBar`)
- Navigation helpers (`push`, `pop`)
- Dark mode detection (`isDarkMode`)

### 5. DateUtils (Date/Time Utilities)
- Date formatting (`formatDate`, `formatDateTime`)
- Relative time display (`timeAgo`)
- Date comparison (`isToday`, `isYesterday`)
- Date range operations (`startOfDay`, `endOfDay`, `daysInRange`)

### 6. PlatformUtils (Platform Detection)
- Platform identification (iOS, Android, Web, macOS, Windows, Linux)
- Device information (processor count, OS version, locale)
- Runtime mode detection (debug, release)
- Platform-specific code execution

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/dxmwl/tools_box.git
   ```

2. Navigate to the example directory:
   ```bash
   cd tools_box/example
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Requirements

- Flutter SDK >= 3.11.3
- Dart SDK >= 3.11.3

## Screenshots

The example app provides an interactive UI demonstrating each utility with real-time results.

## Usage in Your Project

To use `tools_box` in your own Flutter project:

1. Add to your `pubspec.yaml`:
   ```yaml
   dependencies:
     tools_box: ^0.1.2
   ```

2. Import and use:
   ```dart
   import 'package:tools_box/tools_box.dart';

   // String utilities
   'hello'.capitalize; // 'Hello'

   // Widget extensions
   Text('Hello').paddingAll(16).center();

   // BuildContext extensions
   final width = context.screenWidth;

   // Validation
   if ('test@example.com'.isEmail) {
     // Valid email
   }
   ```

## License

See the [LICENSE](../LICENSE) file for details.
