// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

/// Utility class for form field validation and data format checking.
///
/// Provides static methods for:
/// - Email, phone, password validation
/// - URL and ID card validation
/// - Character type detection (Chinese, numbers, letters)
/// - Form field validation with error message generation
///
/// This class contains both simple boolean validators (isValid*) and
/// form validators that return error messages or null (validate*).
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   // Simple validation
///   if (ValidationUtils.isValidEmail('user@example.com')) {
///     print('Valid email');
///   }
///
///   // Form validation with error messages
///   final error = ValidationUtils.validateEmail(emailController.text);
///   if (error != null) {
///     showError(error);
///   }
/// }
/// ```
class ValidationUtils {
  /// Validates if [email] has a valid email format.
  ///
  /// Uses a regular expression to check for standard email pattern:
  /// - Contains @ symbol
  /// - Has a domain part with at least one dot
  ///
  /// Returns `true` if the email format is valid, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.isValidEmail('user@example.com'); // true
  /// ValidationUtils.isValidEmail('invalid'); // false
  /// ```
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validates if [phone] is a valid Chinese mobile phone number.
  ///
  /// Chinese phone numbers follow the pattern:
  /// - Starts with 1
  /// - Second digit is 3-9
  /// - Followed by 9 digits
  ///
  /// Returns `true` if the phone number is valid, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.isValidPhone('13812345678'); // true
  /// ValidationUtils.isValidPhone('12345678901'); // false
  /// ```
  static bool isValidPhone(String phone) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(phone);
  }

  /// Validates if [password] meets minimum length requirement.
  ///
  /// Parameters:
  /// - [password]: The password string to validate
  /// - [minLength]: Minimum required length (default: 6)
  ///
  /// Returns `true` if password length >= minLength, `false` otherwise.
  ///
  /// Note: This only checks length. For stronger validation, consider
  /// checking for uppercase, lowercase, numbers, and special characters.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.isValidPassword('abc123'); // true (length 6)
  /// ValidationUtils.isValidPassword('abc', minLength: 8); // false
  /// ```
  static bool isValidPassword(String password, {int minLength = 6}) {
    return password.length >= minLength;
  }

  /// Validates if [url] has a valid HTTP/HTTPS URL format.
  ///
  /// Checks for standard URL patterns including:
  /// - Protocol (http:// or https://)
  /// - Domain name with valid characters
  /// - Optional path, query parameters, and fragments
  ///
  /// Returns `true` if the URL format is valid, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.isValidURL('https://example.com'); // true
  /// ValidationUtils.isValidURL('ftp://files.example.com'); // false (not HTTP)
  /// ```
  static bool isValidURL(String url) {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(url);
  }

  /// Validates if [idCard] is a valid Chinese ID card number.
  ///
  /// Chinese ID cards follow the format:
  /// - 6-digit area code
  /// - 8-digit birth date (YYYYMMDD)
  /// - 3-digit sequence code
  /// - 1 check digit (0-9 or X/x)
  ///
  /// Note: This only validates format, not checksum.
  ///
  /// Returns `true` if the ID card format is valid, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.isValidIDCard('11010519900307293X'); // true
  /// ValidationUtils.isValidIDCard('12345'); // false
  /// ```
  static bool isValidIDCard(String idCard) {
    return RegExp(
      r'^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$',
    ).hasMatch(idCard);
  }

  /// Checks if [text] contains any Chinese characters.
  ///
  /// Detects Unicode range for common Chinese characters (U+4E00 to U+9FA5).
  ///
  /// Returns `true` if Chinese characters are found, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.isChinese('Hello World'); // false
  /// ValidationUtils.isChinese('你好世界'); // true
  /// ValidationUtils.isChinese('Hello 你好'); // true
  /// ```
  static bool isChinese(String text) {
    return RegExp(r'[\u4e00-\u9fa5]').hasMatch(text);
  }

  /// Checks if [text] contains only numeric digits (0-9).
  ///
  /// The entire string must consist of digits with no other characters.
  ///
  /// Returns `true` if the string contains only digits, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.containsOnlyNumbers('12345'); // true
  /// ValidationUtils.containsOnlyNumbers('123a45'); // false
  /// ValidationUtils.containsOnlyNumbers('12.34'); // false (contains dot)
  /// ```
  static bool containsOnlyNumbers(String text) {
    return RegExp(r'^\d+$').hasMatch(text);
  }

  /// Checks if [text] contains only ASCII letters (a-z, A-Z).
  ///
  /// The entire string must consist of letters with no spaces or other characters.
  ///
  /// Returns `true` if the string contains only letters, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.containsOnlyLetters('HelloWorld'); // true
  /// ValidationUtils.containsOnlyLetters('Hello World'); // false (contains space)
  /// ValidationUtils.containsOnlyLetters('Hello123'); // false (contains numbers)
  /// ```
  static bool containsOnlyLetters(String text) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(text);
  }

  /// Checks if [text] contains only alphanumeric characters (letters and numbers).
  ///
  /// The string can contain both uppercase/lowercase letters and digits,
  /// but no spaces, punctuation, or special characters.
  ///
  /// Returns `true` if the string is alphanumeric, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// ValidationUtils.containsOnlyLettersAndNumbers('Hello123'); // true
  /// ValidationUtils.containsOnlyLettersAndNumbers('Hello_123'); // false (underscore)
  /// ValidationUtils.containsOnlyLettersAndNumbers('Hello 123'); // false (space)
  /// ```
  static bool containsOnlyLettersAndNumbers(String text) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text);
  }

  /// Validates an email field for forms, returning an error message if invalid.
  ///
  /// A higher-level validation method that returns user-friendly error messages
  /// suitable for displaying in form UIs.
  ///
  /// Parameters:
  /// - [value]: The email value to validate (can be null or empty)
  ///
  /// Returns:
  /// - An error message string if validation fails
  /// - `null` if the email is valid (indicating success)
  ///
  /// Error conditions:
  /// - Null or empty value: "Email cannot be empty"
  /// - Invalid format: "Please enter a valid email address"
  ///
  /// Example:
  /// ```dart
  /// final error = ValidationUtils.validateEmail(emailController.text);
  /// if (error != null) {
  ///   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  /// }
  /// ```
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates a phone number field for forms, returning an error message if invalid.
  ///
  /// Parameters:
  /// - [value]: The phone number to validate (can be null or empty)
  ///
  /// Returns:
  /// - An error message string if validation fails
  /// - `null` if the phone number is valid
  ///
  /// Error conditions:
  /// - Null or empty value: "Phone number cannot be empty"
  /// - Invalid format: "Please enter a valid phone number"
  ///
  /// Example:
  /// ```dart
  /// final error = ValidationUtils.validatePhone(phoneController.text);
  /// ```
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (!isValidPhone(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Validates a password field for forms, returning an error message if invalid.
  ///
  /// Parameters:
  /// - [value]: The password to validate (can be null or empty)
  /// - [minLength]: Minimum required length (default: 6)
  ///
  /// Returns:
  /// - An error message string if validation fails
  /// - `null` if the password meets requirements
  ///
  /// Error conditions:
  /// - Null or empty value: "Password cannot be empty"
  /// - Too short: "Password must be at least $minLength characters long"
  ///
  /// Example:
  /// ```dart
  /// final error = ValidationUtils.validatePassword(passwordController.text, minLength: 8);
  /// ```
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (!isValidPassword(value, minLength: minLength)) {
      return 'Password must be at least $minLength characters long';
    }
    return null;
  }

  /// Validates a required field that must not be empty.
  ///
  /// A generic validator for any required text field.
  ///
  /// Parameters:
  /// - [value]: The field value to validate (can be null or empty)
  /// - [fieldName]: Custom field name for error message (default: "This field")
  ///
  /// Returns:
  /// - Error message "$fieldName cannot be empty" if value is null/empty/whitespace-only
  /// - `null` if the field has content
  ///
  /// Example:
  /// ```dart
  /// final error = ValidationUtils.validateRequired(usernameController.text, fieldName: 'Username');
  /// // Error: "Username cannot be empty"
  ///
  /// final error2 = ValidationUtils.validateRequired(nameController.text);
  /// // Error: "This field cannot be empty" (uses default name)
  /// ```
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }
}
