// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatDateTime(
    DateTime date, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
  }) {
    return DateFormat(pattern).format(date);
  }

  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

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
