// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// Extension methods on [Widget] for common widget composition patterns.
///
/// This extension provides a fluent API for wrapping widgets with common
/// container and gesture widgets, making code more readable and concise.
///
/// Instead of writing:
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(16),
///   child: MyWidget(),
/// )
/// ```
///
/// You can write:
/// ```dart
/// MyWidget().paddingAll(16)
/// ```
///
/// All methods return new widget instances, leaving the original unchanged.
extension WidgetExtensions on Widget {
  /// Wraps this widget with [Padding] applying equal padding on all sides.
  ///
  /// Parameters:
  /// - [value]: The padding value to apply on all sides
  ///
  /// Returns a [Padding] widget with the specified padding.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').paddingAll(16.0)
  /// // Equivalent to Padding(padding: EdgeInsets.all(16), child: Text('Hello'))
  /// ```
  Padding paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  /// Wraps this widget with [Padding] applying horizontal and/or vertical padding.
  ///
  /// Parameters:
  /// - [horizontal]: Horizontal padding (left and right), default 0
  /// - [vertical]: Vertical padding (top and bottom), default 0
  ///
  /// Returns a [Padding] widget with symmetric padding.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').paddingSymmetric(horizontal: 16, vertical: 8)
  /// ```
  Padding paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Wraps this widget with [Padding] applying different padding per side.
  ///
  /// Parameters:
  /// - [left]: Left padding, default 0
  /// - [top]: Top padding, default 0
  /// - [right]: Right padding, default 0
  /// - [bottom]: Bottom padding, default 0
  ///
  /// Returns a [Padding] widget with custom padding on each side.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').only(left: 16, top: 8)
  /// ```
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

  /// Wraps this widget with [Center] to center it within its parent.
  ///
  /// Returns a [Center] widget containing this widget.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').center()
  /// ```
  Center center() => Center(child: this);

  /// Wraps this widget with [Align] using the specified [alignment].
  ///
  /// Parameters:
  /// - [alignment]: The alignment position (default: center)
  ///
  /// Returns an [Align] widget with the specified alignment.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').align(alignment: Alignment.topLeft)
  /// ```
  Align align({Alignment alignment = Alignment.center}) {
    return Align(alignment: alignment, child: this);
  }

