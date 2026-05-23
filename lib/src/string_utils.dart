// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

extension StringUtils on String {
  bool get isEmail => contains('@') && contains('.');

  bool get isPhoneNumber => RegExp(r'^1[3-9]\d{9}$').hasMatch(this);

  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get capitalizeAllOf =>
      split(' ').map((word) => word.capitalize).join(' ');

  bool get isNumeric => double.tryParse(this) != null;

  String get reverse => split('').reversed.join('');

  String? get nullIfEmpty => isEmpty ? null : this;

  String truncate(int length, {String suffix = '...'}) {
    if (this.length <= length) return this;
    return '${substring(0, length)}$suffix';
  }

  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  bool get isURL => RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  ).hasMatch(this);
}
