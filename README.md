# tools_box

[![Pub Version](https://img.shields.io/pub/v/tools_box)](https://pub.dev/packages/tools_box)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Dart SDK](https://img.shields.io/badge/sdk-%5E3.11.3-blue.svg)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D1.17.0-blue.svg)](https://flutter.dev)

**English** | [简体中文](README.zh-CN.md)

A comprehensive Flutter utility toolkit providing string manipulation, date formatting, widget extensions, form validation, and platform detection utilities to help developers improve development efficiency.

## Features

- **StringUtils** - String extension methods (email/phone validation, formatting, truncation, etc.)
- **DateUtils** - Date/time utility class (formatting, relative time, date ranges, etc.)
- **WidgetExtensions** - Convenient Widget extension methods (padding, centering, rounded corners, etc.)
- **BuildContextExtensions** - BuildContext extensions (screen dimensions, SnackBar, navigation, etc.)
- **ValidationUtils** - Form validation utilities (email, phone, password validation, etc.)
- **PlatformUtils** - Platform detection utilities (Android/iOS/Web/Windows/macOS/Linux)
- **ListUtils** - List extension methods (firstOrDefault, chunked, groupBy, numeric operations, etc.)
- **NumUtils** - Number formatting and operations (currency, percentage, file size, etc.)
- **ColorUtils** - Color conversion and manipulation (hex, lighten/darken, HSL, etc.)

## Getting Started

### Add Dependency

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tools_box: ^0.1.3
```

### Import Package

```dart
import 'package:tools_box/tools_box.dart';
```

---

### ListUtils -> [list_utils.dart](lib/src/list_utils.dart) -> [Demo](example/lib/main.dart)

#### A. List Extension Methods

```dart
firstOrDefault([T? defaultValue])           : Get first element or default value
lastOrDefault([T? defaultValue])            : Get last element or default value
unique()                                    : Remove duplicates (returns unique list)
chunked(int size)                           : Split list into chunks of specified size
groupBy(K Function(T) keyFn)                : Group elements by key function
skipFirst(int count)                        : Skip first N elements
skipLast(int count)                         : Skip last N elements
getOrNull(int index)                        : Get element at index (null if out of range)
findFirst(bool Function(T) test)            : Find first matching element
findLast(bool Function(T) test)             : Find last matching element
swap(int index1, int index2)                : Swap two elements by index
cyclic(int index)                           : Get element with cyclic indexing (wraps around)
```

#### B. NumericListUtils (for List<num>)

```dart
sum                                         : Calculate sum of all elements
average                                     : Calculate average of all elements
min                                          : Get minimum value
max                                          : Get maximum value
median                                       : Get median value
```

**Usage Examples:**

```dart
import 'package:tools_box/tools_box.dart';

// Basic list operations
final list = [1, 2, 3, 4, 5];

list.firstOrDefault;                       // 1
list.firstOrDefault(-1);                   // 1
[].firstOrDefault('empty');               // 'empty'

list.lastOrDefault;                        // 5
list.getOrNull(10);                        // null (out of range)
list.getOrNull(2);                         // 3

// Unique and chunked
[1, 2, 2, 3, 3, 3].unique();              // [1, 2, 3]
[1, 2, 3, 4, 5, 6, 7].chunked(3);         // [[1, 2, 3], [4, 5, 6], [7]]

// Skip operations
list.skipFirst(2);                         // [3, 4, 5]
list.skipLast(2);                          // [1, 2, 3]

// Find operations
list.findFirst((e) => e > 3);             // 4
list.findLast((e) => e < 4);              // 3

// Swap and cyclic
final mutable = ['a', 'b', 'c'];
mutable.swap(0, 2);                        // ['c', 'b', 'a']
list.cyclic(7);                            // 3 (wraps around: 7 % 5 = 2)

// GroupBy
final users = [
  {'name': 'Alice', 'dept': 'Engineering'},
  {'name': 'Bob', 'dept': 'Marketing'},
  {'name': 'Charlie', 'dept': 'Engineering'},
];
users.groupBy((u) => u['dept']);
// {'Engineering': [Alice, Charlie], 'Marketing': [Bob]}

// NumericListUtils
final numbers = [10, 20, 30, 40, 50];
numbers.sum;                               // 150
numbers.average;                           // 30.0
numbers.min;                               // 10
numbers.max;                               // 50
numbers.median;                            // 30
```

---

### NumUtils -> [num_utils.dart](lib/src/num_utils.dart) -> [Demo](example/lib/main.dart)

```dart
formatWithCommas({int? decimals})          : Format number with comma separators (e.g., 1,234.56)
toCurrency({String symbol, int decimals})   : Format as currency string (default: \$)
toPercentage({int decimals})                : Format as percentage string
clampRange(num min, num max)               : Clamp value within range
isBetween(num min, num max)                : Check if value is in range (exclusive)
isWithin(num min, num max)                 : Check if value is in range (inclusive)
toDurationString()                          : Convert to human-readable duration (seconds -> HH:MM:SS)
toFileSize({int decimals})                  : Convert bytes to human-readable file size
roundTo(int decimalPlaces)                 : Round to specified decimal places
isPositive                                  : Check if positive (> 0)
isNegative                                  : Check if negative (< 0)
isZero                                      : Check if zero
isEven                                       : Check if even number
isOdd                                        : Check if odd number
```

**Usage Examples:**

```dart
import 'package:tools_box/tools_box.dart';

// Number formatting
1234.5678.formatWithCommas;                // '1,234.57'
1234567.formatWithCommas(decimals: 0);     // '1,234,567'
99.99.toCurrency();                          // '\$99.99'
99.99.toCurrency(symbol: '€');             // '€99.99'
1999.99.toCurrency(symbol: '¥', decimals: 0); // '¥2,000'
0.756.toPercentage();                       // '75.6%'
0.756.toPercentage(decimals: 2);            // '75.60%'

// Range operations
5.clampRange(1, 10);                        // 5
15.clampRange(1, 10);                       // 10
-5.clampRange(1, 10);                       // 1
5.isBetween(1, 10);                         // true (1 < 5 < 10)
10.isWithin(1, 10);                         // true (1 <= 10 <= 10)

// Special conversions
3661.toDurationString();                    // '01:01:01' (1h 1m 1s)
1048576.toFileSize();                       // '1.00 MB'
1536.toFileSize(decimals: 2);              // '1.50 KB'
3.14159265.roundTo(4);                      // 3.1416

// Property checks
42.isPositive;                              // true
-7.isNegative;                              // true
0.isZero;                                   // true
4.isEven;                                   // true
7.isOdd;                                    // true

// Practical example: File size display
final fileSize = getFileSizeInBytes();
print('File size: ${fileSize.toFileSize()}');
// Output: File size: 2.35 MB

// Practical example: Price formatting
final price = calculatePrice();
print('Total: ${price.toCurrency(symbol: '\$', decimals: 2)}');
// Output: Total: $123.45
```

---

### ColorUtils -> [color_utils.dart](lib/src/color_utils.dart) -> [Demo](example/lib/main.dart)

#### A. Hex Conversion

```dart
fromHex(String hexString)                  : Parse hex color string to Color (#RGB, #RRGGBB, #RRGGBBAA)
toHex({bool includeAlpha, bool hashPrefix}) : Convert Color to hex string
```

#### B. Color Manipulation

```dart
lighten(double amount)                     : Lighten color (0.0 - 1.0)
darken(double amount)                      : Darken color (0.0 - 1.0)
mix(Color other, double weight)            : Blend two colors (weight: 0.0 - 1.0)
withOpacity(double opacity)                 : Set alpha/opacity (0.0 - 1.0)
```

#### C. Color Components & Analysis

```dart
getRed                                      : Get red component (0 - 255)
getGreen                                    : Get green component (0 - 255)
getBlue                                     : Get blue component (0 - 255)
getAlpha                                    : Get alpha component (0 - 255)
isDark                                      : Check if color is dark
isLight                                     : Check if color is light
contrastingText({Color darkText, Color lightText}) : Get contrasting text color for readability
random()                                    : Generate random color (static method)
```

#### D. HSL Conversions

```dart
toHSL()                                     : Convert to HSL color model
fromHSL(double h, double s, double l)       : Create color from HSL values (static method)
```

**Usage Examples:**

```dart
import 'package:flutter/material.dart';
import 'package:tools_box/tools_box.dart';

// Hex conversions
ColorUtils.fromHex('#FF5722');              // Color(0xFFFF5722)
ColorUtils.fromHex('#RGB');                 // Supports shorthand
Colors.blue.toHex();                        // '#2196F3'
Colors.blue.toHex(includeAlpha: true);      // '#FF2196F3'
Colors.blue.toHex(hashPrefix: false);       // '2196F3'

// Lighten/Darken
Colors.blue.lighten(0.2);                   // Lighter blue
Colors.blue.darken(0.3);                    // Darker blue

// Mix colors
Colors.red.mix(Colors.blue, 0.5);          // Purple blend
Colors.white.mix(Colors.black, 0.3);       // Dark gray

// Opacity
Colors.red.withOpacity(0.5);               // Semi-transparent red

// Color components
final color = Color(0xFF4CAF50);
color.getRed;                               // 76
color.getGreen;                             // 175
color.getBlue;                              // 80
color.getAlpha;                             // 255

// Color analysis
Colors.black.isDark;                        // true
Colors.white.isLight;                       // true
Colors.blue.contrastingText();              // Returns white or black text based on luminance
Colors.blue.contrastingText(
  darkText: Colors.yellow,
  lightText: Colors.black,
);

// Random color
final randomColor = ColorUtils.random();    // Random Color

// HSL conversions
final hsl = Colors.red.toHSL();
// Returns HSLColor with hue, saturation, lightness
final fromHsl = ColorUtils.fromHSL(120, 0.5, 0.5); // Green from HSL

// Practical UI examples
Container(
  color: Theme.of(context).primaryColor.lighten(0.1),
  child: Text(
    'Readable Text',
    style: TextStyle(color: bgColor.contrastingText()),
  ),
)

// Gradient generation
List.generate(5, (i) =>
  baseColor.mix(targetColor, i / 4)
);

// Dynamic theme colors
final primary = ColorUtils.fromHex(userSettings.primaryColor);
final surface = primary.isDark ? primary.lighten(0.9) : primary.darken(0.05);
```

---

## APIs

### StringUtils -> [string_utils.dart](lib/src/string_utils.dart) -> [Demo](example/lib/main.dart#L71-L89)

```dart
isEmail                      : Validate email format
isPhoneNumber                : Validate Chinese phone number (11 digits, starts with 1)
capitalize                   : Capitalize first letter
capitalizeAllOf              : Capitalize first letter of each word
isNumeric                    : Check if numeric string
reverse                      : Reverse string
nullIfEmpty                  : Convert empty string to null
truncate(int length)         : Truncate string (supports custom suffix)
removeWhitespace             : Remove all whitespace characters
isURL                        : Validate URL format
```

**Usage Examples:**

```dart
import 'package:tools_box/tools_box.dart';

// Validation
'test@example.com'.isEmail;           // true
'13812345678'.isPhoneNumber;          // true
'https://example.com'.isURL;          // true
'12345'.isNumeric;                    // true

// Formatting
'hello'.capitalize;                   // 'Hello'
'hello world'.capitalizeAllOf;        // 'Hello World'
'flutter'.reverse;                    // 'rettulf'

// Utilities
'This is a very long string for testing'.truncate(10); // 'This is a ve...'
'  hello world  '.removeWhitespace;  // 'helloworld'
''.nullIfEmpty;                       // null
```

---

### DateUtils -> [date_utils.dart](lib/src/date_utils.dart) -> [Demo](example/lib/main.dart)

```dart
formatDate(DateTime, {pattern})       : Format date (default: yyyy-MM-dd)
formatDateTime(DateTime, {pattern})   : Format datetime (default: yyyy-MM-dd HH:mm:ss)
timeAgo(DateTime)                     : Calculate relative time (e.g., 5 minutes ago, 2 hours ago)
isToday(DateTime)                     : Check if today
isYesterday(DateTime)                 : Check if yesterday
startOfDay(DateTime)                  : Get start of day (00:00:00)
endOfDay(DateTime)                    : Get end of day (23:59:59)
daysInRange(start, end)               : Generate list of dates in range
```

**Usage Examples:**

```dart
final now = DateTime.now();

// Format dates
DateUtils.formatDate(now);                              // '2024-01-15'
DateUtils.formatDate(now, pattern: 'MM/dd/yyyy');        // '01/15/2024'

// Relative time (English)
DateUtils.timeAgo(now.subtract(Duration(minutes: 5)));   // '5 minutes ago'
DateUtils.timeAgo(now.subtract(Duration(hours: 2)));     // '2 hours ago'
DateUtils.timeAgo(now.subtract(Duration(days: 1)));      // '1 day ago'

// Date comparison
DateUtils.isToday(now);                                   // true
DateUtils.isYesterday(now.subtract(Duration(days: 1)));  // true

// Time boundaries
DateUtils.startOfDay(now);  // DateTime(2024, 1, 15, 0, 0, 0)
DateUtils.endOfDay(now);    // DateTime(2024, 1, 15, 23, 59, 59)

// Date ranges
final days = DateUtils.daysInRange(start, end);           // Returns list of dates
```

---

### WidgetExtensions -> [widget_extensions.dart](lib/src/widget_extensions.dart#L8-L110) -> [Demo](example/lib/main.dart#L129-L193)

```dart
paddingAll(double value)                           : Equal padding on all sides
paddingSymmetric({horizontal, vertical})            : Horizontal/vertical padding
only({left, top, right, bottom})                    : Custom direction padding
center()                                            : Center alignment
align({alignment})                                  : Custom alignment
expand({flex})                                       : Expanded wrapper
flexible({flex, fit})                                : Flexible wrapper
positioned({left, top, right, bottom})               : Absolute positioning (for Stack)
onTap(VoidCallback)                                  : Add tap event handler
sizedBox({width, height})                            : Set fixed dimensions
clipRRect({radius})                                  : Rounded corner clipping
decorated({decoration, position})                    : Add decoration (background, border, etc.)
opacity(double opacity)                               : Set transparency (0.0-1.0)
safeArea({top, bottom})                              : Safe area adaptation
hero(Object tag)                                     : Hero animation tag
tooltip(String message)                               : Hover tooltip message
visible(bool visible, {replacement})                 : Control visibility state
```

**Usage Examples:**

```dart
import 'package:flutter/material.dart';
import 'package:tools_box/tools_box.dart';

// Basic usage
Text('Hello').paddingAll(16);
Text('Hello').paddingSymmetric(horizontal: 20, vertical: 10);
Text('Centered').center();
Container().expand(flex: 1);
Icon(Icons.star).onTap(() => print('clicked!'));
Image.network(url).clipRRect(radius: 12);

// Chained calls example
Text('Chained example')
    .paddingAll(16)
    .center()
    .onTap(() => print('tapped!'))
    .decorated(decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue),
    ));
```

---

### BuildContextExtensions -> [widget_extensions.dart](lib/src/widget_extensions.dart#L112-L139) -> [Demo](example/lib/main.dart#L196-L234)

```dart
screenWidth                                          : Get screen width
screenHeight                                         : Get screen height
theme                                                : Get ThemeData
textTheme                                            : Get TextTheme
colorScheme                                          : Get ColorScheme
isKeyboardVisible                                    : Check keyboard visibility
isDarkMode                                           : Check dark mode
hideKeyboard()                                        : Hide keyboard
showSnackBar(String message)                          : Show SnackBar notification
push<T>(WidgetBuilder builder)                        : Page navigation (push)
pop<T>([T? result])                                   : Page return (pop)
```

**Usage Examples:**

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final width = context.screenWidth;
    final height = context.screenHeight;

    // Get theme data
    final theme = context.theme;
    final colorScheme = context.colorScheme;

    // Dark mode check
    if (context.isDarkMode) {
      // Dark theme logic
    }

    // Keyboard state
    if (context.isKeyboardVisible) {
      // Keyboard is visible
    }

    // Action methods
    context.hideKeyboard();
    context.showSnackBar('Operation successful!');
    context.push((ctx) => DetailPage());
    context.pop();

    return Container();
  }
}
```

---

### ValidationUtils -> [validation_utils.dart](lib/src/validation_utils.dart) -> [Demo](example/lib/main.dart#L92-L127)

#### A. Basic Validation Methods (returns bool)

```dart
isValidEmail(String email)                             : Email format validation
isValidPhone(String phone)                              : Chinese phone number validation
isValidPassword(String password, {minLength})            : Password length validation (min 6 by default)
isValidURL(String url)                                  : URL format validation
isValidIDCard(String idCard)                            : ID card number validation (18 digits)
isChinese(String text)                                  : Chinese character detection
containsOnlyNumbers(String text)                        : Pure number detection
containsOnlyLetters(String text)                        : Pure letter detection
containsOnlyLettersAndNumbers(String text)              : Alphanumeric detection
```

#### B. Form Validation Methods (returns String? or null)

```dart
validateEmail(String? value)                            : Form email validation (for TextFormField)
validatePhone(String? value)                            : Form phone number validation
validatePassword(String? value, {minLength})             : Form password validation
validateRequired(String? value, {fieldName})             : Required field validation (customizable field name)
```

**Usage Examples:**

```dart
// Basic validation (returns bool)
ValidationUtils.isValidEmail('test@example.com');        // true
ValidationUtils.isValidPhone('13812345678');             // true
ValidationUtils.isChinese('Hello World');                // false

// Form validation (returns error message or null)
ValidationUtils.validateEmail('invalid-email');          // 'Please enter a valid email address'
ValidationUtils.validateEmail('test@example.com');       // null (validation passed)
ValidationUtils.validatePhone('');                       // 'Phone number cannot be empty'
ValidationUtils.validateRequired('', fieldName: 'Username'); // 'Username cannot be empty'

// Use in TextFormField
TextFormField(
  decoration: InputDecoration(labelText: 'Email'),
  validator: (value) => ValidationUtils.validateEmail(value),
)

TextFormField(
  decoration: InputDecoration(labelText: 'Phone'),
  validator: (value) => ValidationUtils.validatePhone(value),
)

TextFormField(
  obscureText: true,
  decoration: InputDecoration(labelText: 'Password'),
  validator: (value) => ValidationUtils.validatePassword(value, minLength: 8),
)
```

---

### PlatformUtils -> [platform_utils.dart](lib/src/platform_utils.dart) -> [Demo](example/lib/main.dart)

#### A. Platform Detection Properties

```dart
isWeb                        : Check if Web platform
isAndroid                    : Check if Android platform
isIOS                        : Check if iOS platform
isMacOS                      : Check if macOS platform
isWindows                    : Check if Windows platform
isLinux                      : Check if Linux platform
isFuchsia                    : Check if Fuchsia platform
isMobile                     : Check if mobile device (Android or iOS)
isDesktop                    : Check if desktop (macOS, Windows or Linux)
```

#### B. Platform Information Properties

```dart
platformName                 : Get platform name (English: Web, Android, iOS...)
platformNameCN               : Get platform name (Chinese locale)
operatingSystem              : Get OS identifier
operatingSystemVersion       : Get OS version
currentLocale                : Get current system locale
localHostname                : Get local hostname
numberOfProcessors            : Get processor core count (null on web)
pathSeparator                : Get path separator (null on web)
```

#### C. Runtime Mode Detection

```dart
isRelease                    : Check if Release mode
isDebug                      : Check if Debug mode
```

#### D. Feature Support Detection

```dart
supportsFileSystem()          : Check file system support (false on web)
supportsNetworkSockets()      : Check network socket support
supportsProcessInfo()         : Check process info support
```

#### E. Platform-Specific Execution

```dart
runOnPlatform({...})          : Execute callbacks per platform (no return value)
runOnPlatformWithResult<T>({...}) : Execute callbacks per platform (with return value)
```

**Usage Examples:**

```dart
import 'package:tools_box/tools_box.dart';

// Basic platform detection
if (PlatformUtils.isAndroid) {
  print('Running on Android');
} else if (PlatformUtils.isIOS) {
  print('Running on iOS');
} else if (PlatformUtils.isWeb) {
  print('Running in browser');
}

// Get platform information
print('Platform: ${PlatformUtils.platformName}');
print('Locale: ${PlatformUtils.currentLocale}');

// Mobile/Desktop detection
if (PlatformUtils.isMobile) {
  // Mobile-specific logic (e.g., touch gestures)
} else if (PlatformUtils.isDesktop) {
  // Desktop-specific logic (e.g., keyboard shortcuts)
}

// Runtime mode check
if (PlatformUtils.isDebug) {
  print('Debug mode - verbose logging enabled');
}

// Platform-specific execution
PlatformUtils.runOnPlatform(
  onAndroid: () => print('Android initialization'),
  onIOS: () => print('iOS initialization'),
  onWeb: () => print('Web initialization'),
  onWindows: () => print('Windows initialization'),
  onMacOS: () => print('macOS initialization'),
  onLinux: () => print('Linux initialization'),
  onMobile: () => print('Mobile common logic'),
  onDesktop: () => print('Desktop common logic'),
);

// Platform execution with return values
final String storagePath = PlatformUtils.runOnPlatformWithResult(
  onWeb: () => 'web_storage',
  onAndroid: () => '/sdcard/data',
  onIOS: () => NSHomeDirectory(),
  onOther: () => './data',
);

// File system support check
if (PlatformUtils.supportsFileSystem()) {
  final file = File('${PlatformUtils.pathSeparator}data${PlatformUtils.pathSeparator}config.json');
}
```

**UI Usage Example:**

```dart
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('Current Platform: ${PlatformUtils.platformName}'),

      if (PlatformUtils.isMobile)
        ElevatedButton(
          onPressed: () => _handleMobileAction(),
          child: Text('Mobile Action'),
        ),

      if (PlatformUtils.isDesktop)
        ElevatedButton(
          onPressed: () => _handleDesktopAction(),
          child: Text('Desktop Action'),
        ),

      if (PlatformUtils.isDebug)
        Text('Debug Build', style: TextStyle(color: Colors.orange)),
    ],
  );
}
```

---

## Example Application

Check the `example` directory for complete usage examples:

```bash
cd example
flutter run
```

The example application demonstrates actual usage effects of all feature modules.

## Development Guide

### Local Development

If you want to contribute to or modify this package:

1. Clone the repository:
```bash
git clone https://github.com/dxmwl/tools_box.git
cd tools_box
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run tests:
```bash
flutter test
```

4. Launch example app:
```bash
cd example
flutter pub get
flutter run
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/tools_box_test.dart

# Generate coverage report
flutter test --coverage
```

### Code Style

```bash
# Format code
dart format .

# Static analysis
flutter analyze
```

## Test Coverage

Current version includes **17 unit tests** covering all core functionality modules:

- StringUtils test cases (5 tests)
- DateUtils test cases (3 tests)
- ValidationUtils test cases (3 tests)
- PlatformUtils test cases (6 tests)

Run `flutter test` to see detailed test results.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards

- Follow Dart official style guide
- Write documentation comments for public APIs
- New features must include corresponding unit tests
- Ensure `flutter analyze` has no errors
- Ensure all `flutter test` cases pass

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version update history.

## License

This project is open-sourced under [MIT License](LICENSE).

## Acknowledgments

Thanks to all contributors and the Flutter community!

## Contact

- Bug Reports: [GitHub Issues](https://github.com/dxmwl/tools_box/issues)
- Feature Requests: [GitHub Discussions](https://github.com/dxmwl/tools_box/discussions)

---

**Making Flutter development simpler and more efficient!**
