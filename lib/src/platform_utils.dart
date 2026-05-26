// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb, VoidCallback;

/// Utility class for platform detection and runtime environment information.
///
/// Provides static methods and getters for:
/// - Platform identification (iOS, Android, Web, desktop platforms)
/// - Device information (processor count, OS version, locale)
/// - Runtime mode detection (debug, release, test)
/// - Platform-specific code execution
///
/// This class is designed to work across all Flutter-supported platforms,
/// including web, mobile (iOS/Android), and desktop (macOS, Windows, Linux).
///
/// Example usage:
/// ```dart
/// import 'package:tools_box/tools_box.dart';
///
/// void main() {
///   if (PlatformUtils.isMobile) {
///     // Mobile-specific code
///   }
///
///   final name = PlatformUtils.platformName;
///   print('Running on $name');
///
///   PlatformUtils.runOnPlatform(
///     onWeb: () => print('Web!'),
///     onAndroid: () => print('Android!'),
///     onIOS: () => print('iOS!'),
///   );
/// }
/// ```
class PlatformUtils {
  /// Checks if the current platform is Web.
  ///
  /// Uses `kIsWeb` from Flutter foundation to detect web platform.
  ///
  /// Returns `true` if running in a web browser, `false` otherwise.
  static bool get isWeb => kIsWeb;

  /// Checks if the current platform is Android.
  ///
  /// Returns `true` if running on Android (and not web), `false` otherwise.
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Checks if the current platform is iOS.
  ///
  /// Returns `true` if running on iOS (and not web), `false` otherwise.
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Checks if the current platform is macOS.
  ///
  /// Returns `true` if running on macOS (and not web), `false` otherwise.
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Checks if the current platform is Windows.
  ///
  /// Returns `true` if running on Windows (and not web), `false` otherwise.
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// Checks if the current platform is Linux.
  ///
  /// Returns `true` if running on Linux (and not web), `false` otherwise.
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Checks if the current platform is Fuchsia.
  ///
  /// Fuchsia is Google's experimental operating system.
  ///
  /// Returns `true` if running on Fuchsia, `false` otherwise.
  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;

  /// Checks if the current platform is a mobile device (Android or iOS).
  ///
  /// Convenience getter for mobile-specific logic.
  ///
  /// Returns `true` if running on Android or iOS, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// if (PlatformUtils.isMobile) {
  ///   // Show mobile-optimized UI
  /// }
  /// ```
  static bool get isMobile => isAndroid || isIOS;

  /// Checks if the current platform is a desktop (macOS, Windows, or Linux).
  ///
  /// Convenience getter for desktop-specific logic.
  ///
  /// Returns `true` if running on any desktop platform, `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// if (PlatformUtils.isDesktop) {
  ///   // Use desktop layout with sidebar
  /// }
  /// ```
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Gets the human-readable platform name in English.
  ///
  /// Returns one of: 'Web', 'Android', 'iOS', 'macOS', 'Windows', 'Linux',
  /// 'Fuchsia', or 'Unknown' for unsupported platforms.
  ///
  /// Example:
  /// ```dart
  /// print(PlatformUtils.platformName); // e.g., "Android"
  /// ```
  static String get platformName {
    if (isWeb) return 'Web';
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    if (isFuchsia) return 'Fuchsia';
    return 'Unknown';
  }

  /// Gets the human-readable platform name in Chinese locale.
  ///
  /// Useful for displaying platform info to Chinese-speaking users.
  ///
  /// Returns localized platform name or 'Unknown' for unsupported platforms.
  ///
  /// Example:
  /// ```dart
  /// print(PlatformUtils.platformNameCN); // e.g., "Android" -> "Android"
  /// ```
  static String get platformNameCN {
    if (isWeb) return 'Web';
    if (isAndroid) return 'Android';
    if (isIOS) return 'iOS';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    if (isFuchsia) return 'Fuchsia';
    return 'Unknown';
  }

  /// Checks if the app is running in release mode.
  ///
  /// Detects release mode via the `dart.vm.product` environment variable,
  /// which is only set to true in release builds.
  ///
  /// Returns `true` in release mode, `false` in debug or profile mode.
  ///
  /// Example:
  /// ```dart
  /// if (PlatformUtils.isRelease) {
  ///   // Disable logging, enable analytics, etc.
  /// }
  /// ```
  static bool get isRelease => const bool.fromEnvironment('dart.vm.product');

  /// Checks if the app is running in debug mode.
  ///
  /// The opposite of [isRelease]. Returns `true` when not in release mode,
  /// which includes both debug and profile modes.
  ///
  /// Returns `true` in debug/profile mode, `false` in release mode.
  static bool get isDebug => !isRelease;

