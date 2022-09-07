import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fluent_window_method_channel.dart';

abstract class FluentWindowPlatform extends PlatformInterface {
  /// Constructs a FluentWindowPlatform.
  FluentWindowPlatform() : super(token: _token);

  static final Object _token = Object();

  static FluentWindowPlatform _instance = MethodChannelFluentWindow();

  /// The default instance of [FluentWindowPlatform] to use.
  ///
  /// Defaults to [MethodChannelFluentWindow].
  static FluentWindowPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FluentWindowPlatform] when
  /// they register themselves.
  static set instance(FluentWindowPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
