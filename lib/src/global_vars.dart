library fluent_window;

import 'widgets/icons.dart';
import 'window_buttons/window_button.dart';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFE81123),
    mouseOverDark: const Color(0xFFE81123),
    mouseDown: const Color(0xFFF1707A),
    mouseDownDark: const Color(0xFFF1707A),
    iconMouseOver: Colors.white,
    iconMouseOverDark: Colors.white,
    iconMouseDown: Colors.white,
    iconMouseDownDark: Colors.white);

class ShadowToggleButton extends WindowButton {
  ShadowToggleButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 10),
          iconBuilder: (buttonContext) =>
              ShadowToggleIcon(color: buttonContext.iconColor),
          onPressed: onPressed ??
              () async =>
                  windowManager.setHasShadow(!await windowManager.hasShadow()),
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}

class FullScreenMaximizeWindowButton extends WindowButton {
  FullScreenMaximizeWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 10),
          iconBuilder: (buttonContext) =>
              FullScreenMaximizeIcon(color: buttonContext.iconColor),
          onPressed: onPressed ??
              () async {
                // if (await windowManager.isMaximized()) {
                //   await windowManager.unmaximize();
                // }
                windowManager.setFullScreen(true);
              },
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}

class FullScreenMinimizeWindowButton extends WindowButton {
  FullScreenMinimizeWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 10),
          iconBuilder: (buttonContext) =>
              FullScreenMinimizeIcon(color: buttonContext.iconColor),
          onPressed:
              onPressed ?? () async => windowManager.setFullScreen(false),
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}

class MinimizeWindowButton extends WindowButton {
  MinimizeWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 15),
          iconBuilder: (buttonContext) =>
              MinimizeIcon(color: buttonContext.iconColor),
          onPressed: onPressed ?? () async => windowManager.minimize(),
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}

class MaximizeWindowButton extends WindowButton {
  MaximizeWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 10, left: 1),
          iconBuilder: (buttonContext) =>
              MaximizeIcon(color: buttonContext.iconColor),
          onPressed: onPressed ?? () async => windowManager.maximize(),
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}

class UnmaximizeWindowButton extends WindowButton {
  UnmaximizeWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 10),
          iconBuilder: (buttonContext) =>
              RestoreIcon(color: buttonContext.iconColor),
          onPressed: onPressed ?? () async => windowManager.unmaximize(),
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}

class CloseWindowButton extends WindowButton {
  CloseWindowButton({
    Key? key,
    WindowButtonColors? colors,
    VoidCallback? onPressed,
    bool? animate,
    bool? disabled,
    Size? buttonSize,
    bool? dark,
  }) : super(
          key: key,
          colors: colors ?? closeButtonColors,
          animate: animate ?? true,
          padding: const EdgeInsets.only(top: 11),
          iconBuilder: (buttonContext) =>
              CloseIcon(color: buttonContext.iconColor),
          onPressed: onPressed ?? () => windowManager.close(),
          disabled: disabled ?? false,
          buttonSize: buttonSize,
          dark: dark ?? false,
        );
}
