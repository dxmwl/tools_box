import 'package:flutter_test/flutter_test.dart';
import 'package:tools_box/tools_box.dart';

void main() {
  group('StringUtils 测试', () {
    test('邮箱验证', () {
      expect('test@example.com'.isEmail, true);
      expect('invalid-email'.isEmail, false);
      expect(''.isEmail, false);
    });

    test('手机号验证', () {
      expect('13812345678'.isPhoneNumber, true);
      expect('12345678901'.isPhoneNumber, false);
      expect('1381234567'.isPhoneNumber, false);
    });

    test('首字母大写', () {
      expect('hello'.capitalize, equals('Hello'));
      expect('Hello'.capitalize, equals('Hello'));
      expect(''.capitalize, equals(''));
    });

    test('字符串截断', () {
      expect('Hello World'.truncate(5), equals('Hello...'));
      expect('Hi'.truncate(5), equals('Hi'));
    });

    test('URL验证', () {
      expect('https://example.com'.isURL, true);
      expect('http://test.org'.isURL, true);
      expect('not-a-url'.isURL, false);
    });
  });

  group('DateUtils 测试', () {
    test('日期格式化', () {
      final date = DateTime(2024, 1, 15);
      expect(DateUtils.formatDate(date), equals('2024-01-15'));
    });

    test('是否是今天', () {
      expect(DateUtils.isToday(DateTime.now()), true);
      expect(
        DateUtils.isToday(DateTime.now().subtract(Duration(days: 1))),
        false,
      );
    });

    test('时间范围生成', () {
      final start = DateTime(2024, 1, 1);
      final end = DateTime(2024, 1, 3);
      final days = DateUtils.daysInRange(start, end);
      expect(days.length, equals(3));
    });
  });

  group('ValidationUtils 测试', () {
    test('邮箱验证', () {
      expect(ValidationUtils.isValidEmail('test@example.com'), true);
      expect(ValidationUtils.isValidEmail('invalid'), false);
    });

    test('手机号验证', () {
      expect(ValidationUtils.isValidPhone('13812345678'), true);
      expect(ValidationUtils.isValidPhone('12345'), false);
    });

    test('表单验证消息', () {
      expect(ValidationUtils.validateEmail(null), isNotNull);
      expect(ValidationUtils.validateEmail('test@example.com'), isNull);
      expect(ValidationUtils.validateRequired('', fieldName: '用户名'), isNotNull);
      expect(ValidationUtils.validateRequired('valid'), isNull);
    });
  });

  group('PlatformUtils 测试', () {
    test('平台名称不为空', () {
      expect(PlatformUtils.platformName.isNotEmpty, true);
      expect(PlatformUtils.platformNameCN.isNotEmpty, true);
    });

    test('平台名称一致性', () {
      final name = PlatformUtils.platformName;
      final nameCN = PlatformUtils.platformNameCN;
      print('当前平台: $name ($nameCN)');
      expect(name, isNotNull);
      expect(nameCN, isNotNull);
    });

    test('操作系统名称', () {
      final os = PlatformUtils.operatingSystem;
      print('操作系统: $os');
      expect(os, isNotNull);
      expect(os.isNotEmpty, true);
    });

    test('平台分类互斥性', () {
      if (PlatformUtils.isWeb) {
        expect(PlatformUtils.isAndroid, false);
        expect(PlatformUtils.isIOS, false);
        expect(PlatformUtils.isMacOS, false);
        expect(PlatformUtils.isWindows, false);
        expect(PlatformUtils.isLinux, false);
      }

      if (PlatformUtils.isMobile) {
        expect(PlatformUtils.isDesktop, false);
        expect(PlatformUtils.isWeb, false);
      }

      if (PlatformUtils.isDesktop) {
        expect(PlatformUtils.isMobile, false);
        expect(PlatformUtils.isWeb, false);
      }
    });

    test('runOnPlatform 回调执行', () {
      var callbackExecuted = false;

      PlatformUtils.runOnPlatform(
        onWeb: () => callbackExecuted = true,
        onOther: () => callbackExecuted = true,
      );

      expect(callbackExecuted, true);
    });

    test('支持功能检测', () {
      if (PlatformUtils.isWeb) {
        expect(PlatformUtils.supportsFileSystem(), false);
        expect(PlatformUtils.pathSeparator, isNull);
      } else {
        expect(PlatformUtils.supportsFileSystem(), true);
        expect(PlatformUtils.pathSeparator, isNotNull);
      }
    });
  });
}