  /// Placeholder for test mode detection.
  ///
  /// Note: Currently always returns `false`. Test detection would require
  /// additional configuration or package integration in future versions.
  ///
  /// Returns `false` (not yet implemented).
  static bool get isTest => false;

  /// Gets the current system locale string.
  ///
  /// On native platforms, returns the system's locale name (e.g., 'en_US', 'zh_CN').
  /// On web, returns 'zh_CN' as default since locale detection is limited.
  ///
  /// Returns locale identifier string.
  ///
  /// Example:
  /// ```dart
  /// final locale = PlatformUtils.currentLocale;
  /// print(locale); // e.g., "en_US"
  /// ```
  static String get currentLocale {
    if (isWeb) {
      return 'en_US';
    }
    return Platform.localeName;
  }

  /// Gets the number of processor cores available on the device.
  ///
  /// On native platforms, returns the actual CPU core count.
  /// On web, returns `null` since this information is not available.
  ///
  /// Returns number of processors as integer, or `null` on web.
  ///
  /// Example:
  /// ```dart
  /// final cores = PlatformUtils.numberOfProcessors;
  /// if (cores != null) {
  ///   print('Device has $cores CPU cores');
  /// }
  /// ```
  static int? get numberOfProcessors {
    if (isWeb) return null;
    return Platform.numberOfProcessors;
  }

  /// Gets the path separator character for the current platform.
  ///
  /// Returns '\\' on Windows, '/' on POSIX systems (macOS, Linux, iOS, Android),
  /// or `null` on web where file system paths don't apply.
  ///
  /// Returns path separator string, or `null` on web.
  ///
  /// Example:
  /// ```dart
  /// final sep = PlatformUtils.pathSeparator;
  /// if (sep != null) {
  ///   final path = 'folder${sep}file.txt';
  /// }
  /// ```
  static String? get pathSeparator {
    if (isWeb) return null;
    return Platform.pathSeparator;
  }

  /// Gets the operating system identifier string.
  ///
  /// Returns lowercase OS name like 'android', 'ios', 'macos', 'windows',
  /// 'linux', or 'web' for web platform.
  ///
  /// Returns OS identifier string.
  static String get operatingSystem {
    if (isWeb) return 'web';
    return Platform.operatingSystem;
  }

  /// Gets the operating system version string.
  ///
  /// Returns detailed version info on native platforms (e.g., '14.2.1' for iOS).
  /// Returns empty string on web where this is not applicable.
  ///
  /// Returns OS version string, or empty string on web.
  static String get operatingSystemVersion {
    if (isWeb) return '';
    return Platform.operatingSystemVersion;
  }

  /// Gets the local hostname of the device.
  ///
  /// Returns the machine's network hostname on native platforms.
  /// Returns 'localhost' on web as fallback.
  ///
  /// Returns hostname string.
  static String get localHostname {
    if (isWeb) return 'localhost';
    return Platform.localHostname;
  }

  /// Checks if the current platform supports file system access.
  ///
  /// File system operations are available on all native platforms but not on web.
  ///
  /// Returns `true` if file system is supported, `false` (only on web).
  ///
  /// Example:
  /// ```dart
  /// if (PlatformUtils.supportsFileSystem()) {
  ///   final file = File('data.json');
  ///   // Read/write operations...
  /// }
  /// ```
  static bool supportsFileSystem() {
    return !isWeb;
  }

  /// Checks if the current platform supports network sockets.
  ///
  /// Network sockets are available on most native platforms.
  /// Currently returns false on web due to browser limitations.
  ///
  /// Returns `true` if network sockets are supported.
  static bool supportsNetworkSockets() {
    return !isWeb || false;
  }

  /// Checks if the current platform supports process information APIs.
  ///
  /// Process information (like CPU count, memory usage) is available
  /// on native platforms but restricted on web.
  ///
  /// Returns `true` if process info APIs are available, `false` on web.
  static bool supportsProcessInfo() {
    return !isWeb;
  }

