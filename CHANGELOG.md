# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-01-15

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
| 0.1.0 | 2024-01-15 | 初始版本发布，包含基础工具集合 |

