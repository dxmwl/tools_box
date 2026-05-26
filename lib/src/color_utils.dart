// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:ui' show Color;

/// Utility class for color manipulation and conversion operations.
///
/// Provides static methods for:
/// - Hex string to Color conversion
/// - Color to hex string conversion
/// - Color lightening and darkening
/// - Color blending and mixing
/// - Color opacity adjustments
/// - Color component extraction (RGB, HSL)
///
/// This class is designed to simplify common color operations in Flutter apps,
/// making it easier to work with colors from design specifications, APIs, or user input.
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   // Parse hex color
///   final color = ColorUtils.fromHex('#FF5733');
///
///   // Convert to hex
///   print(color.toHex()); // '#FF5733'
///
///   // Lighten or darken
///   final lighter = color.lighten(0.2);
///   final darker = color.darken(0.1);
///
///   // Mix two colors
///   final blend = ColorUtils.mix(Colors.red, Colors.blue, 0.5);
/// }
/// ```
class ColorUtils {
  /// Parses a hexadecimal color string into a [Color] object.
  ///
  /// Supports various formats:
  /// - With or without '#' prefix
  /// - 6-digit (RRGGBB) or 8-digit (RRGGBBAA) format
  /// - 3-digit shorthand (RGB) expanded to 6 digits
  ///
  /// Parameters:
  /// - [hexString]: The hex color string (e.g., '#FF5733', 'FF5733', '#F53')
  ///
  /// Returns a [Color] object parsed from the hex string.
  ///
  /// Throws [FormatException] if the string is not valid hex format.
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.fromHex('#FF5733'); // Color(0xFFFF5733)
  /// ColorUtils.fromHex('FF5733'); // Color(0xFFFF5733)
  /// ColorUtils.fromHex('#F53'); // Color(0xFFFF5533)
  /// ColorUtils.fromHex('#000000'); // Colors.black
  /// ColorUtils.fromHex('#FFFFFFFF'); // Colors.white with full opacity
  /// ```
  static Color fromHex(String hexString) {
    String hex = hexString.replaceAll('#', '');
    
    if (hex.length == 3) {
      hex = hex.split('').map((char) => char + char).join();
    }
    
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    
    return Color(int.parse(hex, radix: 16));
  }

  /// Converts a [Color] object to a hexadecimal string representation.
  ///
  /// Parameters:
  /// - [color]: The color to convert
  /// - [includeAlpha]: Whether to include alpha channel (default: true)
  /// - [includeHash]: Whether to include '#' prefix (default: true)
  ///
  /// Returns a hex string like '#FF5733' or 'FF5733FF'.
  ///
  /// Example:
  /// ```dart
  /// Color(0xFFFF5733).toHex(); // '#FF5733'
  /// Color(0xFFFF5733).toHex(includeAlpha: true); // '#FF5733FF'
  /// Color(0xFFFF5733).toHex(includeHash: false); // 'FF5733'
  /// Colors.red.toHex(); // '#FFFF0000'
  /// ```
  static String toHex(Color color, {bool includeAlpha = false, bool includeHash = true}) {
    final argbValue = color.toARGB32();
    String hex = includeAlpha
        ? argbValue.toRadixString(16).padLeft(8, '0').toUpperCase()
        : argbValue.toRadixString(16).substring(2, 8).toUpperCase();
    return includeHash ? '#$hex' : hex;
  }

  /// Lightens a color by increasing its brightness.
  ///
  /// Blends the color with white based on the specified [amount].
  /// Higher values produce lighter colors.
  ///
  /// Parameters:
  /// - [color]: The base color to lighten
  /// - [amount]: Amount to lighten (0.0 to 1.0, default: 0.2)
  ///
  /// Returns a new lightened [Color].
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.lighten(Colors.blue, 0.2); // Lighter blue
  /// ColorUtils.lighten(Colors.black, 0.5); // Gray
  /// ColorUtils.lighten(Color(0xFF5733), 0.3); // Lighter orange-red
  /// ```
  static Color lighten(Color color, [double amount = 0.2]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    return Color.lerp(color, const Color(0xFFFFFFFF), amount)!;
  }

