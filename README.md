# flutter_utils

[![Pub Version](https://img.shields.io/pub/v/flutter_utils)](https://pub.dev/packages/flutter_utils)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Dart SDK](https://img.shields.io/badge/sdk-%5E3.11.3-blue.svg)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D1.17.0-blue.svg)](https://flutter.dev)

Flutter 常用工具集合，提供字符串处理、日期格式化、Widget 扩展、表单验证等功能，帮助开发者提升开发效率。

## ✨ Features

- 🎯 **StringUtils** - 字符串扩展方法（邮箱/手机号验证、格式化、截断等）
- 📅 **DateUtils** - 日期时间工具类（格式化、相对时间、日期范围等）
- 🎨 **WidgetExtensions** - Widget 便捷扩展方法（padding、居中、圆角等）
- 📱 **BuildContextExtensions** - BuildContext 扩展（屏幕尺寸、SnackBar、导航等）
- ✅ **ValidationUtils** - 表单验证工具类（邮箱、手机号、密码验证等）

## 🚀 Getting started

### 添加依赖

在 `pubspec.yaml` 文件中添加：

```yaml
dependencies:
  flutter_utils: ^0.1.0
```

### 导入包

```dart
import 'package:flutter_utils/flutter_utils.dart';
```

## 📖 Usage

### 1️⃣ 字符串工具 (StringUtils)

```dart
import 'package:flutter_utils/flutter_utils.dart';

// 邮箱验证
'test@example.com'.isEmail; // true

// 手机号验证（中国手机号）
'13812345678'.isPhoneNumber; // true

// 首字母大写
'hello'.capitalize; // 'Hello'

// 每个单词首字母大写
'hello world'.capitalizeAllOf; // 'Hello World'

// 判断是否为数字
'12345'.isNumeric; // true

// 字符串反转
'flutter'.reverse; // 'rettulf'

// 字符串截断
'这是一个很长的字符串'.truncate(10); // '这是一个很长的字...'

// 移除空白字符
'  hello world  '.removeWhitespace; // 'helloworld'

// URL验证
'https://example.com'.isURL; // true

// 空字符串转null
''.nullIfEmpty; // null
'hello'.nullIfEmpty; // 'hello'
```

### 2️⃣ 日期时间工具 (DateUtils)

```dart
import 'package:flutter_utils/flutter_utils.dart';

final now = DateTime.now();

// 格式化日期
DateUtils.formatDate(now); // '2024-01-15'
DateUtils.formatDate(now, pattern: 'yyyy年MM月dd日'); // '2024年01月15日'

// 格式化日期时间
DateUtils.formatDateTime(now); // '2024-01-15 14:30:00'

// 相对时间（中文）
DateUtils.timeAgo(now.subtract(Duration(minutes: 5))); // '5分钟前'
DateUtils.timeAgo(now.subtract(Duration(hours: 2))); // '2小时前'
DateUtils.timeAgo(now.subtract(Duration(days: 1))); // '1天前'

// 判断是否是今天/昨天
DateUtils.isToday(now); // true
DateUtils.isYesterday(now.subtract(Duration(days: 1))); // true

// 获取一天的开始/结束时间
DateUtils.startOfDay(now); // DateTime(2024, 1, 15, 0, 0, 0)
DateUtils.endOfDay(now);   // DateTime(2024, 1, 15, 23, 59, 59)

// 生成日期范围列表
final start = DateTime(2024, 1, 1);
final end = DateTime(2024, 1, 5);
final days = DateUtils.daysInRange(start, end); // 返回5天的列表
```

### 3️⃣ Widget 扩展方法 (WidgetExtensions)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

// 快速添加 padding
Text('Hello').paddingAll(16);
Text('Hello').paddingSymmetric(horizontal: 20, vertical: 10);
Text('Hello').only(left: 16, right: 16);

// 居中对齐
Text('Centered').center();

// 对齐方式
Text('Aligned').align(alignment: Alignment.centerRight);

// Expanded 和 Flexible
Container().expand(flex: 1);
Container().flexible(flex: 2, fit: FlexFit.tight);

// 绝对定位
Text('Positioned').positioned(top: 10, left: 10);

// 添加点击事件
Icon(Icons.star).onTap(() => print('clicked!'));

// 设置尺寸
Text('Sized').sizedBox(width: 200, height: 100);

// 圆角裁剪
Image.network(url).clipRRect(radius: 12);

// 添加装饰
Text('Decorated')
    .decorated(decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(8),
    ));

// 透明度
Text('Transparent').opacity(0.5);

// 安全区域
Column(children: [Text('Safe')]).safeArea();

// Hero 动画
Image.asset(photo).hero('photo_hero');

// 提示信息
Icon(Icons.info).tooltip('这是一个提示');

// 控制显隐
Text('Visible').visible(true);
Text('Hidden').visible(false, replacement: SizedBox());
```

**链式调用示例：**

```dart
Text('链式调用示例')
    .paddingAll(16)
    .center()
    .onTap(() => print('tapped!'))
    .decorated(decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue),
    ));
