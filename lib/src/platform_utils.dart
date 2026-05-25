// Copyright (c) 2024 dxmwl. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get isWeb => kIsWeb;

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  static bool get isWindows => !kIsWeb && Platform.isWindows;

  static bool get isLinux => !kIsWeb && Platform.isLinux;

  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;

  static bool get isMobile => isAndroid || isIOS;

  static bool get isDesktop => isMacOS || isWindows || isLinux;

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

  static String get platformNameCN {
    if (isWeb) return '网页';
    if (isAndroid) return '安卓';
    if (isIOS) return '苹果';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    if (isFuchsia) return 'Fuchsia';
    return '未知';
  }

  static bool get isRelease => const bool.fromEnvironment('dart.vm.product');

  static bool get isDebug => !isRelease;

  static bool get isTest => false;

  static String get currentLocale {
    if (isWeb) {
      return 'zh_CN';
    }
    return Platform.localeName;
  }

  static int? get numberOfProcessors {
    if (isWeb) return null;
    return Platform.numberOfProcessors;
  }

  static String? get pathSeparator {
    if (isWeb) return null;
    return Platform.pathSeparator;
  }

  static String get operatingSystem {
    if (isWeb) return 'web';
    return Platform.operatingSystem;
  }

  static String get operatingSystemVersion {
    if (isWeb) return '';
    return Platform.operatingSystemVersion;
  }

  static String get localHostname {
    if (isWeb) return 'localhost';
    return Platform.localHostname;
  }

  static bool supportsFileSystem() {
    return !isWeb;
  }

  static bool supportsNetworkSockets() {
    return !isWeb || false;
  }

  static bool supportsProcessInfo() {
    return !isWeb;
  }

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