  /// Darkens a color by decreasing its brightness.
  ///
  /// Blends the color with black based on the specified [amount].
  /// Higher values produce darker colors.
  ///
  /// Parameters:
  /// - [color]: The base color to darken
  /// - [amount]: Amount to darken (0.0 to 1.0, default: 0.2)
  ///
  /// Returns a new darkened [Color].
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.darken(Colors.blue, 0.2); // Darker blue
  /// ColorUtils.darken(Colors.white, 0.5); // Gray
  /// ColorUtils.darken(Color(0xFF5733), 0.3); // Darker orange-red
  /// ```
  static Color darken(Color color, [double amount = 0.2]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    return Color.lerp(color, const Color(0xFF000000), amount)!;
  }

  /// Mixes two colors together with a specified ratio.
  ///
  /// Creates a blended color that is a combination of [color1] and [color2]
  /// based on the [ratio]. A ratio of 0 returns [color1], 1 returns [color2],
  /// and 0.5 returns an equal mix of both.
  ///
  /// Parameters:
  /// - [color1]: First color (dominant when ratio is low)
  /// - [color2]: Second color (dominant when ratio is high)
  /// - [ratio]: Blend ratio from 0.0 to 1.0 (default: 0.5)
  ///
  /// Returns a new mixed [Color].
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.mix(Colors.red, Colors.blue, 0.5); // Purple
  /// ColorUtils.mix(Colors.red, Colors.blue, 0.25); // Reddish purple
  /// ColorUtils.mix(Colors.white, Colors.black, 0.5); // Gray
  /// ```
  static Color mix(Color color1, Color color2, [double ratio = 0.5]) {
    assert(ratio >= 0 && ratio <= 1, 'Ratio must be between 0 and 1');
    return Color.lerp(color1, color2, ratio)!;
  }

  /// Adjusts the opacity (alpha) of a color.
  ///
  /// Creates a new color with the same RGB values but different alpha.
  ///
  /// Parameters:
  /// - [color]: The base color
  /// - [opacity]: New opacity value (0.0 transparent to 1.0 opaque)
  ///
  /// Returns a new [Color] with adjusted opacity.
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.withOpacity(Colors.red, 0.5); // Semi-transparent red
  /// ColorUtils.withOpacity(Colors.blue, 0.0); // Fully transparent blue
  /// ColorUtils.withOpacity(Colors.green, 1.0); // Opaque green (same as original)
  /// ```
  static Color withOpacity(Color color, double opacity) {
    assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');
    return color.withOpacity(opacity);
  }

  /// Extracts the red component from a color as an integer (0-255).
  ///
  /// Parameters:
  /// - [color]: The color to extract red from
  ///
  /// Returns red value as integer (0-255).
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.getRed(Colors.red); // 255
  /// ColorUtils.getRed(Colors.blue); // 0
  /// ColorUtils.getRed(Color(0xFF123456)); // 18
  /// ```
  static int getRed(Color color) => (color.toARGB32() >> 16) & 0xFF;

  /// Extracts the green component from a color as an integer (0-255).
  ///
  /// Parameters:
  /// - [color]: The color to extract green from
  ///
  /// Returns green value as integer (0-255).
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.getGreen(Colors.green); // 255
  /// ColorUtils.getGreen(Colors.red); // 0
  /// ColorUtils.getGreen(Color(0xFF123456)); // 52
  /// ```
  static int getGreen(Color color) => (color.toARGB32() >> 8) & 0xFF;

  /// Extracts the blue component from a color as an integer (0-255).
  ///
  /// Parameters:
  /// - [color]: The color to extract blue from
  ///
  /// Returns blue value as integer (0-255).
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.getBlue(Colors.blue); // 255
  /// ColorUtils.getBlue(Colors.red); // 0
  /// ColorUtils.getBlue(Color(0xFF123456)); // 86
  /// ```
  static int getBlue(Color color) => color.toARGB32() & 0xFF;

  /// Extracts the alpha (opacity) component from a color as an integer (0-255).
  ///
  /// Parameters:
  /// - [color]: The color to extract alpha from
  ///
  /// Returns alpha value as integer (0-255, where 255 is fully opaque).
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.getAlpha(Colors.red); // 255
  /// ColorUtils.getAlpha(Colors.transparent); // 0
  /// ColorUtils.getAlpha(Color(0x80123456)); // 128
  /// ```
  static int getAlpha(Color color) => (color.toARGB32() >> 24) & 0xFF;

