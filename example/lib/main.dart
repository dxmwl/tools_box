import 'package:flutter/material.dart';
import 'package:tools_box/tools_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tools Box Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tools Box 工具包演示'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('1. 字符串工具 (StringUtils)'),
            _buildStringUtilsDemo(),
            const SizedBox(height: 24),

            _buildSectionTitle('2. 验证工具 (ValidationUtils)'),
            _buildValidationDemo(),
            const SizedBox(height: 24),

            _buildSectionTitle('3. Widget扩展方法'),
            _buildWidgetExtensionsDemo(),
            const SizedBox(height: 24),

            _buildSectionTitle('4. BuildContext扩展'),
            _BuildContextExtensionsDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ).paddingSymmetric(vertical: 8);
  }

  Widget _buildStringUtilsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('邮箱验证', 'test@example.com'.isEmail.toString()),
            _buildInfoRow('手机号验证', '13812345678'.isPhoneNumber.toString()),
            _buildInfoRow('首字母大写', 'hello world'.capitalize),
            _buildInfoRow('每个单词大写', 'hello world'.capitalizeAllOf),
            _buildInfoRow('是否为数字', '12345'.isNumeric.toString()),
            _buildInfoRow('字符串反转', 'flutter'.reverse),
            _buildInfoRow('截断字符串', '这是一个很长的字符串用于测试截断功能'.truncate(10)),
            _buildInfoRow('URL验证', 'https://example.com'.isURL.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
              '验证邮箱',
              ValidationUtils.isValidEmail('test@example.com').toString(),
            ),
            _buildInfoRow(
              '验证手机号',
              ValidationUtils.isValidPhone('13812345678').toString(),
            ),
            _buildInfoRow(
              '验证密码',
              ValidationUtils.isValidPassword('123456').toString(),
            ),
            _buildInfoRow(
              '表单-有效邮箱',
              ValidationUtils.validateEmail('test@example.com') ?? '✅ 通过',
            ),
            _buildInfoRow(
              '表单-无效邮箱',
              ValidationUtils.validateEmail('invalid') ?? '❌ 未通过',
            ),
            _buildInfoRow(
              '表单-必填字段',
              ValidationUtils.validateRequired('', fieldName: '用户名') ?? '✅ 通过',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetExtensionsDemo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('下面展示了各种Widget扩展方法的实际效果：'),
            const SizedBox(height: 16),

            // 演示padding扩展
            Text('paddingAll(16)')
                .paddingAll(16)
                .decorated(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                ),

            const SizedBox(height: 12),

            // 演示center扩展
            Text('居中显示')
                .center()
                .sizedBox(height: 50)
                .decorated(
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                ),

            const SizedBox(height: 12),

            // 演示onTap扩展
            Text('点击我（有点击事件）')
                .align(alignment: Alignment.centerLeft)
                .paddingAll(12)
                .onTap(() {
                  // 点击事件
                })
                .decorated(
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                ),

            const SizedBox(height: 12),

            // 演示opacity和clipRRect
            Text('圆角 + 半透明')
                .center()
                .paddingAll(16)
                .opacity(0.7)
                .clipRRect(radius: 12)
                .decorated(decoration: BoxDecoration(color: Colors.purple)),
          ],
        ),
      ),
    );
  }

  Widget _BuildContextExtensionsDemo() {
    return Builder(
      builder: (context) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  '屏幕宽度',
                  '${context.screenWidth.toStringAsFixed(0)} px',
                ),
                _buildInfoRow(
                  '屏幕高度',
                  '${context.screenHeight.toStringAsFixed(0)} px',
                ),
                _buildInfoRow('是否暗色模式', context.isDarkMode.toString()),
                _buildInfoRow('键盘是否可见', context.isKeyboardVisible.toString()),

                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: () => context.showSnackBar('这是SnackBar提示！'),
                  child: const Text('显示SnackBar'),
                ),

                const SizedBox(height: 8),

                ElevatedButton(
                  onPressed: () => context.hideKeyboard(),
                  child: const Text('隐藏键盘'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.grey[700],
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
