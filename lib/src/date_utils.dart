// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';

/// Utility class for date and time formatting and manipulation.
///
/// Provides static methods for:
/// - Date formatting with custom patterns
/// - Relative time display (time ago)
/// - Date comparison (is today, yesterday, etc.)
/// - Date range generation
///
/// This class uses the `intl` package for date formatting support.
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   final now = DateTime.now();
///   print(DateUtils.formatDate(now)); // 2024-01-15
///   print(DateUtils.timeAgo(now.subtract(Duration(hours: 2)))); // 2 hours ago
/// }
/// ```
class DateUtils {
  /// Formats a [DateTime] using the specified [pattern].
  ///
  /// The default pattern is 'yyyy-MM-dd' which produces output like '2024-01-15'.
  /// Uses [DateFormat] from the intl package for formatting.
  ///
  /// Parameters:
  /// - [date]: The DateTime to format
  /// - [pattern]: The format pattern (default: 'yyyy-MM-dd')
  ///
  /// Returns a formatted date string.
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2024, 1, 15);
  /// DateUtils.formatDate(date); // '2024-01-15'
  /// DateUtils.formatDate(date, pattern: 'MM/dd/yyyy'); // '01/15/2024'
  /// ```
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  /// Formats a [DateTime] including time components.
  ///
  /// The default pattern is 'yyyy-MM-dd HH:mm:ss' which produces output like
  /// '2024-01-15 14:30:00'.
  ///
  /// Parameters:
  /// - [date]: The DateTime to format
  /// - [pattern]: The format pattern (default: 'yyyy-MM-dd HH:mm:ss')
  ///
  /// Returns a formatted datetime string.
  ///
  /// Example:
  /// ```dart
  /// final dateTime = DateTime(2024, 1, 15, 14, 30, 0);
  /// DateUtils.formatDateTime(dateTime); // '2024-01-15 14:30:00'
  /// ```
  static String formatDateTime(
    DateTime date, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
  }) {
    return DateFormat(pattern).format(date);
  }

  /// Returns a human-readable relative time string (Chinese locale).
  ///
  /// Calculates the difference between [date] and now, then returns
  /// a string like "5 minutes ago", "2 hours ago", "3 days ago", etc.
  ///
  /// Note: Currently returns Chinese text. Consider adding i18n support in future versions.
  ///
  /// Parameters:
  /// - [date]: The DateTime to compare against current time
  ///
  /// Returns a localized relative time string.
  ///
  /// Example:
  /// ```dart
  /// final now = DateTime.now();
  /// DateUtils.timeAgo(now); // 'just now'
  /// DateUtils.timeAgo(now.subtract(Duration(minutes: 5))); // '5 minutes ago'
  /// DateUtils.timeAgo(now.subtract(Duration(hours: 2))); // '2 hours ago'
  /// ```
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  /// Checks if [date] represents today's date.
  ///
  /// Compares year, month, and day components with the current date,
  /// ignoring time components.
  ///
  /// Returns `true` if [date] is today, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// DateUtils.isToday(DateTime.now()); // true
  /// DateUtils.isToday(DateTime.now().subtract(Duration(days: 1))); // false
  /// ```
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Checks if [date] represents yesterday's date.
  ///
  /// Compares year, month, and day components with yesterday's date,
  /// ignoring time components.
  ///
  /// Returns `true` if [date] was yesterday, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// DateUtils.isYesterday(DateTime.now().subtract(Duration(days: 1))); // true
  /// DateUtils.isYesterday(DateTime.now()); // false
  /// ```
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Returns the beginning of the day for the given [date].
  ///
  /// Creates a new DateTime set to midnight (00:00:00) of the given date.
  ///
  /// Returns a new DateTime representing start of day (00:00:00).
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2024, 1, 15, 14, 30, 0);
  /// DateUtils.startOfDay(date); // 2024-01-15 00:00:00.000
  /// ```
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Returns the end of the day for the given [date].
  ///
  /// Creates a new DateTime set to one second before midnight (23:59:59)
  /// of the given date.
  ///
  /// Returns a new DateTime representing end of day (23:59:59).
  ///
  /// Example:
  /// ```dart
  /// final date = DateTime(2024, 1, 15, 14, 30, 0);
  /// DateUtils.endOfDay(date); // 2024-01-15 23:59:59
  /// ```
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Generates a list of [DateTime] objects from [start] to [end] inclusive.
  ///
  /// Creates a sequence of dates, one per day, covering the specified range.
  /// Both [start] and [end] dates are included in the result.
  ///
  /// Parameters:
  /// - [start]: The starting date (inclusive)
  /// - [end]: The ending date (inclusive)
  ///
  /// Returns a list of DateTime objects representing each day in the range.
  ///
  /// Example:
  /// ```dart
  /// final start = DateTime(2024, 1, 10);
  /// final end = DateTime(2024, 1, 13);
  /// DateUtils.daysInRange(start, end);
  /// // [2024-01-10, 2024-01-11, 2024-01-12, 2024-01-13]
  /// ```
  static List<DateTime> daysInRange(DateTime start, DateTime end) {
    final days = <DateTime>[];
    var current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      days.add(current);
      current = current.add(Duration(days: 1));
    }
    return days;
  }
}
