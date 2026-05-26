// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

/// Extension methods on [String] for common string operations and validations.
///
/// This extension provides convenient methods for:
/// - Email and phone number validation
/// - String case manipulation
/// - Numeric checks
/// - String transformation (reverse, truncate, etc.)
/// - URL validation
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   final email = 'test@example.com';
///   if (email.isEmail) {
///     print('Valid email');
///   }
///
///   final text = 'hello world';
///   print(text.capitalize); // 'Hello world'
/// }
/// ```
extension StringUtils on String {
  /// Checks if the string is a valid email format.
  ///
  /// A simple validation that checks for the presence of '@' and '.' characters.
  /// For more robust email validation, consider using [ValidationUtils.isValidEmail].
  ///
  /// Returns `true` if the string contains '@' and '.', `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 'user@example.com'.isEmail; // true
  /// 'invalid-email'.isEmail; // false
  /// ```
  bool get isEmail => contains('@') && contains('.');

  /// Checks if the string is a valid Chinese phone number.
  ///
  /// Validates against the pattern for Chinese mobile numbers starting with 1
  /// followed by 3-9 and 9 additional digits.
  ///
  /// Returns `true` if the string matches Chinese phone number format, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// '13812345678'.isPhoneNumber; // true
  /// '12345678901'.isPhoneNumber; // false
  /// ```
  bool get isPhoneNumber => RegExp(r'^1[3-9]\d{9}$').hasMatch(this);

  /// Capitalizes the first character of the string.
  ///
  /// Returns the original string if it's empty, otherwise returns a new string
  /// with the first character converted to uppercase.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.capitalize; // 'Hello'
  /// ''.capitalize; // ''
  /// 'Hello'.capitalize; // 'Hello'
  /// ```
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Capitalizes the first character of each word in the string.
  ///
  /// Splits the string by spaces and capitalizes each word individually,
  /// then joins them back together.
  ///
  /// Example:
  /// ```dart
  /// 'hello world'.capitalizeAllOf; // 'Hello World'
  /// 'flutter is awesome'.capitalizeAllOf; // 'Flutter Is Awesome'
  /// ```
  String get capitalizeAllOf =>
      split(' ').map((word) => word.capitalize).join(' ');

  /// Checks if the string represents a numeric value.
  ///
  /// Attempts to parse the string as a double. Returns `true` if parsing succeeds,
  /// `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// '123'.isNumeric; // true
  /// '12.34'.isNumeric; // true
  /// 'abc'.isNumeric; // false
  /// ```
  bool get isNumeric => double.tryParse(this) != null;

  /// Reverses the characters in the string.
  ///
  /// Returns a new string with all characters in reverse order.
  ///
  /// Example:
  /// ```dart
  /// 'hello'.reverse; // 'olleh'
  /// 'Flutter'.reverse; // 'rettulF'
  /// ```
  String get reverse => split('').reversed.join('');

  /// Returns `null` if the string is empty, otherwise returns the string itself.
  ///
  /// Useful for converting empty strings to null for optional field handling.
  ///
  /// Example:
  /// ```dart
  /// ''.nullIfEmpty; // null
  /// 'hello'.nullIfEmpty; // 'hello'
  /// '  '.nullIfEmpty; // '  ' (whitespace is not empty)
  /// ```
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Truncates the string to the specified [length] with an optional [suffix].
  ///
  /// If the string length is less than or equal to [length], returns the original string.
  /// Otherwise, truncates and appends the [suffix] (default: '...').
  ///
  /// Parameters:
  /// - [length]: Maximum length of the resulting string (excluding suffix)
  /// - [suffix]: String to append when truncated (default: '...')
  ///
  /// Example:
  /// ```dart
  /// 'Hello World'.truncate(5); // 'Hello...'
  /// 'Hi'.truncate(5); // 'Hi'
  /// 'Very Long Text'.truncate(10, suffix: ' >>'); // 'Very Long T >>'
  /// ```
  String truncate(int length, {String suffix = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length)}$suffix';
  }

  /// Removes all whitespace characters from the string.
  ///
  /// Removes spaces, tabs, newlines, and other whitespace characters.
  ///
  /// Example:
  /// ```dart
  /// '  hello world  '.removeWhitespace; // 'helloworld'
  /// 'a b c'.removeWhitespace; // 'abc'
  /// ```
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Checks if the string is a valid URL format.
  ///
  /// Validates HTTP/HTTPS URLs following standard URL format patterns.
  ///
  /// Returns `true` if the string matches URL format, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 'https://example.com'.isURL; // true
  /// 'http://www.test.com/page'.isURL; // true
  /// 'not-a-url'.isURL; // false
  /// ```
  bool get isURL => RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  ).hasMatch(this);
}
