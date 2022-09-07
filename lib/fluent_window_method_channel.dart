import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fluent_window_platform_interface.dart';

/// An implementation of [FluentWindowPlatform] that uses method channels.
class MethodChannelFluentWindow extends FluentWindowPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fluent_window');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