```

### 4️⃣ BuildContext 扩展 (BuildContextExtensions)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取屏幕尺寸
    final width = context.screenWidth;
    final height = context.screenHeight;

    // 获取主题数据
    final theme = context.theme;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    // 判断暗色模式
    if (context.isDarkMode) {
      // 暗色主题逻辑
    }

    // 键盘状态
    if (context.isKeyboardVisible) {
      // 键盘已弹出
    }

    // 隐藏键盘
    context.hideKeyboard();

    // 显示 SnackBar
    context.showSnackBar('操作成功！');

    // 页面导航
    context.push((context) => DetailPage());
    context.pop();

    return Container();
  }
}
```

### 5️⃣ 表单验证工具 (ValidationUtils)

```dart
import 'package:flutter_utils/flutter_utils.dart';

// 基础验证
ValidationUtils.isValidEmail('test@example.com'); // true
ValidationUtils.isValidPhone('13812345678');       // true
ValidationUtils.isValidPassword('123456');          // true
ValidationUtils.isValidURL('https://example.com');  // true
ValidationUtils.isValidIDCard('110101199001011234'); // true

// 表单验证（返回错误消息或 null）
String? error;

error = ValidationUtils.validateEmail('invalid-email');
// 返回: '请输入有效的邮箱地址'

error = ValidationUtils.validateEmail('test@example.com');
// 返回: null (验证通过)

error = ValidationUtils.validatePhone('');
// 返回: '手机号不能为空'

error = ValidationUtils.validatePassword('123', minLength: 6);
// 返回: '密码长度至少需要6位'

error = ValidationUtils.validateRequired('', fieldName: '用户名');
// 返回: '用户名不能为空'

error = ValidationUtils.validateRequired('valid_username', fieldName: '用户名');
// 返回: null (验证通过)

// 其他验证方法
ValidationUtils.isChinese('你好');           // true
ValidationUtils.containsOnlyNumbers('12345'); // true
ValidationUtils.containsOnlyLetters('abc');  // true
ValidationUtils.containsOnlyLettersAndNumbers('abc123'); // true
```

**在 TextFormField 中使用：**

```dart
TextFormField(
  decoration: InputDecoration(labelText: '邮箱'),
  validator: (value) => ValidationUtils.validateEmail(value),
)

TextFormField(
  decoration: InputDecoration(labelText: '手机号'),
  validator: (value) => ValidationUtils.validatePhone(value),
)

TextFormField(
  decoration: InputDecoration(labelText: '密码'),
  obscureText: true,
  validator: (value) => ValidationUtils.validatePassword(value, minLength: 8),
)
```

## 🎯 示例应用

查看 `example_app` 目录获取完整的使用示例：

```bash
cd example_app
flutter run -d edge
```

示例应用展示了所有功能模块的实际使用效果。

## 🔧 开发指南

### 本地开发

如果你想参与开发或修改此包：

1. 克隆仓库：
```bash
git clone https://github.com/yourusername/flutter_utils.git
cd flutter_utils
```

2. 安装依赖：
```bash
flutter pub get
```

3. 运行测试：
```bash
flutter test
```

4. 启动示例应用：
```bash
cd example_app
flutter pub get
flutter run
```

### 运行测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/flutter_utils_test.dart

# 生成覆盖率报告
flutter test --coverage
```

### 代码规范

```bash
# 格式化代码
dart format .

# 静态分析
flutter analyze
```

## 📊 测试覆盖

当前版本包含 **11 个单元测试**，覆盖所有核心功能模块：

- ✅ StringUtils 测试用例
- ✅ DateUtils 测试用例
- ✅ ValidationUtils 测试用例

运行 `flutter test` 查看详细测试结果。

## 🤝 贡献指南

欢迎贡献代码！请遵循以下步骤：

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

### 代码规范

- 遵循 Dart 官方风格指南
- 为公共 API 编写文档注释
- 新增功能必须包含对应的单元测试
- 确保 `flutter analyze` 无错误
- 确保 `flutter test` 全部通过

## 📝 变更日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新历史。

## 📄 许可证

本项目基于 [MIT License](LICENSE) 开源。

## 🙏 致谢

感谢所有贡献者和 Flutter 社区！

## 📞 联系方式

- 问题反馈：[GitHub Issues](https://github.com/yourusername/flutter_utils/issues)
- 功能建议：[GitHub Discussions](https://github.com/yourusername/flutter_utils/discussions)

---

**让 Flutter 开发更简单高效！** 🚀
