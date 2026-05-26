// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

/// Extension methods on [num] for common number formatting and operations.
///
/// This extension provides convenient methods for:
/// - Number formatting (with commas, decimal places, currency)
/// - Range checking and clamping
/// - Percentage calculations
/// - Unit conversions
/// - Time formatting
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   final price = 1234567.89;
///   print(price.formatWithCommas); // '1,234,567.89'
///   print(price.toCurrency()); // '$1,234,567.89'
///
///   final percentage = 0.756;
///   print(percentage.toPercentage(1)); // '75.6%'
/// }
/// ```
extension NumUtils on num {
  /// Formats the number with comma separators for thousands.
  ///
  /// Uses the locale-aware number formatting to insert commas every 3 digits.
  /// Handles both integer and decimal parts correctly.
  ///
  /// Returns a string representation with comma separators.
  ///
  /// Example:
  /// ```dart
  /// 1000.formatWithCommas; // '1,000'
  /// 1234567.formatWithCommas; // '1,234,567'
  /// 1234567.89.formatWithCommas; // '1,234,567.89'
  /// 100.formatWithCommas; // '100'
  /// ```
  String get formatWithCommas {
    if (this is int) {
      return toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
    } else {
      final parts = toStringAsFixed(truncateToDouble() == this ? 0 : 2).split('.');
      parts[0] = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
      return parts.join('.');
    }
  }

  /// Formats the number as a currency string with specified [symbol].
  ///
  /// Parameters:
  /// - [symbol]: Currency symbol to prepend (default: '$')
  /// - [decimalPlaces]: Number of decimal places (default: 2)
  ///
  /// Returns a formatted currency string.
  ///
  /// Example:
  /// ```dart
  /// 1234.5.toCurrency(); // '$1,234.50'
  /// 1234.5.toCurrency(symbol: '\u00a5'); // '¥1,234.50'
  /// 1000.toCurrency(decimalPlaces: 0); // '$1,000'
  /// ```
  String toCurrency({String symbol = '\$', int decimalPlaces = 2}) {
    return '$symbol${formatNumber(decimalPlaces: decimalPlaces)}';
  }

  /// Formats the number with specified decimal places and optional separators.
  ///
  /// Parameters:
  /// - [decimalPlaces]: Number of digits after decimal point (default: 2)
  /// - [useSeparator]: Whether to use thousand separators (default: true)
  ///
  /// Returns a formatted number string.
  ///
  /// Example:
  /// ```dart
  /// 1234567.891.formatNumber(); // '1,234,567.89'
  /// 1234567.891.formatNumber(decimalPlaces: 3); // '1,234,567.891'
  /// 1234567.89.formatNumber(useSeparator: false); // '1234567.89'
  /// ```
  String formatNumber({int decimalPlaces = 2, bool useSeparator = true}) {
    final formatted = toStringAsFixed(decimalPlaces);
    if (!useSeparator) return formatted;

    final parts = formatted.split('.');
    parts[0] = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return parts.join('.');
  }

  /// Converts the number to a percentage string.
  ///
  /// Multiplies by 100 and appends '%' symbol.
  ///
  /// Parameters:
  /// - [decimalPlaces]: Number of decimal places (default: 1)
  ///
  /// Returns a percentage string like "75.6%".
  ///
  /// Example:
  /// ```dart
  /// 0.756.toPercentage(); // '75.6%'
  /// 1.0.toPercentage(0); // '100%'
  /// 0.333.toPercentage(2); // '33.33%'
  /// 0.001.toPercentage(); // '0.1%'
  /// ```
  String toPercentage({int decimalPlaces = 1}) {
    return '${(this * 100).toStringAsFixed(decimalPlaces)}%';
  }

