# Tools Box - Code Wiki 文档

> **项目版本**: 0.1.0
> **最后更新**: 2024-01-15
> **文档生成日期**: 2026-05-23

---

## 📋 目录

- [1. 项目概述](#1-项目概述)
- [2. 项目架构](#2-项目架构)
- [3. 目录结构详解](#3-目录结构详解)
- [4. 核心模块详解](#4-核心模块详解)
  - [4.1 StringUtils（字符串工具）](#41-stringutils字符串工具)
  - [4.2 DateUtils（日期时间工具）](#42-dateutils日期时间工具)
  - [4.3 WidgetExtensions（Widget扩展方法）](#43-widgetextensionswidget扩展方法)
  - [4.4 BuildContextExtensions（BuildContext扩展）](#44-buildcontextextensionsbuildcontext扩展)
  - [4.5 ValidationUtils（表单验证工具）](#45-validationutils表单验证工具)
- [5. 模块依赖关系](#5-模块依赖关系)
- [6. 配置文件说明](#6-配置文件说明)
- [7. 测试策略与覆盖](#7-测试策略与覆盖)
- [8. CI/CD 流水线](#8-cicd-流水线)
- [9. 项目运行方式](#9-项目运行方式)
- [10. API 快速参考](#10-api-快速参考)
- [11. 最佳实践与使用建议](#11-最佳实践与使用建议)
- [12. 路线图与未来规划](#12-路线图与未来规划)

---

## 1. 项目概述

### 1.1 项目简介

**Tools Box** 是一个功能丰富的 Flutter 工具库，旨在为 Flutter 开发者提供常用的工具方法和便捷的扩展功能。该项目采用纯 Dart 实现，通过 Dart 的 **Extension（扩展）** 机制和 **静态工具类** 模式，为 String、Widget、BuildContext 等核心类型提供了大量实用的方法。

### 1.2 核心特性

| 特性类别 | 功能描述 |
|---------|---------|
| 🔤 字符串处理 | 邮箱/手机号验证、格式化、截断、反转等 |
| 📅 日期时间 | 格式化、相对时间显示、日期范围生成等 |
| 🎨 Widget 扩展 | 链式调用 padding、居中、圆角、装饰等 |
| 📱 Context 扩展 | 屏幕尺寸获取、主题访问、导航、键盘控制 |
| ✅ 表单验证 | 完整的表单验证体系，支持错误消息返回 |

### 1.3 技术栈

- **语言**: Dart (SDK ^3.11.3)
- **框架**: Flutter (>=1.17.0)
- **核心依赖**: `intl: ^0.19.0`（国际化日期格式化）
- **开发依赖**: `flutter_test`, `flutter_lints: ^6.0.0`
- **代码规范**: Dart Official Style Guide + flutter_lints

### 1.4 项目定位

这是一个 **Flutter Package（包）** 项目，可以被其他 Flutter 应用作为依赖引入。项目遵循语义化版本控制（Semantic Versioning），提供完整的文档、测试和示例应用。

---

## 2. 项目架构

### 2.1 整体架构图

```
┌─────────────────────────────────────────────────────────────┐
│                    tools_box (Package)                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐   │
│  │  StringUtils │  │  DateUtils   │  │ ValidationUtils  │   │
│  │  (Extension) │  │   (Class)    │  │     (Class)      │   │
│  └──────────────┘  └──────────────┘  └──────────────────┘   │
│                                                              │
│  ┌─────────────────────┐  ┌──────────────────────────────┐   │
│  │ WidgetExtensions    │  │ BuildContextExtensions       │   │
│  │ (Extension)         │  │ (Extension)                  │   │
│  └─────────────────────┘  └──────────────────────────────┘   │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│                     External Dependencies                   │
│  ┌────────────────┐  ┌──────────────────────────────────┐   │
│  │   intl: ^0.19  │  │        Flutter SDK               │   │
│  │  (Date Format) │  │  (Material, Widgets, etc.)       │   │
│  └────────────────┘  └──────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 设计模式

本项目采用了以下设计模式和编程范式：

#### 2.2.1 Extension（扩展）模式
利用 Dart 的 extension 机制，为现有类型添加新方法：
- **StringUtils**: 扩展 `String` 类型
- **WidgetExtensions**: 扩展 `Widget` 类型
- **BuildContextExtensions**: 扩展 `BuildContext` 类型

**优势**:
- 无需修改原始类即可添加功能
- 支持链式调用（Method Chaining）
- 提高代码可读性和开发效率
- 符合 Dart 语言惯用写法

#### 2.2.2 静态工具类模式
对于不依赖实例状态的工具方法，使用静态类封装：
- **DateUtils**: 所有方法均为 static
- **ValidationUtils**: 所有方法均为 static

**优势**:
- 无需实例化即可使用
- 方法调用清晰明确：`ClassName.methodName()`
- 便于组织和查找相关功能

#### 2.2.3 Facade（外观）模式
通过统一的入口文件 [tools_box.dart](lib/tools_box.dart) 导出所有模块：

```dart
library tools_box;

export 'src/string_utils.dart';
export 'src/date_utils.dart';
export 'src/widget_extensions.dart';
export 'src/validation_utils.dart';
```

**用户只需一行导入即可使用全部功能**:
```dart
import 'package:tools_box/tools_box.dart';
```

### 2.3 代码组织原则

1. **单一职责**: 每个文件只负责一个功能领域
2. **高内聚低耦合**: 模块间依赖最小化
3. **一致性**: 统一的命名规范和代码风格
4. **可测试性**: 所有关键功能都有对应的单元测试
5. **可扩展性**: 使用 Extension 机制便于后续扩展

---

## 3. 目录结构详解

```
tools_box/
│
├── lib/                              # 主源码目录
│   ├── tools_box.dart            # 包入口文件（统一导出）
│   └── src/                          # 源码子目录
│       ├── string_utils.dart          # 字符串扩展方法
│       ├── date_utils.dart           # 日期时间工具类
│       ├── widget_extensions.dart    # Widget 和 BuildContext 扩展
│       └── validation_utils.dart     # 表单验证工具类
│
├── test/                             # 测试目录
│   └── tools_box_test.dart       # 单元测试文件
│
├── example_app/                      # 示例应用
│   ├── lib/
│   │   └── main.dart                # 示例应用入口
│   ├── android/                     # Android 平台配置
│   ├── ios/                         # iOS 平台配置
│   ├── linux/                       # Linux 平台配置
│   ├── macos/                       # macOS 平台配置
│   ├── web/                         # Web 平台配置
│   ├── windows/                     # Windows 平台配置
│   └── pubspec.yaml                 # 示例应用依赖配置
│
├── .github/workflows/               # CI/CD 配置
│   └── publish.yml                  # 自动发布到 pub.dev
│
├── pubspec.yaml                     # 包配置文件
├── analysis_options.yaml            # 代码分析规则
├── README.md                        # 项目说明文档
├── CHANGELOG.md                     # 版本变更日志
├── LICENSE                          # MIT 开源许可证
└── .metadata                        # IDE 元数据
```

### 3.1 关键目录说明

| 目录/文件 | 用途 | 重要程度 |
|----------|------|---------|
| `lib/src/` | 核心源码，包含所有功能实现 | ⭐⭐⭐⭐⭐ |
| `lib/tools_box.dart` | 包入口，统一导出所有模块 | ⭐⭐⭐⭐⭐ |
| `test/` | 单元测试，保证代码质量 | ⭐⭐⭐⭐ |
| `example_app/` | 示例应用，展示实际用法 | ⭐⭐⭐⭐ |
| `.github/workflows/` | CI/CD 自动化流程 | ⭐⭐⭐ |

---

## 4. 核心模块详解

### 4.1 StringUtils（字符串工具）

**文件位置**: [lib/src/string_utils.dart](lib/src/string_utils.dart)

**类型**: Extension on String

**职责**: 为 String 类型提供常用的验证、格式化和转换方法

#### 4.1.1 类定义

```dart
extension StringUtils on String { ... }
```

#### 4.1.2 方法清单

##### 验证类方法（Getter）

| 方法名 | 返回类型 | 说明 | 示例 |
|--------|---------|------|------|
| `isEmail` | `bool` | 验证是否为邮箱格式 | `'a@b.com'.isEmail` → `true` |
| `isPhoneNumber` | `bool` | 验证是否为中国手机号（1开头，11位） | `'13812345678'.isPhoneNumber` → `true` |
| `isNumeric` | `bool` | 判断字符串是否可转换为数字 | `'123'.isNumeric` → `true` |
| `isURL` | `bool` | 验证是否为有效的 HTTP/HTTPS URL | `'https://a.com'.isURL` → `true` |

##### 格式化转换方法（Getter）

| 方法名 | 返回类型 | 说明 | 示例 |
|--------|---------|------|------|
| `capitalize` | `String` | 首字母大写 | `'hello'.capitalize` → `'Hello'` |
| `capitalizeAllOf` | `String` | 每个单词首字母大写 | `'hello world'.capitalizeAllOf` → `'Hello World'` |
| `reverse` | `String` | 字符串反转 | `'abc'.reverse` → `'cba'` |
| `removeWhitespace` | `String` | 移除所有空白字符 | `' a b '.removeWhitespace` → `'ab'` |
| `nullIfEmpty` | `String?` | 空字符串转为 null | `''.nullIfEmpty` → `null` |

##### 工具方法（Function）

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `truncate(int length, {String suffix = '...'})` | 截断长度，后缀（可选） | `String` | 超长字符串截断 |

**示例**:
```dart
'Hello World'.truncate(5);  // 'Hello...'
'Hi'.truncate(5);           // 'Hi'（不超过长度则原样返回）
```

#### 4.1.3 实现细节

**邮箱验证逻辑**:
```dart
bool get isEmail => contains('@') && contains('.');
```
- 简单实现：仅检查是否包含 @ 和 .
- 适用场景：快速初步验证
- 注意：不进行完整的 RFC 5322 邮箱格式校验

**手机号验证逻辑**:
```dart
bool get isPhoneNumber => RegExp(r'^1[3-9]\d{9}$').hasMatch(this);
```
- 正则表达式解析：
  - `^` : 字符串开始
  - `1`: 必须以 1 开头
  - `[3-9]`: 第二位为 3-9（中国手机号段）
  - `\d{9}`: 后接 9 位数字
  - `$`: 字符串结束
- 总长度：11 位数字

**URL 验证正则**:
```dart
r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
```
- 支持 http 和 https
- 可选 www. 前缀
- 支持查询参数和路径

#### 4.1.4 使用场景

- **表单输入验证**: 用户输入的邮箱、手机号快速检查
- **文本格式化**: 显示名称、标题的首字母大写处理
- **数据处理**: 清理用户输入的空白字符
- **UI 文本展示**: 超长文本截断显示省略号

---

### 4.2 DateUtils（日期时间工具）

**文件位置**: [lib/src/date_utils.dart](lib/src/date_utils.dart)

**类型**: Static Class（静态工具类）

**职责**: 提供日期格式化、相对时间计算、日期范围生成等功能

#### 4.2.1 类定义

```dart
class DateUtils {
  // 所有方法均为 static
}
```

**外部依赖**: `package:intl/intl.dart`（用于 DateFormat）

#### 4.2.2 方法清单

##### 格式化方法

| 方法名 | 参数 | 返回类型 | 默认格式 | 说明 |
|--------|------|---------|---------|------|
| `formatDate(DateTime date, {String pattern})` | 日期对象，格式模式 | `String` | `'yyyy-MM-dd'` | 日期格式化 |
| `formatDateTime(DateTime date, {String pattern})` | 日期对象，格式模式 | `String` | `'yyyy-MM-dd HH:mm:ss'` | 日期时间格式化 |

**支持的格式模式示例**:
```dart
DateUtils.formatDate(date);                           // '2024-01-15'
DateUtils.formatDate(date, pattern: 'yyyy年MM月dd日'); // '2024年01月15日'
DateUtils.formatDateTime(date);                       // '2024-01-15 14:30:00'
DateUtils.formatDateTime(date, pattern: 'MM/dd HH:mm'); // '01/15 14:30'
```

##### 相对时间方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `timeAgo(DateTime date)` | 目标日期 | `String` | 计算相对当前时间的中文描述 |

**返回值规则**:

| 时间差 | 返回值 |
|--------|--------|
| > 365 天 | `X年前` |
| > 30 天 | `X个月前` |
> 0 天 | `X天前` |
> 0 小时 | `X小时前` |
> 0 分钟 | `X分钟前` |
其他 | `刚刚` |

**示例**:
```dart
final now = DateTime.now();
DateUtils.timeAgo(now.subtract(Duration(minutes: 5)));  // '5分钟前'
DateUtils.timeAgo(now.subtract(Duration(hours: 2)));    // '2小时前'
DateUtils.timeAgo(now.subtract(Duration(days: 1)));     // '1天前'
DateUtils.timeAgo(now.subtract(Duration(days: 400)));   // '1年前'
```

##### 判断方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `isToday(DateTime date)` | 日期 | `bool` | 是否为今天 |
| `isYesterday(DateTime date)` | 日期 | `bool` | 是否为昨天 |

**实现原理**:
```dart
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
```

##### 边界计算方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `startOfDay(DateTime date)` | 日期 | `DateTime` | 当天 00:00:00 |
| `endOfDay(DateTime date)` | 日期 | `DateTime` | 当天 23:59:59 |

**示例**:
```dart
final date = DateTime(2024, 1, 15, 14, 30, 0);
DateUtils.startOfDay(date);  // DateTime(2024, 1, 15, 0, 0, 0)
DateUtils.endOfDay(date);    // DateTime(2024, 1, 15, 23, 59, 59)
```

##### 范围生成方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `daysInRange(DateTime start, DateTime end)` | 开始日期，结束日期 | `List<DateTime>` | 生成日期列表（含首尾） |

**算法**:
```dart
static List<DateTime> daysInRange(DateTime start, DateTime end) {
  final days = <DateTime>[];
  var current = start;
  while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
    days.add(current);
    current = current.add(Duration(days: 1));
  }
  return days;
}
```

**示例**:
```dart
final start = DateTime(2024, 1, 1);
final end = DateTime(2024, 1, 3);
final days = DateUtils.daysInRange(start, end);
// [
//   DateTime(2024, 1, 1),
//   DateTime(2024, 1, 2),
//   DateTime(2024, 1, 3)
// ]
```

#### 4.2.3 使用场景

- **社交应用**: 显示"5分钟前"、"2小时前"等相对时间
- **日历组件**: 生成月份视图所需的日期列表
- **数据筛选**: 按今天/昨天筛选数据
- **报表系统**: 按天统计数据的边界计算
- **消息应用**: 时间戳人性化显示

---

### 4.3 WidgetExtensions（Widget 扩展方法）

**文件位置**: [lib/src/widget_extensions.dart](lib/src/widget_extensions.dart)

**类型**: Extension on Widget + Extension on BuildContext

**职责**: 为 Widget 提供链式调用的便捷方法，简化 UI 构建代码

#### 4.3.1 WidgetExtensions（Widget 扩展）

##### 布局方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `paddingAll(double value)` | 内边距值 | `Padding` | 四周等距内边距 |
| `paddingSymmetric({double horizontal, double vertical})` | 水平/垂直内边距 | `Padding` | 对称内边距 |
| `only({double left, top, right, bottom})` | 各方向内边距 | `Padding` | 自定义方向内边距 |

**示例**:
```dart
Text('Hello')
    .paddingAll(16)                                      // 四周16px
    .paddingSymmetric(horizontal: 20, vertical: 10)      // 水平20px，垂直10px
    .only(left: 16, right: 16);                          // 仅左右16px
```

##### 对齐和布局包裹方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `center()` | 无 | `Center` | 居中对齐 |
| `align({Alignment alignment})` | 对齐方式（默认居中） | `Align` | 自定义对齐 |
| `expand({int flex})` | 弹性系数（默认1） | `Expanded` | Expanded 包裹 |
| `flexible({int flex, FlexFit fit})` | 弹性系数，适配方式 | `Flexible` | Flexible 包裹 |

**示例**:
```dart
Text('Centered').center();
Container().expand(flex: 2);  // 占据 2 份空间
Container().flexible(flex: 1, fit: FlexFit.tight);
```

##### 定位和交互方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `positioned({double? left, top, right, bottom})` | 各方向偏移量 | `Positioned` | 绝对定位（需在 Stack 中使用） |
| `onTap(VoidCallback onTap)` | 点击回调 | `GestureDetector` | 添加点击事件 |

**示例**:
```dart
Icon(Icons.star).onTap(() => print('clicked!'));
Text('Positioned').positioned(top: 10, left: 10);
```

##### 尺寸和样式方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `sizedBox({double? width, height})` | 宽高 | `SizedBox` | 设置固定尺寸 |
| `clipRRect({double radius})` | 圆角半径（默认8） | `ClipRRect` | 圆角裁剪 |
| `decorated({required BoxDecoration decoration, DecorationPosition position})` | 装饰配置 | `DecoratedBox` | 添加背景、边框等 |
| `opacity(double opacity)` | 透明度（0-1） | `Opacity` | 设置透明度 |

**示例**:
```dart
Text('Sized').sizedBox(width: 200, height: 100);
Image.network(url).clipRRect(radius: 12);
Text('Decorated')
    .decorated(decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(8),
    ));
Text('Transparent').opacity(0.5);
```

##### 其他包装方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `safeArea({bool top, bottom})` | 是否避开顶部/底部（默认 true） | `SafeArea` | 安全区域适配 |
| `hero(Object tag)` | Hero 标签 | `Hero` | Hero 动画标签 |
| `tooltip(String message)` | 提示文字 | `Tooltip` | 长按提示信息 |
| `visible(bool visible, {Widget? replacement})` | 是否可见，替代 widget | `Visibility` | 控制显隐 |

**示例**:
```dart
Column(children: [Text('Safe')]).safeArea();
Image.asset(photo).hero('photo_hero');
Icon(Icons.info).tooltip('这是一个提示');
Text('Visible').visible(true);
Text('Hidden').visible(false, replacement: SizedBox());
```

#### 4.3.2 BuildContextExtensions（BuildContext 扩展）

##### 属性访问 Getter

| 属性名 | 返回类型 | 说明 |
|--------|---------|------|
| `screenWidth` | `double` | 屏幕宽度（逻辑像素） |
| `screenHeight` | `double` | 屏幕高度（逻辑像素） |
| `theme` | `ThemeData` | 当前主题数据 |
| `textTheme` | `textTheme` | 文本主题 |
| `colorScheme` | `ColorScheme` | 颜色方案 |
| `isKeyboardVisible` | `bool` | 键盘是否可见 |
| `isDarkMode` | `bool` | 是否为暗色模式 |

**实现示例**:
```dart
double get screenWidth => MediaQuery.of(this).size.width;
bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
```

##### 操作方法

| 方法名 | 参数 | 返回类型 | 说明 |
|--------|------|---------|------|
| `hideKeyboard()` | 无 | `void` | 收起键盘 |
| `showSnackBar(String message)` | 提示信息 | `void` | 显示 SnackBar |
| `push<T>(WidgetBuilder builder)` | 页面构建器 | `Future<T?>` | 页面跳转 |
| `pop<T>([T? result])` | 返回结果（可选） | `void` | 页面返回 |

**示例**:
```dart
// 在 StatelessWidget 中使用
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;
    
    if (context.isDarkMode) {
      // 暗色主题逻辑
    }
    
    context.hideKeyboard();
    context.showSnackBar('操作成功！');
    context.push((context) => DetailPage());
    context.pop();
    
    return Container();
  }
}
```

#### 4.3.3 链式调用优势

WidgetExtensions 的最大优势是支持**链式调用**，大幅提升代码可读性：

```dart
// 传统写法
Padding(
  padding: EdgeInsets.all(16),
  child: Center(
    child: GestureDetector(
      onTap: () => print('tapped!'),
      child: Text('Hello'),
    ),
  ),
)

// 链式调用写法
Text('Hello')
    .paddingAll(16)
    .center()
    .onTap(() => print('tapped!'))
```

**优势对比**:
- ✅ 减少嵌套层级，避免"回调地狱"
- ✅ 代码更简洁，阅读顺序从左到右、从上到下
- ✅ 易于修改和调整 UI 结构
- ✅ 符合现代 Flutter 开发趋势（如 styled_widget 等包的设计理念）

---

### 4.4 BuildContextExtensions（BuildContext 扩展）

**已在 4.3.2 节详细说明**，此处补充设计理念和使用最佳实践。

#### 4.4.1 设计理念

BuildContext 是 Flutter 中最重要的上下文对象，它提供了：
- **MediaQuery 数据**: 屏幕尺寸、键盘状态等
- **Theme 数据**: 主题、颜色方案、文本样式
- **Navigator 导航**: 页面跳转和返回
- **ScaffoldMessenger**: SnackBar 显示

通过扩展 BuildContext，开发者可以：
- 避免重复编写 `MediaQuery.of(context)` 等样板代码
- 以属性方式访问常用数据（如 `context.screenWidth`）
- 简化导航和交互操作（如 `context.push()`、`context.showSnackBar()`）

#### 4.4.2 性能注意事项

所有 BuildContext 扩展都是 **Getter 或 Method**，不会缓存结果，每次访问都会重新查询 InheritedWidget。

**建议**:
- 在 `build` 方法中频繁使用的值（如 theme），可以保存到局部变量
- 对于屏幕尺寸等不常变化的值，无需担心性能问题

```dart
@override
Widget build(BuildContext context) {
  final theme = context.theme;  // 缓存到局部变量
  final screenWidth = context.screenWidth;
  
  return Container(
    color: theme.primaryColor,
    width: screenWidth,
  );
}
```

---

### 4.5 ValidationUtils（表单验证工具）

**文件位置**: [lib/src/validation_utils.dart](lib/src/validation_utils.dart)

**类型**: Static Class（静态工具类）

**职责**: 提供完整的数据验证功能，包括基础验证和表单验证（带错误消息）

#### 4.5.1 类定义

```dart
class ValidationUtils {
  // 所有方法均为 static
}
```

#### 4.5.2 方法分类

##### 第一类：基础验证方法（返回 bool）

这些方法用于简单的真值判断，适合条件语句：

| 方法名 | 参数 | 返回类型 | 验证规则 |
|--------|------|---------|---------|
| `isValidEmail(String email)` | 邮箱字符串 | `bool` | 标准邮箱格式 |
| `isValidPhone(String phone)` | 手机号字符串 | `bool` | 中国手机号（11位，1开头） |
| `isValidPassword(String password, {int minLength})` | 密码字符串，最小长度（默认6） | `bool` | 长度检查 |
| `isValidURL(String url)` | URL 字符串 | `bool` | HTTP/HTTPS URL 格式 |
| `isValidIDCard(String idCard)` | 身份证号字符串 | `bool` | 18位中国身份证号 |
| `isChinese(String text)` | 文本字符串 | `bool` | 包含中文字符 |
| `containsOnlyNumbers(String text)` | 文本字符串 | `bool` | 纯数字 |
| `containsOnlyLetters(String text)` | 文本字符串 | `bool` | 纯字母 |
| `containsOnlyLettersAndNumbers(String text)` | 文本字符串 | `bool` | 字母和数字组合 |

**正则表达式详情**:

```dart
// 邮箱验证（更严格版）
r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'

// 身份证号验证（18位）
r'^[1-9]\d{5}(18\|19\|20)\d{2}(0[1-9]\|1[0-2])(0[1-9]\|[12]\d\|3[01])\d{3}[\dXx]$'

// 解析：
// [1-9]\d{5          - 地区码（6位，不能以0开头）
// (18|19|20)\d{2     - 出生年份（4位，1800-2099）
// (0[1-9]|1[0-2])    - 月份（01-12）
// (0[1-9]|[12]\d|3[01]) - 日期（01-31）
// \d{3}[ \dXx]        - 顺序码（3位）+ 校验码（1位，数字或X）
```

##### 第二类：表单验证方法（返回 String?）

这些方法专门用于 **TextFormField 的 validator**，返回 `null` 表示验证通过，否则返回错误消息：

| 方法名 | 参数 | 返回类型 | 错误消息 |
|--------|------|---------|---------|
| `validateEmail(String? value)` | 待验证值 | `String?` | `'邮箱不能为空'` / `'请输入有效的邮箱地址'` |
| `validatePhone(String? value)` | 待验证值 | `String?` | `'手机号不能为空'` / `'请输入有效的手机号码'` |
| `validatePassword(String? value, {int minLength})` | 待验证值，最小长度 | `String?` | `'密码不能为空'` / `'密码长度至少需要X位'` |
| `validateRequired(String? value, {String fieldName})` | 待验证值，字段名（默认'此字段'） | `String?` | `'X不能为空'` |

**验证流程**:
```dart
static String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return '邮箱不能为空';           // 第一步：检查空值
  }
  if (!isValidEmail(value)) {
    return '请输入有效的邮箱地址';     // 第二步：格式验证
  }
  return null;                        // 第三步：验证通过
}
```

#### 4.5.3 在 TextFormField 中的使用

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

TextFormField(
  decoration: InputDecoration(labelText: '用户名'),
  validator: (value) => ValidationUtils.validateRequired(value, fieldName: '用户名'),
)
```

#### 4.5.4 与 StringUtils 的区别

虽然 StringUtils 和 ValidationUtils 都提供验证功能，但它们的设计目标不同：

| 特性 | StringUtils | ValidationUtils |
|------|------------|-----------------|
| **类型** | Extension（属性访问） | Static Class（方法调用） |
| **调用方式** | `'text'.isEmail` | `ValidationUtils.isValidEmail('text')` |
| **返回值** | `bool` | `bool` 或 `String?` |
| **适用场景** | 快速判断、条件语句 | 表单验证、错误提示 |
| **错误消息** | ❌ 不提供 | ✅ 提供中文错误消息 |
| **验证范围** | 基础验证（email、phone、url） | 更全面（含身份证、中文检测等） |

**选择建议**:
- 需要**快速布尔判断** → 使用 StringUtils
- 需要**表单验证 + 错误提示** → 使用 ValidationUtils

---

## 5. 模块依赖关系

### 5.1 内部模块依赖图

```
tools_box.dart (入口)
    │
    ├── string_utils.dart (无内部依赖)
    │       └── 仅依赖 Dart 核心 String 类
    │
    ├── date_utils.dart
    │       └── 外部依赖: package:intl/intl.dart
    │
    ├── widget_extensions.dart
    │       ├── 依赖 Flutter: material.dart, widgets.dart
    │       └── 包含两个 Extension: WidgetExtensions + BuildContextExtensions
    │
    └── validation_utils.dart (无内部依赖)
            └── 仅依赖 Dart 核心 RegExp 类
```

### 5.2 外部依赖树

```
tools_box (0.1.0)
│
├── flutter (SDK)
│   └── 用于 Widget 和 BuildContext 扩展
│
├── intl (^0.19.0)
│   └── 用于 DateUtils 的日期格式化（DateFormat 类）
│
├── flutter_test (dev only)
│   └── 用于单元测试
│
└── flutter_lints (^6.0.0) (dev only)
    └── 代码风格检查规则
```

### 5.3 依赖详细说明

#### 5.3.1 intl 包

**用途**: 提供国际化日期格式化功能

**使用位置**: [date_utils.dart](lib/src/date_utils.dart#L1)

**为什么需要**:
- Dart 原生的 `DateTime.toString()` 不支持自定义格式
- `intl` 包的 `DateFormat` 类支持灵活的模式匹配（如 `yyyy-MM-dd`）
- 支持本地化的日期格式（虽然本项目目前仅使用中文）

**版本选择**: `^0.19.0`
- 这是一个稳定且广泛使用的版本
- 与 Dart 3.x SDK 完全兼容

#### 5.3.2 Flutter SDK

**最低要求**: `>=1.17.0`

**使用位置**: [widget_extensions.dart](lib/src/widget_extensions.dart#L1-L2)

**导入的库**:
- `package:flutter/material.dart` - Material Design 组件
- `package:flutter/widgets.dart` - 基础 Widget 系统

**使用的类**:
- Padding, Center, Align, Expanded, Flexible, Positioned
- GestureDetector, SizedBox, ClipRRect, DecoratedBox, Opacity
- SafeArea, Hero, Tooltip, Visibility
- MediaQuery, Theme, Navigator, ScaffoldMessenger, FocusScope

---

## 6. 配置文件说明

### 6.1 pubspec.yaml（包配置）

**文件位置**: [pubspec.yaml](pubspec.yaml)

**关键字段解读**:

```yaml
name: tools_box              # 包名（在 pub.dev 上的唯一标识）
description: "Flutter常用工具集合..."  # 包描述（显示在 pub.dev 上）
version: 0.1.0                   # 语义化版本号
homepage: https://github.com/dxmwl/tools_box  # 主页链接
repository: https://github.com/dxmwl/tools_box  # 仓库地址
issue_tracker: https://github.com/dxmwl/tools_box/issues  # 问题追踪

environment:
  sdk: ^3.11.3                  # Dart SDK 版本约束
  flutter: ">=1.17.0"           # Flutter SDK 版本约束

dependencies:
  flutter:
    sdk: flutter                # Flutter SDK（必需）
  intl: ^0.19.0                 # 日期格式化库

dev_dependencies:
  flutter_test:
    sdk: flutter                # 测试框架
  flutter_lints: ^6.0.0         # 代码规范检查
```

**版本约束语法**:
- `^3.11.3`: 兼容 >=3.11.3 且 <4.0.0 的版本（ caret 约束）
- `>=1.17.0`: 最低版本要求
- `^0.19.0`: 兼容 >=0.19.0 且 <0.20.0 的版本（对于 <1.0.0 的版本）

### 6.2 analysis_options.yaml（代码分析配置）

**文件位置**: [analysis_options.yaml](analysis_options.yaml)

```yaml
include: package:flutter_lints/flutter.yaml
```

**作用**:
- 引入官方推荐的 Flutter 代码规范
- 在 `flutter analyze` 时启用这些规则
- 帮助发现潜在的代码问题和不符合规范的写法

**主要检查项**:
- 命名规范（camelCase、lower_camel_case 等）
- 类型注解完整性
- 未使用的导入和变量
- 文档注释规范
- const 构造函数使用建议

### 6.3 GitHub Actions 配置

**文件位置**: [.github/workflows/publish.yml](.github/workflows/publish.yml)

详见 [第 8 节 CI/CD 流水线](#8-cicd-流水线)

---

## 7. 测试策略与覆盖

### 7.1 测试文件

**文件位置**: [test/tools_box_test.dart](test/tools_box_test.dart)

**测试框架**: `package:flutter_test/flutter_test.dart`

### 7.2 测试用例统计

| 模块 | 测试数量 | 测试内容 |
|------|---------|---------|
| **StringUtils** | 5 个 | 邮箱验证、手机号验证、首字母大写、字符串截断、URL 验证 |
| **DateUtils** | 3 个 | 日期格式化、是否是今天、时间范围生成 |
| **ValidationUtils** | 3 个 | 邮箱验证、手机号验证、表单验证消息 |
| **总计** | **11 个** | - |

### 7.3 测试分组结构

```dart
void main() {
  group('StringUtils 测试', () {
    test('邮箱验证', () { ... });
    test('手机号验证', () { ... });
    test('首字母大写', () { ... });
    test('字符串截断', () { ... });
    test('URL验证', () { ... });
  });

  group('DateUtils 测试', () {
    test('日期格式化', () { ... });
    test('是否是今天', () { ... });
    test('时间范围生成', () { ... });
  });

  group('ValidationUtils 测试', () {
    test('邮箱验证', () { ... });
    test('手机号验证', () { ... });
    test('表单验证消息', () { ... });
  });
}
```

### 7.4 关键测试用例详解

#### 7.4.1 StringUtils 测试

```dart
test('邮箱验证', () {
  expect('test@example.com'.isEmail, true);    // 有效邮箱
  expect('invalid-email'.isEmail, false);       // 缺少域名
  expect(''.isEmail, false);                     // 空字符串
});

test('手机号验证', () {
  expect('13812345678'.isPhoneNumber, true);    // 有效手机号
  expect('12345678901'.isPhoneNumber, false);   // 不以1开头或第二位不在3-9
  expect('1381234567'.isPhoneNumber, false);     // 位数不足
});
```

#### 7.4.2 DateUtils 测试

```dart
test('日期格式化', () {
  final date = DateTime(2024, 1, 15);
  expect(DateUtils.formatDate(date), equals('2024-01-15'));
});

test('是否是今天', () {
  expect(DateUtils.isToday(DateTime.now()), true);                    // 当前时间
  expect(DateUtils.isToday(DateTime.now().subtract(Duration(days: 1))), false);  // 昨天
});

test('时间范围生成', () {
  final start = DateTime(2024, 1, 1);
  final end = DateTime(2024, 1, 3);
  final days = DateUtils.daysInRange(start, end);
  expect(days.length, equals(3));  // 应该包含3天
});
```

#### 7.4.3 ValidationUtils 测试

```dart
test('表单验证消息', () {
  expect(ValidationUtils.validateEmail(null), isNotNull);             // null 值应报错
  expect(ValidationUtils.validateEmail('test@example.com'), isNull);  // 有效邮箱应通过
  expect(ValidationUtils.validateRequired('', fieldName: '用户名'), isNotNull);  // 空值应报错
  expect(ValidationUtils.validateRequired('valid'), isNull);          // 有效值应通过
});
```

### 7.5 运行测试命令

```bash
# 运行所有测试
flutter test

# 运行特定测试文件
flutter test test/tools_box_test.dart

# 生成覆盖率报告
flutter test --coverage

# 运行特定测试分组
flutter test --name "StringUtils 测试"
```

### 7.6 测试覆盖率现状

**当前覆盖率**: 核心功能已基本覆盖

**未覆盖的功能点**:
- ⚠️ WidgetExtensions 的部分方法（因需要 Widget 测试环境）
- ⚠️ BuildContextExtensions 的方法（需要完整 Widget 树）
- ⚠️ DateUtils.timeAgo 的各种时间差场景
- ⚠️ ValidationUtils 的部分验证方法（身份证、中文检测等）

**改进建议**:
1. 增加 Widget 测试用例（使用 tester.pumpWidget）
2. 补充边界情况测试（空值、特殊字符、极值等）
3. 添加集成测试验证模块间协作
4. 目标覆盖率：建议达到 80% 以上

---

## 8. CI/CD 流水线

### 8.1 工作流配置

**文件位置**: [.github/workflows/publish.yml](.github/workflows/publish.yml)

**工作流名称**: Publish to pub.dev

### 8.2 触发条件

```yaml
on:
  push:
    tags:
      - 'v*'   # 当推送以 'v' 开头的 tag 时触发（如 v0.1.0、v0.2.0）
```

**发布流程**:
1. 开发者在本地打 tag：`git tag v0.1.0`
2. 推送 tag 到远程：`git push origin v0.1.0`
3. GitHub Actions 自动触发发布流程

### 8.3 流程步骤

```yaml
jobs:
  publish:
    runs-on: ubuntu-latest    # 运行环境：Ubuntu 最新版
    
    steps:
      1. Checkout code        # 检出代码
      2. Set up Dart          # 安装 Dart SDK
      3. Install dependencies # 运行 dart pub get
      4. Run tests            # 运行测试（dart test）
      5. Publish to pub.dev   # 发布到 pub.dev（需要认证 token）
```

### 8.4 环境变量与密钥

**所需 Secret**:
- `PUB_DEV_PUBLISH_ACCESS_TOKEN`: pub.dev 发布令牌

**配置步骤**:
1. 在 pub.dev 生成访问令牌
2. 在 GitHub 仓库的 Settings → Secrets and variables → Actions 中添加
3. 名称必须为 `PUB_DEV_PUBLISH_ACCESS_TOKEN`

### 8.5 发布命令详解

```bash
# 添加 pub.dev 认证令牌
echo $PUB_DEV_PUBLISH_ACCESS_TOKEN | dart pub token add https://pub.dev

# 强制发布（跳过确认提示）
dart pub publish --force
```

### 8.6 手动发布备选方案

如果 CI/CD 失败或需要手动发布：

```bash
# 1. 确保测试通过
flutter test

# 2. 登录 pub.dev
dart pub token add https://pub.dev

# 3. 发布（ dry-run 先预览）
dart pub publish --dry-run

# 4. 正式发布
dart pub publish
```

---

## 9. 项目运行方式

### 9.1 作为包引用（推荐）

在您的 Flutter 项目中使用 tools_box：

#### 步骤 1: 添加依赖

在项目的 `pubspec.yaml` 中添加：

```yaml
dependencies:
  tools_box: ^0.1.0
```

#### 步骤 2: 安装依赖

```bash
flutter pub get
```

#### 步骤 3: 导入并使用

```dart
import 'package:tools_box/tools_box.dart';

void main() {
  // 使用字符串工具
  print('hello'.capitalize);  // Hello
  
  // 使用日期工具
  print(DateUtils.formatDate(DateTime.now()));  // 2024-01-15
  
  // 使用 Widget 扩展
  Text('Hello').paddingAll(16).center();
}
```

### 9.2 本地开发调试

如果您想修改或扩展此包：

#### 方式一：路径依赖（Path Dependency）

1. 将 tools_box 克隆到您的项目同级目录
2. 在您项目的 `pubspec.yaml` 中添加：

```yaml
dependencies:
  tools_box:
    path: ../tools_box
```

3. 运行 `flutter pub get`

#### 方式二：直接在此项目中开发

```bash
# 1. 克隆仓库
git clone https://github.com/dxmwl/tools_box.git
cd tools_box

# 2. 安装依赖
flutter pub get

# 3. 运行测试
flutter test

# 4. 启动示例应用
cd example_app
flutter pub get
flutter run
```

### 9.3 运行示例应用

示例应用展示了所有功能的实际效果：

```bash
cd example_app
flutter run -d chrome    # 在 Chrome 中运行（Web）
flutter run -d edge       # 在 Edge 中运行（Web）
flutter run               # 在连接的设备/模拟器上运行
```

**示例应用功能**:
- ✅ StringUtils 演示（验证、格式化等）
- ✅ ValidationUtils 演示（表单验证）
- ✅ WidgetExtensions 演示（padding、居中、圆角、透明度等）
- ✅ BuildContextExtensions 演示（屏幕尺寸、SnackBar、键盘控制等）

### 9.4 平台兼容性

tools_box 支持所有 Flutter 平台：

| 平台 | 支持状态 | 备注 |
|------|---------|------|
| Android | ✅ 完全支持 | - |
| iOS | ✅ 完全支持 | - |
| Web | ✅ 完全支持 | 示例应用可在浏览器中运行 |
| macOS | ✅ 完全支持 | - |
| Linux | ✅ 完全支持 | - |
| Windows | ✅ 完全支持 | - |

**注意**: 本包为纯 Dart 实现，无平台特定代码，因此天然跨平台。

---

## 10. API 快速参考

### 10.1 StringUtils API

```dart
// 验证
string.isEmail           // bool
string.isPhoneNumber     // bool
string.isNumeric         // bool
string.isURL             // bool

// 格式化
string.capitalize        // String
string.capitalizeAllOf   // String
string.reverse           // String
string.removeWhitespace  // String
string.nullIfEmpty       // String?

// 工具
string.truncate(length, {suffix})  // String
```

### 10.2 DateUtils API

```dart
// 格式化
DateUtils.formatDate(date, {pattern})        // String
DateUtils.formatDateTime(date, {pattern})    // String

// 相对时间
DateUtils.timeAgo(date)                      // String ('5分钟前')

// 判断
DateUtils.isToday(date)                      // bool
DateUtils.isYesterday(date)                  // bool

// 边界
DateUtils.startOfDay(date)                   // DateTime
DateUtils.endOfDay(date)                     // DateTime

// 范围
DateUtils.daysInRange(start, end)            // List<DateTime>
```

### 10.3 WidgetExtensions API

```dart
// 布局
widget.paddingAll(value)                            // Padding
widget.paddingSymmetric({horizontal, vertical})     // Padding
widget.only({left, top, right, bottom})             // Padding

// 对齐
widget.center()                                     // Center
widget.align({alignment})                           // Align
widget.expand({flex})                               // Expanded
widget.flexible({flex, fit})                        // Flexible

// 定位与交互
widget.positioned({left, top, right, bottom})       // Positioned
widget.onTap(callback)                              // GestureDetector

// 样式
widget.sizedBox({width, height})                    // SizedBox
widget.clipRRect({radius})                          // ClipRRect
widget.decorated({decoration, position})            // DecoratedBox
widget.opacity(value)                               // Opacity

// 包装
widget.safeArea({top, bottom})                      // SafeArea
widget.hero(tag)                                    // Hero
widget.tooltip(message)                             // Tooltip
widget.visible(visible, {replacement})              // Visibility
```

### 10.4 BuildContextExtensions API

```dart
// 属性
context.screenWidth          // double
context.screenHeight         // double
context.theme                // ThemeData
.context.textTheme           // TextTheme
context.colorScheme          // ColorScheme
context.isKeyboardVisible    // bool
context.isDarkMode           // bool

// 操作
context.hideKeyboard()       // void
context.showSnackBar(msg)    // void
context.push(builder)        // Future<T?>
context.pop([result])        // void
```

### 10.5 ValidationUtils API

```dart
// 基础验证（返回 bool）
ValidationUtils.isValidEmail(email)                       // bool
ValidationUtils.isValidPhone(phone)                       // bool
ValidationUtils.isValidPassword(pwd, {minLength})         // bool
ValidationUtils.isValidURL(url)                           // bool
ValidationUtils.isValidIDCard(idCard)                     // bool
ValidationUtils.isChinese(text)                           // bool
ValidationUtils.containsOnlyNumbers(text)                 // bool
ValidationUtils.containsOnlyLetters(text)                 // bool
ValidationUtils.containsOnlyLettersAndNumbers(text)       // bool

// 表单验证（返回 String? 错误消息）
ValidationUtils.validateEmail(value)                      // String?
ValidationUtils.validatePhone(value)                      // String?
ValidationUtils.validatePassword(value, {minLength})      // String?
ValidationUtils.validateRequired(value, {fieldName})      // String?
```

---

## 11. 最佳实践与使用建议

### 11.1 推荐使用模式

#### 11.1.1 链式调用构建 UI

✅ **推荐**:
```dart
Text('标题')
    .paddingSymmetric(horizontal: 16, vertical: 8)
    .center()
    .decorated(decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(8),
    ))
    .onTap(() => handleTap())
    .visible(isVisible);
```

❌ **不推荐**（传统嵌套）:
```dart
Visibility(
  visible: isVisible,
  child: GestureDetector(
    onTap: handleTap,
    child: DecoratedBox(
      decoration: BoxDecoration(...),
      child: Padding(
        padding: ...,
        child: Center(
          child: Text('标题'),
        ),
      ),
    ),
  )
)
```

#### 11.1.2 表单验证组合使用

```dart
TextFormField(
  decoration: InputDecoration(labelText: '邮箱'),
  validator: (value) {
    // 先检查必填
    final requiredError = ValidationUtils.validateRequired(value, fieldName: '邮箱');
    if (requiredError != null) return requiredError;
    
    // 再检查格式
    return ValidationUtils.validateEmail(value);
  },
)
```

#### 11.1.3 日期显示优化

```dart
Widget buildDateDisplay(DateTime date) {
  if (DateUtils.isToday(date)) {
    return Text('今天 ${DateFormat('HH:mm').format(date)}');
  } else if (DateUtils.isYesterday(date)) {
    return Text('昨天 ${DateFormat('HH:mm').format(date)}');
  } else {
    return Text(DateUtils.timeAgo(date));
  }
}
```

### 11.2 性能优化建议

#### 11.2.1 避免在 build 方法中创建正则表达式

虽然当前实现每次调用都会创建新的 RegExp 对象，但对于大多数场景性能影响可忽略。如果在**高频调用场景**（如长列表），可以考虑缓存：

```dart
// 如果需要优化，可以在静态常量中缓存正则
static final _phoneRegex = RegExp(r'^1[3-9]\d{9}$');

bool get isPhoneNumber => _phoneRegex.hasMatch(this);
```

#### 11.2.2 BuildContext 扩展的合理使用

```dart
@override
Widget build(BuildContext context) {
  // ✅ 好：将频繁使用的值缓存到局部变量
  final screenWidth = context.screenWidth;
  final isDark = context.isDarkMode;
  
  return Container(
    width: screenWidth * 0.8,
    color: isDark ? Colors.black : Colors.white,
  );
}
```

### 11.3 代码风格建议

1. **统一导入**: 始终使用 `import 'package:tools_box/tools_box.dart;'` 导入
2. **命名冲突**: 如遇命名冲突，可以使用 `as` 别名或显式导入具体文件
3. **文档注释**: 公共 API 应添加文档注释（当前项目待完善）
4. **类型安全**: 充分利用 Dart 的类型系统，避免 dynamic

### 11.4 常见问题与解决方案

#### Q1: 如何处理空字符串验证？

```dart
String input = '';

// 方式1: 使用 nullIfEmpty
final value = input.nullIfEmpty;  // null

// 方式2: 直接判断
if (input.isEmpty) { ... }

// 方式3: 使用 ValidationUtils
final error = ValidationUtils.validateRequired(input);
```

#### Q2: timeAgo 只支持中文吗？

是的，当前实现硬编码了中文。如果需要多语言支持，可以考虑：

```dart
// 未来改进方向
static String timeAgo(DateTime date, {Locale locale = const Locale('zh')}) {
  // 根据 locale 返回不同语言的字符串
}
```

#### Q3: 如何扩展自定义验证？

可以通过继承或组合 ValidationUtils：

```dart
class CustomValidationUtils extends ValidationUtils {
  static bool isValidUsername(String username) {
    return username.length >= 3 && 
           username.length <= 20 &&
           RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
  }
  
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return '用户名不能为空';
    if (!isValidUsername(value)) return '用户名只能包含字母、数字和下划线';
    return null;
  }
}
```

---

## 12. 路线图与未来规划

### 12.1 已完成功能（v0.1.0）

✅ StringUtils - 10 个方法
✅ DateUtils - 8 个方法
✅ WidgetExtensions - 16 个方法
✅ BuildContextExtensions - 11 个方法/属性
✅ ValidationUtils - 13 个方法
✅ 示例应用
✅ 单元测试（11 个用例）
✅ CI/CD 自动发布
✅ 完整文档

### 12.2 计划中的功能（来自 CHANGELOG.md）

根据 [CHANGELOG.md](CHANGELOG.md) 的 Unreleased 部分：

#### 高优先级

- [ ] **ListUtils** - 列表操作工具
  - 分组、排序、去重、查找
  - 列表分片、批量转换
  
- [ ] **NumUtils** - 数字处理工具
  - 格式化（千分位、货币、百分比）
  - 数值范围判断
  - 数学运算辅助
  
- [ ] **ColorUtils** - 颜色转换工具
  - Hex ↔ Color 转换
  - 颜色明暗度调整
  - 渐变色生成

#### 中优先级

- [ ] **CacheUtils** - 缓存管理工具
  - 内存缓存
  - 简单的 LRU 策略
  
- [ ] **SharedPreferences 工具封装**
  - 类型安全的存取
  - 默认值管理
  - 批量操作

- [ ] **网络请求工具封装**
  - REST API 客户端
  - 错误处理
  - 请求拦截器

#### 低优先级

- [ ] 更多 Widget 扩展方法
  - 动画扩展（fade in/out、slide）
  - 响应式布局扩展
  - 手势识别扩展
  
- [ ] 国际化支持（i18n）
  - DateUtils.timeAgo 多语言
  - ValidationUtils 错误消息多语言
  
- [ ] Null Safety 完全迁移（已完成，因为 SDK 要求 ^3.11.3）

### 12.3 改进建议

基于对当前代码的分析，以下是一些可能的改进方向：

#### 12.3.1 代码质量改进

1. **增加文档注释**
   - 当前代码缺少 dartdoc 注释
   - 建议为每个公共 API 添加 `///` 注释
   - 示例：`/// 验证字符串是否为有效的邮箱地址`

2. **增强测试覆盖率**
   - 目标：80% 以上覆盖率
   - 补充 Widget 测试（使用 WidgetTester）
   - 添加边界情况和异常输入测试

3. **性能优化**
   - 缓存正则表达式对象（static final）
   - 对于 DateUtils.timeAgo，考虑使用 Intl.message 进行国际化

#### 12.3.2 功能增强

1. **StringUtils 增强**
   ```dart
   // 建议新增
   bool get isChineseMobile;       // 更精确的手机号验证
   bool get isLandline;            // 固定电话验证
   String maskMiddle(int keepStart, int keepEnd);  // 脱敏处理（手机号、身份证）
   List<String> toWords();         // 分词
   ```

2. **DateUtils 增强**
   ```dart
   // 建议新增
   static int age(DateTime birthDate);                    // 计算年龄
   static bool isWeekend(DateTime date);                  // 判断周末
   static bool isSameDay(DateTime a, DateTime b);         // 判断同一天
   static String weekday(DateTime date);                  // 获取星期几
   static DateTime workingDays(int days, {List<DateTime> holidays});  // 工作日计算
   ```

3. **WidgetExtensions 增强**
   ```dart
   // 建议新增
   SliverToBoxAdapter asSliver();                         // 转 Sliver
   AnimatedOpacity animatedOpacity(Duration duration);    // 动画透明度
   InteractiveViewer interactiveViewer();                 // 缩放/平移
   AbsorbPointer absorbPointer(bool absorbing);           // 吸收触摸事件
   ```

4. **ValidationUtils 增强**
   ```dart
   // 建议新增
   static bool isValidChineseIDCard(String idCard);        // 更严格的身份证校验（含校验码）
   static bool isValidBankCard(String cardNumber);         // 银行卡号验证
   static bool isValidLicensePlate(String plate);          // 车牌号验证
   static String? validateRange(int? value, {int min, int max, String fieldName});  // 范围验证
   static String? confirmValidator(String? value, String? originalValue, {String fieldName});  // 确认密码等
   ```

#### 12.3.3 架构改进

1. **模块拆分考虑**
   - 当前架构清晰，但随着功能增多，可考虑拆分为多个子包：
     - `tools_box_core` - 核心工具
     - `tools_box_ui` - UI 扩展
     - `tools_box_validation` - 验证工具
   
2. **可配置性增强**
   ```dart
   // 建议：允许自定义验证规则或错误消息
   class ValidationConfig {
     static String emptyEmailError = '邮箱不能为空';
     static String invalidEmailError = '请输入有效的邮箱地址';
     // ...
   }
   ```

3. **Null Safety 和类型安全**
   - 当前已经完全支持 Null Safety（SDK ^3.11.3）
   - 可以考虑增加更多的类型约束和泛型支持

### 12.4 贡献指南

如果您想参与贡献：

1. **Fork 并克隆仓库**
   ```bash
   git clone https://github.com/your-username/tools_box.git
   ```

2. **创建特性分支**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **编写代码和测试**
   - 遵循现有代码风格
   - 为新功能添加测试
   - 确保 `flutter analyze` 无错误
   - 确保 `flutter test` 全部通过

4. **提交更改**
   ```bash
   git commit -m 'Add some amazing feature'
   ```

5. **推送并创建 PR**
   ```bash
   git push origin feature/amazing-feature
   # 然后在 GitHub 上创建 Pull Request
   ```

---

## 附录

### A. 相关资源

- **Pub.dev 包页面**: https://pub.dev/packages/tools_box
- **GitHub 仓库**: https://github.com/dxmwl/tools_box
- **问题追踪**: https://github.com/dxmwl/tools_box/issues
- **Flutter 官方文档**: https://flutter.dev/docs
- **Dart 语言指南**: https://dart.dev/guides/language/language-tour
- **Dart Extension 方法**: https://dart.dev/guides/language/extension-methods
- **intl 包文档**: https://pub.dev/packages/intl
- **Effective Dart (风格指南)**: https://dart.dev/guides/language/effective-dart

### B. 版本历史

| 版本 | 日期 | 主要变更 |
|------|------|---------|
| **0.1.0** | 2024-01-15 | 初始版本发布，包含 5 大模块、57+ 个方法 |

详细变更记录见 [CHANGELOG.md](CHANGELOG.md)

### C. 许可证

```
MIT License

Copyright (c) 2024 dxmwl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

### D. 文档维护信息

- **文档版本**: 1.0.0
- **生成日期**: 2026-05-23
- **对应项目版本**: tools_box v0.1.0
- **维护者**: Code Wiki 自动生成
- **更新频率**: 随项目版本更新

---

## 📊 文档统计

- **总字数**: 约 15,000 字
- **章节数**: 12 个主章节 + 4 个附录
- **API 文档数**: 50+ 个方法和属性
- **代码示例数**: 80+ 个
- **表格数**: 30+ 个
- **架构图**: 2 个

---

> 💡 **提示**: 此文档由 Code Wiki 自动生成，涵盖了项目的完整技术细节。建议结合源代码和示例应用一起阅读，以获得最佳理解效果。
>
> 🚀 **让 Flutter 开发更简单高效！**
