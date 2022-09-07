import 'package:flutter_test/flutter_test.dart';
import 'package:fluent_window/fluent_window.dart';
import 'package:fluent_window/fluent_window_platform_interface.dart';
import 'package:fluent_window/fluent_window_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFluentWindowPlatform 
    with MockPlatformInterfaceMixin
    implements FluentWindowPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FluentWindowPlatform initialPlatform = FluentWindowPlatform.instance;

  test('$MethodChannelFluentWindow is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFluentWindow>());
  });

  test('getPlatformVersion', () async {
    FluentWindow fluentWindowPlugin = FluentWindow();
    MockFluentWindowPlatform fakePlatform = MockFluentWindowPlatform();
    FluentWindowPlatform.instance = fakePlatform;
  
    expect(await fluentWindowPlugin.getPlatformVersion(), '42');
  });
}
