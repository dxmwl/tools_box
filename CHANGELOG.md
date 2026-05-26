# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2026-05-26

### Added - New Features

#### ListUtils (List Operation Utilities)
- `firstOrDefault` / `lastOrDefault` - Safe element access with defaults
- `unique` - Remove duplicates while preserving order
- `chunked(int size)` - Split list into chunks of specified size
- `groupBy<K>(keyFn)` - Group elements by key function
- `skipFirst` / `skipLast` - Skip elements from start or end
- `getOrNull(index)` - Safe index access with bounds checking
- `findFirst(predicate)` / `findLast(predicate)` - Find elements matching predicate
- `swap(i, j)` - Swap two elements in place
- `cyclic(index)` - Cyclic/wrapping element access
- Numeric extensions: `sum`, `average`, `minValue`, `maxValue`, `median`

#### NumUtils (Number Formatting & Operations)
- `formatWithCommas` - Format number with thousand separators
- `toCurrency({symbol})` - Format as currency string
- `toPercentage({decimalPlaces})` - Convert to percentage string
- `formatNumber({decimalPlaces})` - Format with decimal places
- `clampRange(min, max)` - Clamp value within range
- `isBetween(min, max)` / `isWithin(min, max)` - Range checking
- `toDurationString()` - Convert seconds to human-readable duration
- `toFileSize()` - Convert bytes to human-readable file size
- `roundTo(decimalPlaces)` - Round to specified decimal places
- `isPositive` / `isNegative` / `isZero` / `isNonZero` - Sign checks
- `isEven` / `isOdd` - Parity checks
- `differenceFrom(other)` - Absolute difference calculation
- `atMost(maxValue)` / `atLeast(minValue)` - Value capping
- `times<T>(callback)` - Repeat callback n times

#### ColorUtils (Color Conversion & Manipulation)
- `fromHex(hexString)` - Parse hex string to Color
- `toHex({includeAlpha})` - Convert Color to hex string
- `lighten(amount)` / `darken(amount)` - Adjust color brightness
- `mix(color1, color2, ratio)` - Blend two colors together
- `withOpacity(color, opacity)` - Adjust alpha/opacity
- `getRed` / `getGreen` / `getBlue` / `getAlpha` - Extract color components
- `isDark(color)` / `isLight(color)` - Luminance-based detection
- `contrastingText(backgroundColor)` - Get readable text color
- `random({minAlpha, maxAlpha})` - Generate random colors
- `toHSL(color)` / `fromHSL(h, s, l)` - HSL color space conversions
- Color extension methods: `toHex()`, `lighten()`, `darken()`, `mixWith()`, etc.

### Documentation
- Updated README.md with new utility APIs (English)
- Updated README.zh-CN.md with new utility APIs (Chinese)
- Added comprehensive examples for all new methods

### Testing
- Test coverage expanded for new utilities

---

## [0.1.2] - 2026-05-25

### Added - New Features

#### PlatformUtils (Platform Detection Utilities)
- `isWeb` - Check if running on Web platform
- `isAndroid` - Check if running on Android platform
- `isIOS` - Check if running on iOS platform
- `isMacOS` - Check if running on macOS platform
- `isWindows` - Check if running on Windows platform
- `isLinux` - Check if running on Linux platform
- `isFuchsia` - Check if running on Fuchsia platform
- `isMobile` - Check if mobile device (Android or iOS)
- `isDesktop` - Check if desktop (macOS, Windows or Linux)
- `platformName` - Get platform name (English)
- `platformNameCN` - Get platform name (Chinese)
- `operatingSystem` - Get OS identifier
- `operatingSystemVersion` - Get OS version
- `currentLocale` - Get current system locale
- `localHostname` - Get local hostname
- `numberOfProcessors` - Get CPU core count
- `pathSeparator` - Get path separator
- `isRelease` / `isDebug` - Runtime mode detection
- `supportsFileSystem()` - File system support check
- `supportsNetworkSockets()` - Network socket support check
- `supportsProcessInfo()` - Process info support check
- `runOnPlatform({...})` - Execute callbacks per platform (no return value)
- `runOnPlatformWithResult<T>({...})` - Execute callbacks per platform (with return value)

### Documentation
- Updated README.md with PlatformUtils API documentation
- Updated Features list with platform detection features

### Testing
- Added PlatformUtils test cases (6 tests)
- Coverage for platform detection, name retrieval, and conditional execution

---

## [0.1.1] - 2026-05-23

### Changed - Improvements

#### Project Structure Optimization
- Renamed `example_app` directory to `example` (follows Flutter package conventions)
- Added `.pubignore` file (optimized pub.dev publishing config)
- Updated `.gitignore` path references
- Updated all documentation path references (README.md, CODE_WIKI.md)

#### Documentation Improvements
- Reorganized README.md with clear API list format
- Each module shows source file link and Demo link
- Used code blocks for method names and descriptions
- Improved readability and search efficiency
- Updated CODE_WIKI.md directory references
- Updated CHANGELOG.md example app name

