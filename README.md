# tools_box

[![Pub Version](https://img.shields.io/pub/v/tools_box)](https://pub.dev/packages/tools_box)
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
  tools_box: ^0.1.1
```

### 导入包

```dart
import 'package:tools_box/tools_box.dart';
```

---

## 📖 APIs

### • StringUtils 相关 -> [string_utils.dart](lib/src/string_utils.dart) -> [Demo](example/lib/main.dart#L71-L89)

```dart
isEmail                      : 验证邮箱格式
isPhoneNumber                : 验证中国手机号（11位，1开头）
capitalize                   : 首字母大写
capitalizeAllOf              : 每个单词首字母大写
isNumeric                    : 判断是否为数字字符串
reverse                      : 字符串反转
nullIfEmpty                  : 空字符串转 null
truncate(int length)         : 字符串截断（支持自定义后缀）
removeWhitespace             : 移除所有空白字符
isURL                        : 验证 URL 格式
```

**使用示例：**

```dart
import 'package:tools_box/tools_box.dart';

// 验证类
'test@example.com'.isEmail;           // true
'13812345678'.isPhoneNumber;          // true
'https://example.com'.isURL;          // true
'12345'.isNumeric;                    // true

// 格式化类
'hello'.capitalize;                   // 'Hello'
'hello world'.capitalizeAllOf;        // 'Hello World'
'flutter'.reverse;                    // 'rettulf'

// 工具类
'这是一个很长的字符串'.truncate(10); // '这是一个很长的字...'
'  hello world  '.removeWhitespace;  // 'helloworld'
''.nullIfEmpty;                       // null
```

---

### • DateUtils 相关 -> [date_utils.dart](lib/src/date_utils.dart) -> [Demo](example/lib/main.dart)

```dart
formatDate(DateTime, {pattern})       : 格式化日期（默认 yyyy-MM-dd）
formatDateTime(DateTime, {pattern})   : 格式化日期时间（默认 yyyy-MM-dd HH:mm:ss）
timeAgo(DateTime)                     : 计算相对时间（中文，如：5分钟前、2小时前）
isToday(DateTime)                     : 判断是否为今天
isYesterday(DateTime)                 : 判断是否为昨天
startOfDay(DateTime)                  : 获取一天的开始时间 (00:00:00)
endOfDay(DateTime)                    : 获取一天的结束时间 (23:59:59)
daysInRange(start, end)               : 生成指定范围内的日期列表
```

**使用示例：**

```dart
final now = DateTime.now();

// 格式化日期
DateUtils.formatDate(now);                              // '2024-01-15'
DateUtils.formatDate(now, pattern: 'yyyy年MM月dd日');    // '2024年01月15日'

// 相对时间（中文）
DateUtils.timeAgo(now.subtract(Duration(minutes: 5)));   // '5分钟前'
DateUtils.timeAgo(now.subtract(Duration(hours: 2)));     // '2小时前'
DateUtils.timeAgo(now.subtract(Duration(days: 1)));      // '1天前'

// 日期判断
DateUtils.isToday(now);                                   // true
DateUtils.isYesterday(now.subtract(Duration(days: 1)));  // true

// 时间边界
DateUtils.startOfDay(now);  // DateTime(2024, 1, 15, 0, 0, 0)
DateUtils.endOfDay(now);    // DateTime(2024, 1, 15, 23, 59, 59)

// 日期范围
final days = DateUtils.daysInRange(start, end);           // 返回日期列表
```

---

### • WidgetExtensions 相关 -> [widget_extensions.dart](lib/src/widget_extensions.dart#L8-L110) -> [Demo](example/lib/main.dart#L129-L193)

```dart
paddingAll(double value)                           : 四周等距 padding
paddingSymmetric({horizontal, vertical})            : 水平/垂直 padding
only({left, top, right, bottom})                    : 自定义方向 padding
center()                                            : 居中对齐
align({alignment})                                  : 自定义对齐方式
expand({flex})                                       : Expanded 包裹
flexible({flex, fit})                                : Flexible 包裹
positioned({left, top, right, bottom})               : 绝对定位（用于 Stack）
onTap(VoidCallback)                                  : 添加点击事件
sizedBox({width, height})                            : 设置固定尺寸
clipRRect({radius})                                  : 圆角裁剪
decorated({decoration, position})                    : 添加装饰（背景、边框等）
opacity(double opacity)                               : 设置透明度 (0.0-1.0)
safeArea({top, bottom})                              : 安全区域适配
hero(Object tag)                                     : Hero 动画标签
tooltip(String message)                               : 悬停提示信息
visible(bool visible, {replacement})                 : 控制显隐状态
```

**使用示例：**

```dart
import 'package:flutter/material.dart';
import 'package:tools_box/tools_box.dart';

// 基础用法
Text('Hello').paddingAll(16);
Text('Hello').paddingSymmetric(horizontal: 20, vertical: 10);
Text('Centered').center();
Container().expand(flex: 1);
Icon(Icons.star).onTap(() => print('clicked!'));
Image.network(url).clipRRect(radius: 12);

// 链式调用示例
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

---

### • BuildContextExtensions 相关 -> [widget_extensions.dart](lib/src/widget_extensions.dart#L112-L139) -> [Demo](example/lib/main.dart#L196-L234)

```dart
screenWidth                                          : 获取屏幕宽度
screenHeight                                         : 获取屏幕高度
theme                                                : 获取 ThemeData
textTheme                                            : 获取 TextTheme
colorScheme                                          : 获取 ColorScheme
isKeyboardVisible                                    : 判断键盘是否可见
isDarkMode                                           : 判断暗色模式
hideKeyboard()                                        : 隐藏键盘
showSnackBar(String message)                          : 显示 SnackBar 提示
push<T>(WidgetBuilder builder)                        : 页面导航跳转
pop<T>([T? result])                                   : 页面返回
```

**使用示例：**

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取屏幕尺寸
    final width = context.screenWidth;
    final height = context.screenHeight;

    // 获取主题数据
    final theme = context.theme;
    final colorScheme = context.colorScheme;

    // 判断暗色模式
    if (context.isDarkMode) {
      // 暗色主题逻辑
    }

    // 键盘状态
    if (context.isKeyboardVisible) {
      // 键盘已弹出
    }

    // 操作方法
    context.hideKeyboard();
    context.showSnackBar('操作成功！');
    context.push((ctx) => DetailPage());
    context.pop();

    return Container();
  }
}
```

---

### • ValidationUtils 相关 -> [validation_utils.dart](lib/src/validation_utils.dart) -> [Demo](example/lib/main.dart#L92-L127)

#### A. 基础验证方法（返回 bool）

```dart
isValidEmail(String email)                             : 邮箱格式验证
isValidPhone(String phone)                              : 中国手机号验证
isValidPassword(String password, {minLength})            : 密码长度验证（默认最小6位）
isValidURL(String url)                                  : URL 格式验证
isValidIDCard(String idCard)                            : 身份证号验证（18位）
isChinese(String text)                                  : 中文字符检测
containsOnlyNumbers(String text)                        : 纯数字检测
containsOnlyLetters(String text)                        : 纯字母检测
containsOnlyLettersAndNumbers(String text)              : 字母数字组合检测
```

#### B. 表单验证方法（返回 String? 或 null）

```dart
validateEmail(String? value)                            : 表单邮箱验证（用于 TextFormField）
validatePhone(String? value)                            : 表单手机号验证
validatePassword(String? value, {minLength})             : 表单密码验证
validateRequired(String? value, {fieldName})             : 必填字段验证（可自定义字段名）
```

**使用示例：**

```dart
// 基础验证（返回 bool）
ValidationUtils.isValidEmail('test@example.com');        // true
ValidationUtils.isValidPhone('13812345678');             // true
ValidationUtils.isChinese('你好');                        // true

