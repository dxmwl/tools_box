# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2026-05-25

### 🎉 Added - 新增功能

#### PlatformUtils（平台检测工具）
- ✨ `isWeb` - 是否为 Web 平台
- ✨ `isAndroid` - 是否为 Android 平台
- ✨ `isIOS` - 是否为 iOS 平台
- ✨ `isMacOS` - 是否为 macOS 平台
- ✨ `isWindows` - 是否为 Windows 平台
- ✨ `isLinux` - 是否为 Linux 平台
- ✨ `isFuchsia` - 是否为 Fuchsia 平台
- ✨ `isMobile` - 是否为移动端（Android 或 iOS）
- ✨ `isDesktop` - 是否为桌面端（macOS、Windows 或 Linux）
- ✨ `platformName` - 获取平台名称（英文）
- ✨ `platformNameCN` - 获取平台名称（中文）
- ✨ `operatingSystem` - 获取操作系统标识符
- ✨ `operatingSystemVersion` - 获取操作系统版本号
- ✨ `currentLocale` - 获取当前系统语言环境
- ✨ `localHostname` - 获取本地主机名
- ✨ `numberOfProcessors` - 获取处理器核心数
- ✨ `pathSeparator` - 获取路径分隔符
- ✨ `isRelease` / `isDebug` - 运行模式检测
- ✨ `supportsFileSystem()` - 文件系统支持检测
- ✨ `supportsNetworkSockets()` - 网络套接字支持检测
- ✨ `supportsProcessInfo()` - 进程信息支持检测
- ✨ `runOnPlatform({...})` - 根据平台执行不同回调（无返回值）
- ✨ `runOnPlatformWithResult<T>({...})` - 根据平台执行不同回调（有返回值）

### 📝 Documentation（文档）
- 更新 README.md 添加 PlatformUtils API 文档
- 更新 Features 列表，新增平台检测功能介绍

### 🧪 Testing（测试）
- 新增 PlatformUtils 测试用例（6 个测试）
- 覆盖平台判断、名称获取、分支执行等功能

---

## [0.1.1] - 2026-05-23

### 🎉 Changed - 变更优化

#### 项目结构优化
- 🔄 将 `example_app` 目录重命名为 `example`（符合 Flutter 包命名规范）
- ➕ 新增 `.pubignore` 文件（优化 pub.dev 发布配置）
- 🔧 更新 `.gitignore` 中的路径引用
- 🔗 更新所有文档中的引用路径（README.md、CODE_WIKI.md）

#### 文档改进
- 📝 **重新整理 README.md**：采用清晰的 API 列表格式
  - 每个模块显示源文件链接和 Demo 链接
  - 使用代码块对齐展示方法名和中文描述
  - 提升可读性和查找效率
- 📚 更新 CODE_WIKI.md 中的目录引用
- ✏️ 更新 CHANGELOG.md 中的示例应用名称

#### 包发布配置
- ✅ 解决 Pub 验证警告："checked-in files are ignored by .gitignore"
- ✅ 添加 .pubignore 排除 example 目录（不应发布到 pub.dev）
- ✅ 优化包结构，遵循 Flutter 包最佳实践

### 📦 Dependencies（依赖）
- 无新增依赖

---

## [0.1.0] - 2026-05-23

### 🎉 Added - 新增功能

#### StringUtils（字符串工具）
- ✨ `isEmail` - 邮箱格式验证
- ✨ `isPhoneNumber` - 中国手机号验证
- ✨ `capitalize` - 首字母大写
- ✨ `capitalizeAllOf` - 每个单词首字母大写
- ✨ `isNumeric` - 判断是否为数字字符串
- ✨ `reverse` - 字符串反转
- ✨ `nullIfEmpty` - 空字符串转 null
- ✨ `truncate` - 字符串截断（支持自定义后缀）
- ✨ `removeWhitespace` - 移除所有空白字符
- ✨ `isURL` - URL 格式验证

#### DateUtils（日期时间工具）
- ✨ `formatDate` - 日期格式化（支持自定义格式）
- ✨ `formatDateTime` - 日期时间格式化
- ✨ `timeAgo` - 相对时间显示（中文，如：5分钟前、2小时前）
- ✨ `isToday` - 判断是否为今天
- ✨ `isYesterday` - 判断是否为昨天
- ✨ `startOfDay` - 获取一天的开始时间
- ✨ `endOfDay` - 获取一天的结束时间
- ✨ `daysInRange` - 生成指定范围内的日期列表