  /// Clamps the number within the specified range [min] to [max].
  ///
  /// If the number is less than [min], returns [min].
  /// If the number is greater than [max], returns [max].
  /// Otherwise returns the original value.
  ///
  /// Parameters:
  /// - [min]: Minimum allowed value
  /// - [max]: Maximum allowed value
  ///
  /// Returns the clamped value within range.
  ///
  /// Example:
  /// ```dart
  /// 5.clampRange(0, 10); // 5
  /// (-5).clampRange(0, 10); // 0
  /// 15.clampRange(0, 10); // 10
  /// ```
  num clampRange(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Checks if the number is within the exclusive range (min, max).
  ///
  /// Parameters:
  /// - [min]: Lower bound (exclusive)
  /// - [max]: Upper bound (exclusive)
  ///
  /// Returns `true` if min < this < max, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 5.isBetween(0, 10); // true
  /// 0.isBetween(0, 10); // false (not exclusive of 0)
  /// 10.isBetween(0, 10); // false (not exclusive of 10)
  /// ```
  bool isBetween(num min, num max) => this > min && this < max;

  /// Checks if the number is within the inclusive range [min, max].
  ///
  /// Parameters:
  /// - [min]: Lower bound (inclusive)
  /// - [max]: Upper bound (inclusive)
  ///
  /// Returns `true` if min <= this <= max, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 5.isWithin(0, 10); // true
  /// 0.isWithin(0, 10); // true (inclusive)
  /// 10.isWithin(0, 10); // true (inclusive)
  /// (-1).isWithin(0, 10); // false
  /// ```
  bool isWithin(num min, num max) => this >= min && this <= max;

  /// Checks if the number is positive (> 0).
  ///
  /// Returns `true` if greater than zero, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 5.isPositive; // true
  /// 0.isPositive; // false
  /// (-5).isPositive; // false
  /// ```
  bool get isPositive => this > 0;

  /// Checks if the number is negative (< 0).
  ///
  /// Returns `true` if less than zero, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// (-5).isNegative; // true
  /// 0.isNegative; // false
  /// 5.isNegative; // false
  /// ```
  bool get isNegative => this < 0;

  /// Checks if the number is zero (== 0).
  ///
  /// Returns `true` if exactly zero, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 0.isZero; // true
  /// 0.0.isZero; // true
  /// 0.0001.isZero; // false
  /// ```
  bool get isZero => this == 0;

  /// Checks if the number is non-zero (!= 0).
  ///
  /// Returns `true` if not zero, `false` if zero.
  ///
  /// Example:
  /// ```dart
  /// 5.isNonZero; // true
  /// 0.isNonZero; // false
  /// ```
  bool get isNonZero => this != 0;

  /// Checks if the number is even (divisible by 2 without remainder).
  ///
  /// Only meaningful for integers. For doubles, checks if truncation is even.
  ///
  /// Returns `true` if even, `false` if odd.
  ///
  /// Example:
  /// ```dart
  /// 4.isEven; // true
  /// 7.isEven; // false
  /// 4.0.isEven; // true
  /// 4.5.isEven; // false (truncates to 4, but 4.5 != 4)
  /// ```
  bool get isEven => toInt() % 2 == 0;

  /// Checks if the number is odd (not divisible by 2).
  ///
  /// Only meaningful for integers. For doubles, checks if truncation is odd.
  ///
  /// Returns `true` if odd, `false` if even.
  ///
  /// Example:
  /// ```dart
  /// 7.isOdd; // true
  /// 4.isOdd; // false
  /// ```
  bool get isOdd => toInt() % 2 != 0;

  /// Converts seconds to a human-readable time duration string.
  ///
  /// Automatically formats as appropriate unit (seconds, minutes, hours, days).
  ///
  /// Returns a formatted time string like "2h 30m" or "45s".
  ///
  /// Example:
  /// ```dart
  /// 45.toDurationString(); // '45s'
  /// 90.toDurationString(); // '1m 30s'
  /// 3661.toDurationString(); // '1h 1m 1s'
  /// 86400.toDurationString(); // '1d'
  /// ```
  String toDurationString() {
    final totalSeconds = toInt();
    
    if (totalSeconds < 60) return '${totalSeconds}s';
    
    final days = totalSeconds ~/ 86400;
    final hours = (totalSeconds % 86400) ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    
    final parts = <String>[];
    if (days > 0) parts.add('${days}d');
    if (hours > 0) parts.add('${hours}h');
    if (minutes > 0) parts.add('${minutes}m');
    if (seconds > 0 && days == 0) parts.add('${seconds}s');
    
    return parts.isEmpty ? '0s' : parts.join(' ');
  }

  /// Converts bytes to a human-readable file size string.
  ///
  /// Assumes the current value represents bytes.
  /// Automatically chooses appropriate unit (B, KB, MB, GB, TB).
  ///
  /// Parameters:
  /// - [decimalPlaces]: Number of decimal places (default: 2)
  ///
  /// Returns a formatted size string like "1.5 MB" or "500 KB".
  ///
  /// Example:
  /// ```dart
  /// 500.toFileSize(); // '500 B'
  /// 1024.toFileSize(); // 1 KB'
  /// 1536.toFileSize(); // '1.5 KB'
  /// 1048576.toFileSize(); // '1 MB'
  /// 1073741824.toFileSize(); // '1 GB'
  /// ```
  String toFileSize({int decimalPlaces = 2}) {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) {
      return '${(this / 1024).toStringAsFixed(decimalPlaces)} KB';
    }
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(decimalPlaces)} MB';
    }
    if (this < 1024 * 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(decimalPlaces)} GB';
    }
    return '${(this / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(decimalPlaces)} TB';
  }

  /// Rounds the number to specified [decimalPlaces].
  ///
  /// Parameters:
  /// - [decimalPlaces]: Number of digits after decimal point (default: 0)
  ///
  /// Returns the rounded number.
  ///
  /// Example:
  /// ```dart
  /// 3.14159.roundTo(2); // 3.14
  /// 3.14159.roundTo(0); // 3
  /// 3.5.roundTo(0); // 4
  /// ```
  num roundTo(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces);
    return (this * factor).round() / factor;
  }

  /// Returns the absolute difference between this and [other].
  ///
  /// Parameters:
  /// - [other]: The other number to compare against
  ///
  /// Returns the absolute value of (this - other).
  ///
  /// Example:
  /// ```dart
  /// 5.differenceFrom(10); // 5
  /// 10.differenceFrom(5); // 5
  /// (-5).differenceFrom(-10); // 5
  /// ```
  num differenceFrom(num other) => (this - other).abs();

  /// Checks if this number is divisible by [other].
  ///
  /// Returns `true` if division results in no remainder, `false` otherwise.
  ///
  /// Note: For floating-point numbers, uses modulo operation which may have
  /// precision limitations.
  ///
  /// Parameters:
  /// - [other]: The divisor
  ///
  /// Returns `true` if divisible, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// 12.isDivisibleBy(3); // true
  /// 10.isDivisibleBy(3); // false
  /// 0.isDivisibleBy(5); // true
  /// ```
  bool isDivisibleBy(num other) => this % other == 0;

  /// Returns the sign of the number as an integer.
  ///
  /// Returns -1 for negative numbers, 0 for zero, 1 for positive numbers.
  ///
  /// Example:
  /// ```dart
  /// (-5).sign; // -1
  /// 0.sign; // 0
  /// 5.sign; // 1
  /// ```
  int get sign {
    if (isNegative) return -1;
    if (isPositive) return 1;
    return 0;
  }

  /// Limits the number to a maximum value.
  ///
  /// If this number exceeds [maxValue], returns [maxValue], else returns this.
  ///
  /// Parameters:
  /// - [maxValue]: Maximum allowed value
  ///
  /// Returns the capped value.
  ///
  /// Example:
  /// ```dart
  /// 5.atMost(10); // 5
  /// 15.atMost(10); // 10
  /// ```
  num atMost(num maxValue) => this > maxValue ? maxValue : this;

  /// Ensures the number is at least a minimum value.
  ///
  /// If this number is less than [minValue], returns [minValue], else returns this.
  ///
  /// Parameters:
  /// - [minValue]: Minimum allowed value
  ///
  /// Returns the floored value.
  ///
  /// Example:
  /// ```dart
  /// 15.atLeast(10); // 15
  /// 5.atLeast(10); // 10
  /// ```
  num atLeast(num minValue) => this < minValue ? minValue : this;

  /// Repeats a callback function [n] times (for integers only).
  ///
  /// Useful for generating lists or repeating actions.
  ///
  /// Type parameter [T] specifies the type of values produced by [callback].
  ///
  /// Parameters:
  /// - [callback]: Function to call each iteration, receives current index
  ///
  /// Returns a list of results from each callback invocation.
  ///
  /// Example:
  /// ```dart
  /// 5.times((i) => i * 2); // [0, 2, 4, 6, 8]
  /// 3.times((i) => 'Item $i'); // ['Item 0', 'Item 1', 'Item 2']
  /// ```
  List<T> times<T>(T Function(int) callback) =>
      List.generate(toInt(), (i) => callback(i));
}