  /// Wraps this widget with [Expanded] to fill available space.
  ///
  /// Parameters:
  /// - [flex]: The flex factor (default: 1)
  ///
  /// Returns an [Expanded] widget containing this widget.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [
  ///   Text('A').expand(flex: 2),
  ///   Text('B').expand(),
  /// ])
  /// ```
  Expanded expand({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Wraps this widget with [Flexible] for flexible sizing.
  ///
  /// Parameters:
  /// - [flex]: The flex factor (default: 1)
  /// - [fit]: How the flexible child should fit (default: loose)
  ///
  /// Returns a [Flexible] widget containing this widget.
  ///
  /// Example:
  /// ```dart
  /// Row(children: [
  ///   Text('A').flexible(flex: 2, fit: FlexFit.tight),
  /// ])
  /// ```
  Flexible flexible({int flex = 1, FlexFit fit = FlexFit.loose}) {
    return Flexible(flex: flex, fit: fit, child: this);
  }

  /// Wraps this widget with [Positioned] for use in Stack layouts.
  ///
  /// Parameters:
  /// - [left]: Distance from left edge (optional)
  /// - [top]: Distance from top edge (optional)
  /// - [right]: Distance from right edge (optional)
  /// - [bottom]: Distance from bottom edge (optional)
  ///
  /// Returns a [Positioned] widget (must be used inside a Stack).
  ///
  /// Example:
  /// ```dart
  /// Stack(children: [
  ///   Container(color: Colors.red).positioned(top: 10, left: 10),
  /// ])
  /// ```
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

  /// Wraps this widget with [GestureDetector] to add tap handling.
  ///
  /// Parameters:
  /// - [onTap]: Callback function when the widget is tapped
  ///
  /// Returns a [GestureDetector] widget with tap detection.
  ///
  /// Example:
  /// ```dart
  /// Text('Click me').onTap(() => print('Tapped!'))
  /// ```
  GestureDetector onTap(VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }

  /// Wraps this widget with [SizedBox] to constrain its size.
  ///
  /// Parameters:
  /// - [width]: Optional width constraint
  /// - [height]: Optional height constraint
  ///
  /// Returns a [SizedBox] widget with the specified dimensions.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').sizedBox(width: 200, height: 100)
  /// // Or just set one dimension:
  /// Text('Hello').sizedBox(height: 50)
  /// ```
  SizedBox sizedBox({double? width, double? height}) {
    return SizedBox(width: width, height: height, child: this);
  }

  /// Wraps this widget with [ClipRRect] for rounded corner clipping.
  ///
  /// Parameters:
  /// - [radius]: The border radius (default: 8)
  ///
  /// Returns a [ClipRRect] widget that clips content to a rounded rectangle.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('photo.jpg').clipRRect(radius: 16)
  /// ```
  ClipRRect clipRRect({double radius = 8}) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Wraps this widget with [DecoratedBox] to apply decoration.
  ///
  /// Parameters:
  /// - [decoration]: The decoration to apply (required)
  /// - [position]: Decoration position (default: background)
  ///
  /// Returns a [DecoratedBox] widget with the specified decoration.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').decorated(
  ///   decoration: BoxDecoration(
  ///     color: Colors.blue,
  ///     borderRadius: BorderRadius.circular(8),
  ///   ),
  /// )
  /// ```
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

  /// Wraps this widget with [Opacity] to control transparency.
  ///
  /// Parameters:
  /// - [opacity]: Opacity value from 0.0 (invisible) to 1.0 (fully visible)
  ///
  /// Returns an [Opacity] widget with the specified opacity level.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').opacity(0.5) // 50% transparent
  /// ```
  Opacity opacity(double opacity) {
    return Opacity(opacity: opacity, child: this);
  }

  /// Wraps this widget with [SafeArea] to avoid system UI overlaps.
  ///
  /// Parameters:
  /// - [top]: Whether to apply top safe area (default: true)
  /// - [bottom]: Whether to apply bottom safe area (default: true)
  ///
  /// Returns a [SafeArea] widget that avoids notches, status bars, etc.
  ///
  /// Example:
  /// ```dart
  /// Column(children: [
  ///   Text('Content').safeArea(top: true, bottom: true),
  /// ])
  /// ```
  SafeArea safeArea({bool top = true, bool bottom = true}) {
    return SafeArea(top: top, bottom: bottom, child: this);
  }

  /// Wraps this widget with [Hero] for animated transitions.
  ///
  /// Parameters:
  /// - [tag]: A unique identifier for this hero animation
  ///
  /// Returns a [Hero] widget for shared element transitions.
  ///
  /// Example:
  /// ```dart
  /// Image.asset('photo.jpg').hero('detail-image')
  /// ```
  Hero hero(Object tag) {
    return Hero(tag: tag, child: this);
  }

  /// Wraps this widget with [Tooltip] to show help text on long press.
  ///
  /// Parameters:
  /// - [message]: The tooltip message text
  ///
  /// Returns a [Tooltip] widget that displays the message on long press.
  ///
  /// Example:
  /// ```dart
  /// Icon(Icons.help).tooltip('Click for help')
  /// ```
  Tooltip tooltip(String message) {
    return Tooltip(message: message, child: this);
  }

  /// Controls widget visibility without removing it from the tree.
  ///
  /// Parameters:
  /// - [visible]: Whether to show or hide the widget
  /// - [replacement]: Widget to display when hidden (default: empty SizedBox)
  ///
  /// Returns a [Visibility] widget that conditionally shows/hides content.
  ///
  /// Example:
  /// ```dart
  /// Text('Secret message').visible(showSecret, replacement: Text('***'))
  /// ```
  Visibility visible(bool visible, {Widget? replacement}) {
    return Visibility(
      visible: visible,
      replacement: replacement ?? SizedBox(),
      child: this,
    );
  }
}

/// Extension methods on [BuildContext] for accessing common Flutter properties.
///
/// Provides convenient accessors for:
/// - Screen dimensions
/// - Theme data (theme, textTheme, colorScheme)
/// - Keyboard state
/// - Navigation helpers
/// - Dark mode detection
///
/// Example usage:
/// ```dart
/// build(BuildContext context) {
///   final width = context.screenWidth;
///   final isDark = context.isDarkMode;
///
///   return Scaffold(
///     body: Center(child: Text('Width: $width')),
///   );
/// }
/// ```
extension BuildContextExtensions on BuildContext {
  /// Gets the screen width from [MediaQuery].
  ///
  /// Returns the logical pixel width of the screen.
  ///
  /// Example:
  /// ```dart
  /// final width = context.screenWidth;
  /// print('Screen width: $width pixels');
  /// ```
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Gets the screen height from [MediaQuery].
  ///
  /// Returns the logical pixel height of the screen.
  ///
  /// Example:
  /// ```dart
  /// final height = context.screenHeight;
  /// print('Screen height: $height pixels');
  /// ```
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Gets the [ThemeData] for this context's widget subtree.
  ///
  /// Returns the nearest [ThemeData] ancestor's data.
  ///
  /// Example:
  /// ```dart
  /// final theme = context.theme;
  /// print(theme.primaryColor);
  /// ```
  ThemeData get theme => Theme.of(this);

  /// Gets the [TextTheme] from the current theme.
  ///
  /// Returns the [TextTheme] containing text style definitions.
  ///
  /// Example:
  /// ```dart
  /// final textStyle = context.textTheme.headline6;
  /// Text('Title', style: textStyle)
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Gets the [ColorScheme] from the current theme.
  ///
  /// Returns the [ColorScheme] defining the app's color palette.
  ///
  /// Example:
  /// ```dart
  /// final colors = context.colorScheme;
  /// Container(color: colors.primary)
  /// ```
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Checks if the software keyboard is currently visible.
  ///
  /// Returns `true` if the keyboard is showing, `false` otherwise.
  ///
  /// Uses `MediaQuery.viewInsets.bottom` to detect keyboard presence.
  ///
  /// Example:
  /// ```dart
  /// if (context.isKeyboardVisible) {
  ///   context.hideKeyboard();
  /// }
  /// ```
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Dismisses the software keyboard by unfocusing the current focus node.
  ///
  /// A convenience method to hide the keyboard without needing to
  /// manually manage FocusNode instances.
  ///
  /// Example:
  /// ```dart
  /// ElevatedButton(
  ///   onPressed: () => context.hideKeyboard(),
  ///   child: Text('Hide Keyboard'),
  /// )
  /// ```
  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// Displays a [SnackBar] with the specified [message].
  ///
  /// A shorthand method for showing snackbars without needing to
  /// access ScaffoldMessenger directly.
  ///
  /// Parameters:
  /// - [message]: The text to display in the SnackBar
  ///
  /// Example:
  /// ```dart
  /// context.showSnackBar('Operation completed successfully');
  /// ```
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Navigates to a new route by pushing onto the navigation stack.
  ///
  /// A simplified push method that automatically wraps the builder
  /// in a [MaterialPageRoute].
  ///
  /// Type parameter [T] specifies the optional return type from the pushed page.
  ///
  /// Parameters:
  /// - [builder]: Function that builds the route's widget
  ///
  /// Returns a Future that completes with the result when the route is popped.
  ///
  /// Example:
  /// ```dart
  /// context.push((context) => DetailPage());
  /// // Or with return value:
  /// final result = await context.push<String>((context) => SelectionPage());
  /// ```
  Future<T?> push<T>(WidgetBuilder builder) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: builder));
  }

  /// Pops the current route from the navigation stack with an optional result.
  ///
  /// Type parameter [T] specifies the type of the optional return value.
  ///
  /// Parameters:
  /// - [result]: Optional data to return to the previous page
  ///
  /// Example:
  /// ```dart
  /// context.pop(); // Just go back
  /// context.pop('selected_value'); // Go back with data
  /// ```
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  /// Checks if the app is currently in dark mode.
  ///
  /// Determines dark mode by checking the theme's brightness setting.
  ///
  /// Returns `true` if the theme brightness is dark, `false` for light mode.
  ///
  /// Example:
  /// ```dart
  /// final iconColor = context.isDarkMode ? Colors.white : Colors.black;
  /// Icon(Icons.star, color: iconColor)
  /// ```
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