#### WidgetExtensions（Widget 扩展方法）
- ✨ `paddingAll` - 四周等距 padding
- ✨ `paddingSymmetric` - 水平/垂直 padding
- ✨ `only` - 自定义方向 padding
- ✨ `center` - 居中对齐
- ✨ `align` - 自定义对齐方式
- ✨ `expand` - Expanded 包裹
- ✨ `flexible` - Flexible 包裹
- ✨ `positioned` - 绝对定位
- ✨ `onTap` - 添加点击事件
- ✨ `sizedBox` - 设置尺寸
- ✨ `clipRRect` - 圆角裁剪
- ✨ `decorated` - 添加装饰（背景、边框等）
- ✨ `opacity` - 设置透明度
- ✨ `safeArea` - 安全区域包裹
- ✨ `hero` - Hero 动画标签
- ✨ `tooltip` - 提示信息
- ✨ `visible` - 控制显隐

#### BuildContextExtensions（BuildContext 扩展）
- ✨ `screenWidth` - 获取屏幕宽度
- ✨ `screenHeight` - 获取屏幕高度
- ✨ `theme` - 获取 ThemeData
- ✨ `textTheme` - 获取 TextTheme
- ✨ `colorScheme` - 获取 ColorScheme
- ✨ `isKeyboardVisible` - 判断键盘是否可见
- ✨ `hideKeyboard` - 隐藏键盘
- ✨ `showSnackBar` - 显示 SnackBar
- ✨ `push` - 页面跳转（导航）
- ✨ `pop` - 页面返回
- ✨ `isDarkMode` - 判断暗色模式

#### ValidationUtils（表单验证工具）
- ✨ `isValidEmail` - 邮箱有效性验证
- ✨ `isValidPhone` - 手机号有效性验证
- ✨ `isValidPassword` - 密码有效性验证（支持最小长度）
- ✨ `isValidURL` - URL 有效性验证
- ✨ `isValidIDCard` - 身份证号验证
- ✨ `isChinese` - 中文字符检测
- ✨ `containsOnlyNumbers` - 纯数字检测
- ✨ `containsOnlyLetters` - 纯字母检测
- ✨ `containsOnlyLettersAndNumbers` - 字母数字检测
- ✨ `validateEmail` - 表单邮箱验证（返回错误消息或 null）
- ✨ `validatePhone` - 表单手机号验证
- ✨ `validatePassword` - 表单密码验证
- ✨ `validateRequired` - 必填字段验证

### 📦 Dependencies（依赖）
- 添加 `intl: ^0.19.0` 用于日期格式化

### 🧪 Testing（测试）
- 添加 11 个单元测试用例
- 覆盖 StringUtils、DateUtils、ValidationUtils 核心功能
- 所有测试通过 ✅

### 📚 Documentation（文档）
- 完整的 README.md 文档
- 详细的使用示例和 API 文档
- 开发指南和贡献指南
- 创建示例应用 (example)

### 🔧 Project Setup（项目配置）
- 更新 pubspec.yaml 配置
- 设置版本号为 0.1.0
- 添加仓库地址和问题追踪链接
- 配置 Dart SDK 版本要求 ^3.11.3

---

## [Unreleased]

### 🔄 计划中的功能
- [ ] ListUtils - 列表操作工具
- [ ] NumUtils - 数字处理工具
- [ ] ColorUtils - 颜色转换工具
- [ ] CacheUtils - 缓存管理工具
- [ ] SharedPreferences 工具封装
- [ ] 网络请求工具封装
- [ ] 更多 Widget 扩展方法
- [ ] 国际化支持（i18n）

---

## 版本说明

### 版本号规则
- **Major (X.0.0)**: 不兼容的 API 变更
- **Minor (0.X.0)**: 向后兼容的功能新增
- **Patch (0.0.X):** 向后兼容的问题修复

### 更新类型标记
- **Added**: 新功能
- **Changed**: 现有功能的变更
- **Deprecated**: 即将移除的功能
- **Removed**: 已移除的功能
- **Fixed**: Bug 修复
- **Security**: 安全性修复

---

## 发布记录

| 版本 | 日期 | 说明 |
|------|------|------|
| 0.1.2 | 2024-01-17 | 新增 PlatformUtils 平台检测工具 |
| 0.1.1 | 2026-05-23 | 项目结构优化、文档改进、包发布配置优化 |
| 0.1.0 | 2024-01-15 | 初始版本发布，包含基础工具集合 |

