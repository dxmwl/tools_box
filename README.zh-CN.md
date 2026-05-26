# tools_box

[![Pub Version](https://img.shields.io/pub/v/tools_box)](https://pub.dev/packages/tools_box)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Dart SDK](https://img.shields.io/badge/sdk-%5E3.11.3-blue.svg)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D1.17.0-blue.svg)](https://flutter.dev)

[English](README.md) | **简体中文**

Flutter 常用工具集合，提供字符串处理、日期格式化、Widget 扩展、表单验证、平台检测等功能，帮助开发者提升开发效率。

## 功能特性

- **StringUtils** - 字符串扩展方法（邮箱/手机号验证、格式化、截断等）
- **DateUtils** - 日期时间工具类（格式化、相对时间、日期范围等）
- **WidgetExtensions** - Widget 便捷扩展方法（padding、居中、圆角等）
- **BuildContextExtensions** - BuildContext 扩展（屏幕尺寸、SnackBar、导航等）
- **ValidationUtils** - 表单验证工具类（邮箱、手机号、密码验证等）
- **PlatformUtils** - 平台检测工具类（Android/iOS/Web/Windows/macOS/Linux）
- **ListUtils** - 列表扩展方法（安全访问、分组、分块、统计等）
- **NumUtils** - 数字格式化和操作（货币、百分比、文件大小等）
- **ColorUtils** - 颜色转换和操作（Hex、HSL、明暗调整等）

## 快速开始

### 添加依赖

在 `pubspec.yaml` 文件中添加：

```yaml
dependencies:
  tools_box: ^0.1.3
```

### 导入包

```dart
import 'package:tools_box/tools_box.dart';
```

---

## API 文档

### StringUtils -> [string_utils.dart](lib/src/string_utils.dart) -> [Demo](example/lib/main.dart#L71-L89)

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
'This is a very long string for testing'.truncate(10); // 'This is a ve...'
'  hello world  '.removeWhitespace;  // 'helloworld'
''.nullIfEmpty;                       // null
```

---

### DateUtils -> [date_utils.dart](lib/src/date_utils.dart) -> [Demo](example/lib/main.dart)

```dart
formatDate(DateTime, {pattern})       : 格式化日期（默认 yyyy-MM-dd）
formatDateTime(DateTime, {pattern})   : 格式化日期时间（默认 yyyy-MM-dd HH:mm:ss）
timeAgo(DateTime)                     : 计算相对时间（如：5分钟前、2小时前）
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

// 相对时间
DateUtils.timeAgo(now.subtract(Duration(minutes: 5)));   // '5 minutes ago'
DateUtils.timeAgo(now.subtract(Duration(hours: 2)));     // '2 hours ago'
DateUtils.timeAgo(now.subtract(Duration(days: 1)));      // '1 day ago'

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

### WidgetExtensions -> [widget_extensions.dart](lib/src/widget_extensions.dart#L8-L110) -> [Demo](example/lib/main.dart#L129-L193)

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

### BuildContextExtensions -> [widget_extensions.dart](lib/src/widget_extensions.dart#L112-L139) -> [Demo](example/lib/main.dart#L196-L234)

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

### ValidationUtils -> [validation_utils.dart](lib/src/validation_utils.dart) -> [Demo](example/lib/main.dart#L92-L127)

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

### PlatformUtils -> [platform_utils.dart](lib/src/platform_utils.dart) -> [Demo](example/lib/main.dart)

#### A. 平台判断属性

```dart
isWeb                        : 是否为 Web 平台
isAndroid                    : 是否为 Android 平台
isIOS                        : 是否为 iOS 平台
isMacOS                      : 是否为 macOS 平台
isWindows                    : 是否为 Windows 平台
isLinux                      : 是否为 Linux 平台
isFuchsia                    : 是否为 Fuchsia 平台
isMobile                     : 是否为移动端（Android 或 iOS）
isDesktop                    : 是否为桌面端（macOS、Windows 或 Linux）
```

#### B. 平台信息属性

```dart
platformName                 : 获取平台名称（英文：Web、Android、iOS...）
platformNameCN               : 获取平台名称（中文：网页、安卓、苹果...）
operatingSystem              : 获取操作系统标识符
operatingSystemVersion       : 获取操作系统版本号
currentLocale                : 获取当前系统语言环境
localHostname                : 获取本地主机名
numberOfProcessors            : 获取处理器核心数（Web 端返回 null）
pathSeparator                : 获取路径分隔符（Web 端返回 null）
```

#### C. 运行模式检测

```dart
isRelease                    : 是否为 Release 模式
isDebug                      : 是否为 Debug 模式
```

#### D. 功能支持检测

```dart
supportsFileSystem()          : 是否支持文件系统操作（Web 返回 false）
supportsNetworkSockets()      : 是否支持网络套接字
supportsProcessInfo()         : 是否支持进程信息获取
```

#### E. 平台分支执行

```dart
runOnPlatform({...})          : 根据平台执行不同回调（无返回值）
runOnPlatformWithResult<T>({...}) : 根据平台执行不同回调（有返回值）
```

**使用示例：**

```dart
import 'package:tools_box/tools_box.dart';

// 基础平台判断
if (PlatformUtils.isAndroid) {
  print('运行在 Android 设备上');
} else if (PlatformUtils.isIOS) {
  print('运行在 iOS 设备上');
} else if (PlatformUtils.isWeb) {
  print('运行在浏览器中');
}

// 获取平台信息
print('平台: ${PlatformUtils.platformName}');
print('平台(中文): ${PlatformUtils.platformNameCN}');
print('系统语言: ${PlatformUtils.currentLocale}');

// 移动端/桌面端判断
if (PlatformUtils.isMobile) {
  // 移动端特有逻辑（如触摸手势）
} else if (PlatformUtils.isDesktop) {
  // 桌面端特有逻辑（如键盘快捷键）
}

// 运行模式判断
if (PlatformUtils.isDebug) {
  print('调试模式 - 可输出详细日志');
}

// 平台分支执行
PlatformUtils.runOnPlatform(
  onAndroid: () => print('Android 特有初始化'),
  onIOS: () => print('iOS 特有初始化'),
  onWeb: () => print('Web 特有初始化'),
  onWindows: () => print('Windows 特有初始化'),
  onMacOS: () => print('macOS 特有初始化'),
  onLinux: () => print('Linux 特有初始化'),
  onMobile: () => print('移动端通用逻辑'),
  onDesktop: () => print('桌面端通用逻辑'),
);

// 带返回值的平台分支
final String storagePath = PlatformUtils.runOnPlatformWithResult(
  onWeb: () => 'web_storage',
  onAndroid: () => '/sdcard/data',
  onIOS: () => NSHomeDirectory(),
  onOther: () => './data',
);

// 文件系统支持检测
if (PlatformUtils.supportsFileSystem()) {
  final file = File('${PlatformUtils.pathSeparator}data${PlatformUtils.pathSeparator}config.json');
}
```

**在 UI 中使用示例：**

```dart
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('当前平台: ${PlatformUtils.platformNameCN}'),

      if (PlatformUtils.isMobile)
        ElevatedButton(
          onPressed: () => _handleMobileAction(),
          child: Text('移动端操作'),
        ),

      if (PlatformUtils.isDesktop)
        ElevatedButton(
          onPressed: () => _handleDesktopAction(),
          child: Text('桌面端操作'),
        ),

      if (PlatformUtils.isDebug)
        Text('调试版本', style: TextStyle(color: Colors.orange)),
    ],
  );
}
```

---

### ListUtils -> [list_utils.dart](lib/src/list_utils.dart) -> [Demo](example/lib/main.dart)

#### A. 列表扩展方法

```dart
firstOrDefault([T? defaultValue])              : 获取第一个元素，为空时返回默认值
lastOrDefault([T? defaultValue])               : 获取最后一个元素，为空时返回默认值
unique()                                       : 去重，返回唯一元素列表
chunked(int size)                              : 将列表按指定大小分块
groupBy<K>(K Function(T) key)                  : 按指定键分组
skipFirst(int count)                           : 跳过前 N 个元素
skipLast(int count)                            : 跳过后 N 个元素
getOrNull(int index)                           : 安全获取元素（索引越界返回 null）
findFirst(bool Function(T) test)               : 查找第一个满足条件的元素
findLast(bool Function(T) test)                : 查找最后一个满足条件的元素
swap(int index1, int index2)                   : 交换两个位置的元素
cyclic(int index)                              : 循环访问（索引超出范围时从头开始）
```

#### B. 数字列表统计方法 (NumericListUtils)

```dart
sum({num Function(T)? selector})               : 求和（支持选择器）
average({num Function(T)? selector})           : 求平均值
min({num Function(T)? selector})               : 求最小值
max({num Function(T)? selector})               : 求最大值
median({num Function(T)? selector})            : 求中位数
```

**使用示例：**

```dart
import 'package:tools_box/tools_box.dart';

// 基础列表操作
final list = [1, 2, 3, 4, 5];

// 安全访问元素
list.firstOrDefault;                    // 1
[].firstOrDefault(0);                   // 0（空列表返回默认值）
list.lastOrDefault;                     // 5
list.getOrNull(10);                     // null（索引越界）

// 列表变换
[1, 2, 2, 3, 3, 3].unique();           // [1, 2, 3]
[1, 2, 3, 4, 5, 6].chunked(2);         // [[1, 2], [3, 4], [5, 6]]
[1, 2, 3, 4, 5].skipFirst(2);          // [3, 4, 5]
[1, 2, 3, 4, 5].skipLast(2);           // [1, 2, 3]

// 查找与交换
list.findFirst((e) => e > 3);           // 4
list.findLast((e) => e < 4);            // 3
list.swap(0, 4);                        // [5, 2, 3, 4, 1]
list.cyclic(7);                         // 3（循环访问：7 % 5 = 2 -> 索引2的元素是3？不对，应该是循环访问第7个位置）
                                      // 实际上 7 % 5 = 2，所以返回 list[2] = 3

// 分组操作
final users = [
  {'name': '张三', 'dept': '技术部'},
  {'name': '李四', 'dept': '市场部'},
  {'name': '王五', 'dept': '技术部'},
];
users.groupBy((u) => u['dept']);
// {'技术部': [张三, 王五], '市场部': [李四]}

// 数字列表统计
final numbers = [10, 20, 30, 40, 50];
numbers.sum();                          // 150
numbers.average();                      // 30.0
numbers.min();                          // 10
numbers.max();                          // 50
numbers.median();                       // 30

// 使用选择器对对象列表进行统计
final products = [
  {'name': '苹果', 'price': 5.0},
  {'name': '香蕉', 'price': 3.0},
  {'name': '橙子', 'price': 4.0},
];
products.sum(selector: (p) => p['price']);    // 12.0
products.average(selector: (p) => p['price']); // 4.0
products.min(selector: (p) => p['price']);     // 3.0
products.max(selector: (p) => p['price']);     // 5.0
```

---

### NumUtils -> [num_utils.dart](lib/src/num_utils.dart) -> [Demo](example/lib/main.dart)

#### A. 数字格式化方法

```dart
formatWithCommas()                        : 添加千位分隔符
toCurrency({String symbol, int decimals}) : 转换为货币格式
toPercentage({int decimals})              : 转换为百分比格式
toDurationString()                        : 转换为时长字符串（秒 -> 时:分:秒）
toFileSize({int decimals})                : 转换为文件大小字符串（字节 -> KB/MB/GB）
roundTo(int decimalPlaces)                : 四舍五入到指定小数位
```

#### B. 数值判断方法

```dart
clampRange(num min, num max)             : 限制数值在指定范围内
isBetween(num min, num max)               : 判断是否在范围内（包含边界）
isWithin(num min, num max)                : 判断是否在范围内（不包含边界）
isPositive                                 : 是否为正数
isNegative                                 : 是否为负数
isZero                                     : 是否为零
isEven                                      : 是否为偶数
isOdd                                       : 是否为奇数
```

**使用示例：**

```dart
import 'package:tools_box/tools_box.dart';

// 格式化数字
1234567.formatWithCommas();              // '1,234,567'
99.99.toCurrency();                       // '¥99.99'
99.99.toCurrency(symbol: '\$', decimals: 0); // '\$100'
0.856.toPercentage();                     // '85.60%'
0.333.toPercentage(decimals: 1);          // '33.3%'

// 时长和文件大小转换
3661.toDurationString();                  // '01:01:01'（1小时1分1秒）
(1024 * 1024 * 3.5).toFileSize();         // '3.50 MB'
(1024 * 1024 * 1024 * 2.75).toFileSize(decimals: 1); // '2.8 GB'

// 四舍五入
3.14159.roundTo(2);                       // 3.14
2.71828.roundTo(3);                       // 2.718

// 范围判断和限制
5.clampRange(1, 10);                      // 5（在范围内）
15.clampRange(1, 10);                     // 10（超出上限，返回最大值）
-5.clampRange(1, 10);                     // 1（低于下限，返回最小值）
5.isBetween(1, 10);                       // true
5.isWithin(1, 10);                        // true
10.isWithin(1, 10);                       // false（不包含边界）

// 正负零判断
42.isPositive;                            // true
-7.isNegative;                            // true
0.isZero;                                 // true
4.isEven;                                 // true
3.isOdd;                                  // true
```

---

### ColorUtils -> [color_utils.dart](lib/src/color_utils.dart) -> [Demo](example/lib/main.dart)

#### A. 颜色创建与转换

```dart
fromHex(String hexString)                : 从十六进制字符串创建颜色
toHex({bool includeAlpha})               : 转换为十六进制字符串
fromHSL(double h, double s, double l)    : 从 HSL 值创建颜色
toHSL()                                   : 转换为 HSL 值（返回 HSLColor）
random()                                   : 生成随机颜色
```

#### B. 颜色调整方法

```dart
lighten([double amount])                  : 提亮颜色（默认 0.1）
darken([double amount])                   : 加深颜色（默认 0.1）
mix(Color other, [double weight])         : 混合两种颜色
withOpacity(double opacity)               : 设置透明度
```

#### C. 颜色信息获取

```dart
getRed                                    : 获取红色分量 (0-255)
getGreen                                  : 获取绿色分量 (0-255)
getBlue                                   : 获取蓝色分量 (0-255)
getAlpha                                  : 获取透明度分量 (0-255)
isDark                                     : 判断是否为深色
isLight                                    : 判断是否为浅色
contrastingText()                         : 获取对比文字颜色（黑/白）
```

**使用示例：**

```dart
import 'package:flutter/material.dart';
import 'package:tools_box/tools_box.dart';

// Hex 颜色转换
final color1 = ColorUtils.fromHex('#FF5722');        // 橙红色
final color2 = ColorUtils.fromHex('3498DB');          // 蓝色（可省略 #）
final color3 = ColorUtils.fromHex('80000000');        // 半透明黑色
color1.toHex();                                       // '#FF5722'
color3.toHex(includeAlpha: true);                     // '#80000000'

// HSL 转换
final hslColor = ColorUtils.fromHSL(210, 0.5, 0.6);  // 创建 HSL 颜色
final hsl = Colors.blue.toHSL();                      // 转换为 HSL
print('色相: ${hsl.hue}, 饱和度: ${hsl.saturation}, 亮度: ${hsl.lightness}');

// 颜色调整
final baseColor = Colors.blue;
baseColor.lighten();                                   // 提亮 10%
baseColor.lighten(0.3);                                // 提亮 30%
baseColor.darken();                                     // 加深 10%
baseColor.darken(0.2);                                  // 加深 20%
Colors.red.mix(Colors.blue, 0.5);                      // 混合红蓝两色
Colors.blue.withOpacity(0.5);                           // 50% 透明度的蓝色

// 颜色信息
final myColor = Color(0xFF2196F3);
myColor.getRed;                                        // 33 (0x21)
myColor.getGreen;                                      // 150 (0x96)
myColor.getBlue;                                       // 243 (0xF3)
myColor.getAlpha;                                      // 255 (完全不透明)

// 明暗判断与对比文字
Colors.black.isDark;                                   // true
Colors.white.isLight;                                  // true
Colors.blue.isDark;                                    // 取决于亮度阈值
Colors.blue.contrastingText();                         // 返回白色文字（蓝色背景上更清晰）
Colors.yellow.contrastingText();                       // 返回黑色文字（黄色背景上更清晰）

// 随机颜色生成
final randomColor = ColorUtils.random();               // 生成随机颜色

// 在 UI 中使用
Container(
  color: ColorUtils.fromHex('#E3F2FD'),
  child: Text(
    'Hello',
    style: TextStyle(
      color: ColorUtils.fromHex('#E3F2FD').contrastingText(),
    ),
  ),
)
```

---

## 示例应用

查看 `example` 目录获取完整的使用示例：

```bash
cd example
flutter run
```

示例应用展示了所有功能模块的实际使用效果。

## 开发指南

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

## 测试覆盖

当前版本包含 **17 个单元测试**，覆盖所有核心功能模块：

- StringUtils 测试用例（5 个）
- DateUtils 测试用例（3 个）
- ValidationUtils 测试用例（3 个）
- PlatformUtils 测试用例（6 个）

运行 `flutter test` 查看详细测试结果。

## 贡献指南

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

## 变更日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新历史。

## 许可证

本项目基于 [MIT License](LICENSE) 开源。

## 致谢

感谢所有贡献者和 Flutter 社区！

## 联系方式

- 问题反馈：[GitHub Issues](https://github.com/dxmwl/tools_box/issues)
- 功能建议：[GitHub Discussions](https://github.com/dxmwl/tools_box/discussions)

---

**让 Flutter 开发更简单高效！**