  /// Checks if a color is considered dark based on luminance.
  ///
  /// Uses the relative luminance formula to determine if text should be
  /// white or black when displayed on this color background.
  ///
  /// Parameters:
  /// - [color]: The color to check
  /// - [threshold]: Luminance threshold below which color is "dark" (default: 0.15)
  ///
  /// Returns `true` if the color is dark, `false` if light.
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.isDark(Colors.black); // true
  /// ColorUtils.isDark(Colors.white); // false
  /// ColorUtils.isDark(Colors.blue); // true (blue has low luminance)
  /// ColorUtils.isDark(Colors.yellow); // false (yellow is bright)
  /// ```
  static bool isDark(Color color, [double threshold = 0.15]) {
    return color.computeLuminance() < threshold;
  }

  /// Checks if a color is considered light based on luminance.
  ///
  /// Inverse of [isDark].
  ///
  /// Parameters:
  /// - [color]: The color to check
  /// - [threshold]: Luminance threshold above which color is "light" (default: 0.15)
  ///
  /// Returns `true` if the color is light, `false` if dark.
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.isLight(Colors.white); // true
  /// ColorUtils.isLight(Colors.black); // false
  /// ColorUtils.isLight(Colors.pink); // true
  /// ```
  static bool isLight(Color color, [double threshold = 0.15]) {
    return !isDark(color, threshold);
  }

  /// Returns contrasting text color (black or white) for readability on this background.
  ///
  /// Automatically selects black or white text color based on background luminance
  /// to ensure good contrast and readability.
  ///
  /// Parameters:
  /// - [backgroundColor]: The background color to evaluate
  ///
  /// Returns [Colors.black] for light backgrounds, [Colors.white] for dark backgrounds.
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.contrastingText(Colors.white); // Colors.black
  /// ColorUtils.contrastingText(Colors.black); // Colors.white
  /// ColorUtils.contrastingText(Colors.blue); // Colors.white
  /// ```
  static Color contrastingText(Color backgroundColor) {
    return isDark(backgroundColor) ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  }

  /// Generates a random color with optional opacity constraints.
  ///
  /// Useful for generating placeholder colors, avatars, or visual variety.
  ///
  /// Parameters:
  /// - [minAlpha]: Minimum alpha value (0-255, default: 255 for fully opaque)
  /// - [maxAlpha]: Maximum alpha value (0-255, default: 255)
  ///
  /// Returns a random [Color] within specified alpha range.
  ///
  /// Example:
  /// ```dart
  /// final randomColor = ColorUtils.random();
  /// final semiTransparent = ColorUtils.random(minAlpha: 128);
  /// ```
  static Color random({int minAlpha = 255, int maxAlpha = 255}) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final r = ((random * 9301 + 49297) % 233280) / 233280;
    final red = (r * 256).floor();
    final g = ((random + 1234) * 9301 + 49297) % 233280 / 233280;
    final green = (g * 256).floor();
    final b = ((random + 5678) * 9301 + 49297) % 233280 / 233280;
    final blue = (b * 256).floor();
    final alpha = minAlpha +
        ((random * 9999) % (maxAlpha - minAlpha + 1)).floor();
    return Color.fromARGB(alpha, red.clamp(0, 255), green.clamp(0, 255), blue.clamp(0, 255));
  }

  /// Converts a color to HSL (Hue, Saturation, Lightness) components.
  ///
  /// HSL is often more intuitive than RGB for color manipulation.
  ///
  /// Parameters:
  /// - [color]: The color to convert
  ///
  /// Returns a map with keys 'h', 's', 'l' (all values 0.0-1.0 except hue 0-360).
  ///
  /// Example:
  /// ```dart
  /// final hsl = ColorUtils.toHSL(Colors.red);
  /// print(hsl['h']); // ~0.0 (red hue)
  /// print(hsl['s']); // 1.0 (fully saturated)
  /// print(hsl['l']); // 0.5 (medium lightness)
  /// ```
  static Map<String, double> toHSL(Color color) {
    final r = getRed(color) / 255;
    final g = getGreen(color) / 255;
    final b = getBlue(color) / 255;
    
    final maxVal = [r, g, b].reduce((a, b) => a > b ? a : b);
    final minVal = [r, g, b].reduce((a, b) => a < b ? a : b);
    final l = (maxVal + minVal) / 2;
    
    if (maxVal == minVal) {
      return {'h': 0.0, 's': 0.0, 'l': l};
    }
    
    final d = maxVal - minVal;
    final s = l > 0.5 ? d / (2 - maxVal - minVal) : d / (maxVal + minVal);
    
    double h;
    if (maxVal == r) {
      h = ((g - b) / d + (g < b ? 6 : 0)) / 6;
    } else if (maxVal == g) {
      h = ((b - r) / d + 2) / 6;
    } else {
      h = ((r - g) / d + 4) / 6;
    }
    
    return {'h': h * 360, 's': s, 'l': l};
  }

  /// Creates a color from HSL components.
  ///
  /// Inverse of [toHSL].
  ///
  /// Parameters:
  /// - [h]: Hue (0-360 degrees)
  /// - [s]: Saturation (0.0-1.0)
  /// - [l]: Lightness (0.0-1.0)
  /// - [alpha]: Opacity (0.0-1.0, default: 1.0)
  ///
  /// Returns a [Color] created from HSL values.
  ///
  /// Example:
  /// ```dart
  /// ColorUtils.fromHSL(0, 1.0, 0.5); // Red (similar to Colors.red)
  /// ColorUtils.fromHSL(120, 1.0, 0.5); // Green
  /// ColorUtils.fromHSL(240, 1.0, 0.5); // Blue
  /// ```
  static Color fromHSL(double h, double s, double l, [double alpha = 1.0]) {
    h = h % 360 / 360;
    
    double r, g, b;
    if (s == 0) {
      r = g = b = l;
    } else {
      final q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      final p = 2 * l - q;
      r = _hueToRgb(p, q, h + 1/3);
      g = _hueToRgb(p, q, h);
      b = _hueToRgb(p, q, h - 1/3);
    }
    
    return Color.fromARGB(
      (alpha * 255).round(),
      (r * 255).round(),
      (g * 255).round(),
      (b * 255).round(),
    );
  }
  
  static double _hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1/6) return p + (q - p) * 6 * t;
    if (t < 1/2) return q;
    if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
    return p;
  }
}