  /// Executes platform-specific code based on the current platform.
  ///
  /// A convenience method for conditional execution without repeated
  /// if-else checks. Calls the appropriate callback for the detected platform.
  ///
  /// Parameters:
  /// - [onWeb]: Required callback executed when running on web
  /// - [onAndroid]: Optional callback for Android
  /// - [onIOS]: Optional callback for iOS
  /// - [onMacOS]: Optional callback for macOS
  /// - [onWindows]: Optional callback for Windows
  /// - [onLinux]: Optional callback for Linux
  /// - [onFuchsia]: Optional callback for Fuchsia
  /// - [onMobile]: Optional callback also called for mobile platforms (Android/iOS)
  /// - [onDesktop]: Optional callback also called for desktop platforms (macOS/Windows/Linux)
  /// - [onOther]: Optional callback for unrecognized platforms
  ///
  /// Note: Only [onWeb] is required. All other callbacks are optional and safely ignored if null.
  ///
  /// Example:
  /// ```dart
  /// PlatformUtils.runOnPlatform(
  ///   onWeb: () => loadWebConfig(),
  ///   onAndroid: () => requestPermissions(),
  ///   onIOS: () => setupPushNotifications(),
  ///   onMobile: () => initMobileSDK(),  // Called for both Android & iOS
  /// );
  /// ```
  static void runOnPlatform({
    required VoidCallback onWeb,
    VoidCallback? onAndroid,
    VoidCallback? onIOS,
    VoidCallback? onMacOS,
    VoidCallback? onWindows,
    VoidCallback? onLinux,
    VoidCallback? onFuchsia,
    VoidCallback? onMobile,
    VoidCallback? onDesktop,
    VoidCallback? onOther,
  }) {
    if (isWeb) {
      onWeb();
      return;
    }
    if (isAndroid) {
      onAndroid?.call();
      onMobile?.call();
      return;
    }
    if (isIOS) {
      onIOS?.call();
      onMobile?.call();
      return;
    }
    if (isMacOS) {
      onMacOS?.call();
      onDesktop?.call();
      return;
    }
    if (isWindows) {
      onWindows?.call();
      onDesktop?.call();
      return;
    }
    if (isLinux) {
      onLinux?.call();
      onDesktop?.call();
      return;
    }
    if (isFuchsia) {
      onFuchsia?.call();
      return;
    }
    onOther?.call();
  }

  /// Executes platform-specific code that returns a value.
  ///
  /// Similar to [runOnPlatform] but supports returning values from callbacks.
  /// Useful when different platforms need to provide different data or configurations.
  ///
  /// Type parameter [T] specifies the return type. All callbacks should return
  /// values of type T or compatible types.
  ///
  /// Parameters:
  /// - [onWeb]: Required callback that returns a value when running on web
  /// - [onAndroid]: Optional callback for Android with return value
  /// - [onIOS]: Optional callback for iOS with return value
  /// - [onMacOS]: Optional callback for macOS with return value
  /// - [onWindows]: Optional callback for Windows with return value
  /// - [onLinux]: Optional callback for Linux with return value
  /// - [onFuchsia]: Optional callback for Fuchsia with return value
  /// - [onMobile]: Optional callback for mobile (also executed for Android/iOS)
  /// - [onDesktop]: Optional callback for desktop (also executed for macOS/Windows/Linux)
  /// - [onOther]: Optional callback for other platforms with return value
  ///
  /// Returns the value from the matching platform callback, or falls back to
  /// [onOther] or a default value if no callback matches.
  ///
  /// Example:
  /// ```dart
  /// final configPath = PlatformUtils.runOnPlatformWithResult<String>(
  ///   onWeb: () => '/assets/config.json',
  ///   onAndroid: () => '/data/data/com.app/files/config.json',
  ///   onIOS: () => '${NSBundle.mainBundle.bundlePath}/config.json',
  ///   onOther: () => '/etc/app/config.json',
  /// );
  /// ```
  T runOnPlatformWithResult<T>({
    required T Function() onWeb,
    T Function()? onAndroid,
    T Function()? onIOS,
    T Function()? onMacOS,
    T Function()? onWindows,
    T Function()? onLinux,
    T Function()? onFuchsia,
    T Function()? onMobile,
    T Function()? onDesktop,
    T Function()? onOther,
  }) {
    if (isWeb) return onWeb();
    if (isAndroid) {
      onMobile?.call();
      return onAndroid?.call() ?? onOther?.call() ?? T.toString() as T;
    }
    if (isIOS) {
      onMobile?.call();
      return onIOS?.call() ?? onOther?.call() ?? T.toString() as T;
    }
    if (isMacOS) {
      onDesktop?.call();
      return onMacOS?.call() ?? onOther?.call() ?? T.toString() as T;
    }
    if (isWindows) {
      onDesktop?.call();
      return onWindows?.call() ?? onOther?.call() ?? T.toString() as T;
    }
    if (isLinux) {
      onDesktop?.call();
      return onLinux?.call() ?? onOther?.call() ?? T.toString() as T;
    }
    if (isFuchsia) return onFuchsia?.call() ?? onOther?.call() ?? T.toString() as T;
    return onOther?.call() ?? T.toString() as T;
  }
}
