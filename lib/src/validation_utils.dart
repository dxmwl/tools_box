// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

class ValidationUtils {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    return RegExp(r'^1[3-9]\d{9}$').hasMatch(phone);
  }

  static bool isValidPassword(String password, {int minLength = 6}) {
    return password.length >= minLength;
  }

  static bool isValidURL(String url) {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(url);
  }

  static bool isValidIDCard(String idCard) {
    return RegExp(
      r'^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$',
    ).hasMatch(idCard);
  }

  static bool isChinese(String text) {
    return RegExp(r'[\u4e00-\u9fa5]').hasMatch(text);
  }

  static bool containsOnlyNumbers(String text) {
    return RegExp(r'^\d+$').hasMatch(text);
  }

  static bool containsOnlyLetters(String text) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(text);
  }

  static bool containsOnlyLettersAndNumbers(String text) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(text);
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '邮箱不能为空';
    }
    if (!isValidEmail(value)) {
      return '请输入有效的邮箱地址';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return '手机号不能为空';
    }
    if (!isValidPhone(value)) {
      return '请输入有效的手机号码';
    }
    return null;
  }

  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return '密码不能为空';
    }
    if (!isValidPassword(value, minLength: minLength)) {
      return '密码长度至少需要$minLength位';
    }
    return null;
  }

  static String? validateRequired(String? value, {String fieldName = '此字段'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName不能为空';
    }
    return null;
  }
}
