import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension WidgetExtensions on Widget {
  Padding paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Padding paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Padding only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Center center() => Center(child: this);

  Align align({Alignment alignment = Alignment.center}) {
    return Align(alignment: alignment, child: this);
  }

  Expanded expand({int flex = 1}) => Expanded(flex: flex, child: this);

  Flexible flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }

  Positioned positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  GestureDetector onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  SizedBox sizedBox({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  ClipRRect clipRRect({double radius = 8}) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  DecoratedBox decorated({
    required BoxDecoration decoration,
    DecorationPosition position = DecorationPosition.background,
  }) {
    return DecoratedBox(
      decoration: decoration,
      position: position,
      child: this,
    );
  }

  Opacity opacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  SafeArea safeArea({bool top = true, bool bottom = true}) {
    return SafeArea(top: top, bottom: bottom, child: this);
  }

  Hero hero(Object tag) {
    return Hero(tag: tag, child: this);
  }

  Tooltip tooltip(String message) {
    return Tooltip(message: message, child: this);
  }

  Visibility visible(bool visible, {Widget? replacement}) {
    return Visibility(
      visible: visible,
      child: this,
      replacement: replacement ?? SizedBox(),
    );
  }
}

extension BuildContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  void hideKeyboard() => FocusScope.of(this).unfocus();

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<T?> push<T>(WidgetBuilder builder) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: builder));
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