// 表单验证（返回错误消息或 null）
ValidationUtils.validateEmail('invalid-email');          // '请输入有效的邮箱地址'
ValidationUtils.validateEmail('test@example.com');       // null (验证通过)
ValidationUtils.validatePhone('');                       // '手机号不能为空'
ValidationUtils.validateRequired('', fieldName: '用户名'); // '用户名不能为空'

// 在 TextFormField 中使用
TextFormField(
  decoration: InputDecoration(labelText: '邮箱'),
  validator: (value) => ValidationUtils.validateEmail(value),
)

TextFormField(
  decoration: InputDecoration(labelText: '手机号'),
  validator: (value) => ValidationUtils.validatePhone(value),
)

TextFormField(
  obscureText: true,
  decoration: InputDecoration(labelText: '密码'),
  validator: (value) => ValidationUtils.validatePassword(value, minLength: 8),
)
```

---

## 🎯 示例应用

查看 `example` 目录获取完整的使用示例：

```bash
cd example
flutter run -d edge
```

示例应用展示了所有功能模块的实际使用效果。

## 🔧 开发指南

### 本地开发

如果你想参与开发或修改此包：

1. 克隆仓库：
```bash
git clone https://github.com/dxmwl/tools_box.git
cd tools_box
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
cd example
flutter pub get
flutter run
```

### 运行测试

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/tools_box_test.dart

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

- 问题反馈：[GitHub Issues](https://github.com/dxmwl/tools_box/issues)
- 功能建议：[GitHub Discussions](https://github.com/dxmwl/tools_box/discussions)

---

**让 Flutter 开发更简单高效！** 🚀