/// Extension methods on [Color] for convenient color operations.
///
/// Provides instance methods that delegate to [ColorUtils] static methods,
/// allowing method chaining and more readable code.
///
/// Example usage:
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   final color = Colors.blue;
///   
///   // Use extension methods directly
///   final hex = color.toHex();
///   final lighter = color.lighten(0.2);
///   final darker = color.darken(0.1);
///   final mixed = color.mixWith(Colors.red, 0.5);
///   
///   // Check properties
///   if (color.isDarkColor) {
///     final textColor = color.contrastingTextColor;
///   }
/// }
/// ```
extension ColorExtensions on Color {
  /// Converts this color to hex string using [ColorUtils.toHex].
  ///
  /// See [ColorUtils.toHex] for parameters and examples.
  String toHex({bool includeAlpha = false, bool includeHash = true}) =>
      ColorUtils.toHex(this, includeAlpha: includeAlpha, includeHash: includeHash);

  /// Lightens this color using [ColorUtils.lighten].
  ///
  /// See [ColorUtils.lighten] for parameters and examples.
  Color lighten([double amount = 0.2]) => ColorUtils.lighten(this, amount);

  /// Darkens this color using [ColorUtils.darken].
  ///
  /// See [ColorUtils.darken] for parameters and examples.
  Color darken([double amount = 0.2]) => ColorUtils.darken(this, amount);

  /// Mixes this color with another using [ColorUtils.mix].
  ///
  /// See [ColorUtils.mix] for parameters and examples.
  Color mixWith(Color other, [double ratio = 0.5]) =>
      ColorUtils.mix(this, other, ratio);

  /// Checks if this color is dark using [ColorUtils.isDark].
  ///
  /// See [ColorUtils.isDark] for details.
  bool get isDarkColor => ColorUtils.isDark(this);

  /// Checks if this color is light using [ColorUtils.isLight].
  ///
  /// See [ColorUtils.isLight] for details.
  bool get isLightColor => ColorUtils.isLight(this);

  /// Gets contrasting text color for readability on this background.
  ///
  /// See [ColorUtils.contrastingText] for details.
  Color get contrastingTextColor => ColorUtils.contrastingText(this);

  /// Gets red component (0-255) using [ColorUtils.getRed].
  int get redValue => ColorUtils.getRed(this);

  /// Gets green component (0-255) using [ColorUtils.getGreen].
  int get greenValue => ColorUtils.getGreen(this);

  /// Gets blue component (0-255) using [ColorUtils.getBlue].
  int get blueValue => ColorUtils.getBlue(this);

  /// Gets alpha component (0-255) using [ColorUtils.getAlpha].
  int get alphaValue => ColorUtils.getAlpha(this);

  /// Converts to HSL map using [ColorUtils.toHSL].
  Map<String, double> get hsl => ColorUtils.toHSL(this);
}