#### Package Publishing Configuration
- Resolved Pub validation warning: "checked-in files are ignored by .gitignore"
- Added .pubignore to exclude example directory (should not publish to pub.dev)
- Optimized package structure following Flutter package best practices

### Dependencies
- No new dependencies added

---

## [0.1.0] - 2026-05-23

### Added - New Features

#### StringUtils (String Utilities)
- `isEmail` - Email format validation
- `isPhoneNumber` - Chinese phone number validation
- `capitalize` - Capitalize first letter
- `capitalizeAllOf` - Capitalize each word's first letter
- `isNumeric` - Check if numeric string
- `reverse` - Reverse string
- `nullIfEmpty` - Convert empty string to null
- `truncate` - String truncation (custom suffix support)
- `removeWhitespace` - Remove all whitespace characters
- `isURL` - URL format validation

#### DateUtils (Date/Time Utilities)
- `formatDate` - Date formatting (custom pattern support)
- `formatDateTime` - Date/time formatting
- `timeAgo` - Relative time display (Chinese, e.g., 5 minutes ago, 2 hours ago)
- `isToday` - Check if today
- `isYesterday` - Check if yesterday
- `startOfDay` - Get start of day
- `endOfDay` - Get end of day
- `daysInRange` - Generate date list in range

#### WidgetExtensions (Widget Extension Methods)
- `paddingAll` - Equal padding on all sides
- `paddingSymmetric` - Horizontal/vertical padding
- `only` - Custom direction padding
- `center` - Center alignment
- `align` - Custom alignment
- `expand` - Expanded wrapper
- `flexible` - Flexible wrapper
- `positioned` - Absolute positioning
- `onTap` - Add tap event handler
- `sizedBox` - Set dimensions
- `clipRRect` - Rounded corner clipping
- `decorated` - Add decoration (background, border, etc.)
- `opacity` - Set transparency
- `safeArea` - Safe area wrapper
- `hero` - Hero animation tag
- `tooltip` - Tooltip message
- `visible` - Control visibility

#### BuildContextExtensions (BuildContext Extensions)
- `screenWidth` - Get screen width
- `screenHeight` - Get screen height
- `theme` - Get ThemeData
- `textTheme` - Get TextTheme
- `colorScheme` - Get ColorScheme
- `isKeyboardVisible` - Check keyboard visibility
- `hideKeyboard` - Hide keyboard
- `showSnackBar` - Show SnackBar
- `push` - Page navigation (navigate)
- `pop` - Page return (go back)
- `isDarkMode` - Check dark mode

#### ValidationUtils (Form Validation Utilities)
- `isValidEmail` - Email validity validation
- `isValidPhone` - Phone number validity validation
- `isValidPassword` - Password validity validation (min length support)
- `isValidURL` - URL validity validation
- `isValidIDCard` - ID card number validation
- `isChinese` - Chinese character detection
- `containsOnlyNumbers` - Pure number detection
- `containsOnlyLetters` - Pure letter detection
- `containsOnlyLettersAndNumbers` - Letter and number detection
- `validateEmail` - Form email validation (error message or null)
- `validatePhone` - Form phone number validation
- `validatePassword` - Form password validation
- `validateRequired` - Required field validation

### Dependencies
- Added `intl: ^0.19.0 || ^0.20.0` for date formatting

### Testing
- Added 11 unit test cases
- Coverage of StringUtils, DateUtils, ValidationUtils core functionality
- All tests passed

### Documentation
- Complete README.md documentation
- Detailed usage examples and API documentation
- Development guide and contribution guide
- Created example application (example)

### Project Setup
- Updated pubspec.yaml configuration
- Set version to 0.1.0
- Added repository URL and issue tracker links
- Configured Dart SDK version requirement ^3.11.3

---

## [Unreleased]

### Planned Features
- [ ] ListUtils - List operation utilities
- [ ] NumUtils - Number processing utilities
- [ ] ColorUtils - Color conversion utilities
- [ ] CacheUtils - Cache management utilities
- [ ] SharedPreferences utility wrapper
- [ ] Network request utility wrapper
- [ ] More Widget extension methods
- [ ] Internationalization support (i18n)

---

## Version Guide

### Version Number Rules
- **Major (X.0.0)**: Incompatible API changes
- **Minor (0.X.0)**: Backward-compatible new features
- **Patch (0.0.X):** Backward-compatible bug fixes

### Update Type Labels
- **Added**: New features
- **Changed**: Changes to existing features
- **Deprecated**: Features to be removed soon
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security fixes

---

## Release History

| Version | Date | Description |
|---------|------|-------------|
| 0.1.3 | 2026-05-26 | Added ListUtils, NumUtils, ColorUtils utilities |
| 0.1.2 | 2026-05-25 | Added PlatformUtils platform detection utilities |
| 0.1.1 | 2026-05-23 | Project structure optimization, documentation improvements, package publishing configuration optimization |
| 0.1.0 | 2026-05-23 | Initial release with basic utility collection |
