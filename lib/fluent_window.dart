library fluent_window;

export 'src/widgets/icons.dart';
export 'src/window_buttons/mouse_state_builder.dart';
export 'src/window_buttons/window_button.dart';
export 'src/window_frame.dart';
export 'src/global_vars.dart';

import 'fluent_window_platform_interface.dart';

// TODO(damywise): get is windows 11
class FluentWindow {
  Future<String?> getPlatformVersion() {
    return FluentWindowPlatform.instance.getPlatformVersion();
  }
}
