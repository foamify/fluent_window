library fluent_window;

import 'dart:io';

import 'package:fluent_window/fluent_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:window_manager/window_manager.dart';

typedef WindowButtonIconBuilder = Widget Function(
    WindowButtonContext buttonContext);
typedef WindowButtonBuilder = Widget Function(
    WindowButtonContext buttonContext, Widget icon);

class WindowButtonContext {
  BuildContext context;
  MouseState mouseState;
  Color? backgroundColor;
  Color iconColor;

  WindowButtonContext(
      {required this.context,
      required this.mouseState,
      this.backgroundColor,
      required this.iconColor});
}

class WindowButtonColors {
  late Color normal;
  late Color mouseOver;
  late Color mouseOverDark;
  late Color mouseDownDark;
  late Color mouseDown;
  late Color iconNormal;
  late Color iconNormalDark;
  late Color iconNormalBlur;
  late Color iconDisabled;
  late Color iconDisabledBlur;
  late Color iconMouseOver;
  late Color iconMouseOverDark;
  late Color iconMouseDown;
  late Color iconMouseDownDark;

  WindowButtonColors({
    Color? normal,
    Color? mouseOver,
    Color? mouseOverDark,
    Color? mouseDown,
    Color? mouseDownDark,
    Color? iconNormal,
    Color? iconNormalDark,
    Color? iconNormalBlur,
    Color? iconDisabled,
    Color? iconDisabledBlur,
    Color? iconMouseOver,
    Color? iconMouseOverDark,
    Color? iconMouseDown,
    Color? iconMouseDownDark,
  }) {
    this.normal = normal ?? _defaultButtonColors.normal;
    this.mouseOver = mouseOver ?? _defaultButtonColors.mouseOver;
    this.mouseOverDark = mouseOverDark ?? _defaultButtonColors.mouseOverDark;
    this.mouseDown = mouseDown ?? _defaultButtonColors.mouseDown;
    this.mouseDownDark = mouseDownDark ?? _defaultButtonColors.mouseDownDark;
    this.iconNormal = iconNormal ?? _defaultButtonColors.iconNormal;
    this.iconNormalDark = iconNormalDark ?? _defaultButtonColors.iconNormalDark;
    this.iconNormalBlur = iconNormalBlur ?? _defaultButtonColors.iconNormalBlur;
    this.iconDisabled = iconDisabled ?? _defaultButtonColors.iconDisabled;
    this.iconDisabledBlur =
        iconDisabledBlur ?? _defaultButtonColors.iconDisabledBlur;
    this.iconMouseOver = iconMouseOver ?? _defaultButtonColors.iconMouseOver;
    this.iconMouseOverDark =
        iconMouseOverDark ?? _defaultButtonColors.iconMouseOverDark;
    this.iconMouseDownDark =
        iconMouseDownDark ?? _defaultButtonColors.iconMouseDownDark;
    this.iconMouseDown = iconMouseDown ?? _defaultButtonColors.iconMouseDown;
  }
}

final _defaultButtonColors = WindowButtonColors(
  normal: Colors.transparent,
  mouseOver: Colors.black.withAlpha(26),
  mouseOverDark: Colors.black.withAlpha(55),
  mouseDown: Colors.black.withAlpha(51),
  mouseDownDark: Colors.white.withAlpha(22),
  iconNormal: const Color(0xFF000000),
  iconNormalDark: const Color(0xFFFFFFFF),
  // iconNormal: Colors.lightGreen,
  iconNormalBlur: const Color(0xFF999999),
  // iconNormalBlur: Colors.red,
  iconDisabled: const Color(0xFFCDCDCE),
  iconDisabledBlur: const Color(0xFFEBEBEC),
  iconMouseOver: const Color(0xFF000000),
  iconMouseOverDark: const Color(0xFFFFFFFF),
  iconMouseDown: const Color(0xFF000000),
  iconMouseDownDark: const Color(0xFFFFFFFF),
);

class WindowButton extends StatefulWidget {
  // @override
  // void onWindowFocus() {
  //   super.onWindowFocus();
  //   key = UniqueKey();
  // }
  //
  // @override
  // void onWindowBlur() {
  //   super.onWindowBlur();
  //   key = UniqueKey();
  // }
  //
  // @override
  // void onWindowRestore() {
  //   super.onWindowRestore();
  //   key = UniqueKey();
  // }

  final bool dark;
  final WindowButtonBuilder? builder;
  final WindowButtonIconBuilder? iconBuilder;
  late final WindowButtonColors colors;
  final bool animate;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;
  final bool disabled;
  late final Size buttonSize;

  @override
  final Key? key;

  WindowButton(
      {this.key,
      WindowButtonColors? colors,
      this.builder,
      required this.iconBuilder,
      this.padding,
      this.onPressed,
      this.animate = true,
      this.disabled = false,
      Size? buttonSize,
      required this.dark})
      : super(key: key) {
    this.colors = colors ?? _defaultButtonColors;
    this.buttonSize = buttonSize ?? const Size(46, 32);
  }

  @override
  State<WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<WindowButton> with WindowListener {
  late Color iconNormal;
  late Color iconNormalDark;
  late Color iconNormalBlur;
  late Color iconDisabled;
  late Color iconDisabledBlur;

  late bool windowIsFocused = true;

  late bool isButtonDisabled;

  Color getBackgroundColor(MouseState mouseState) {
    if (mouseState.isMouseDown && isButtonDisabled == false) {
      return widget.dark ? widget.colors.mouseDownDark : widget.colors.mouseDown ;
    }
    if (mouseState.isMouseOver && isButtonDisabled == false) {
      return widget.dark ? widget.colors.mouseOverDark : widget.colors.mouseOver;
    }
    return widget.colors.normal;
  }

  Color getIconColor(MouseState mouseState) {
    if (mouseState.isMouseDown && isButtonDisabled == false) {
      return widget.dark ? widget.colors.iconMouseDownDark : widget.colors.iconMouseDown;
    }
    if (mouseState.isMouseOver && isButtonDisabled == false) {
      return widget.dark ? widget.colors.iconMouseOverDark : widget.colors.iconMouseOver;
    }
    if (windowIsFocused) {
      // print("focused");
      if (isButtonDisabled) return iconDisabled;
      // print(widget.dark);
      // print(iconNormalDark);
      return widget.dark? iconNormalDark : iconNormal;
    }
    // print("blurred");
    if (isButtonDisabled) return iconDisabledBlur;
    return iconNormalBlur;
  }

  void asyncInit() async {
    windowIsFocused = await windowManager.isFocused();
  }

  @override
  void initState() {
    iconNormal = widget.colors.iconNormal;
    iconNormalDark = widget.colors.iconNormalDark;
    iconNormalBlur = widget.colors.iconNormalBlur;
    iconDisabled = widget.colors.iconDisabled;
    iconDisabledBlur = widget.colors.iconDisabledBlur;
    isButtonDisabled = widget.disabled;
    asyncInit();
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    } else {
      // Don't show button on macOS
      if (Platform.isMacOS) {
        return Container();
      }
    }
    return MouseStateBuilder(builder: (context, mouseState) {
      WindowButtonContext buttonContext = WindowButtonContext(
          mouseState: mouseState,
          context: context,
          backgroundColor: getBackgroundColor(mouseState),
          iconColor: getIconColor(mouseState));

      var icon = (widget.iconBuilder != null)
          ? widget.iconBuilder!(buttonContext)
          : Container();
// double borderSize = appWindow.borderSize;
// double defaultPadding =
//     (appWindow.titleBarHeight - borderSize) / 3 - (borderSize / 2);
      /// Used when buttonContext.backgroundColor is null, allowing the AnimatedContainer to fade-out smoothly.
      var fadeOutColor =
          getBackgroundColor(MouseState()..isMouseOver = true).withOpacity(0);
      var padding = widget.padding ?? EdgeInsets.zero;
      var animationMs = widget.animate
          ? mouseState.isMouseOver
              ? 100
              : 150
          : 0;
      Widget iconWithPadding = Padding(padding: padding, child: icon);
      iconWithPadding = AnimatedContainer(
          curve: Curves.easeOut,
          duration: Duration(milliseconds: animationMs),
          color: buttonContext.backgroundColor ?? fadeOutColor,
          child: iconWithPadding);
      var button = (widget.builder != null)
          ? widget.builder!(buttonContext, icon)
          : iconWithPadding;
      return SizedBox(
          width: widget.buttonSize.width,
          height: widget.buttonSize.height,
          child: button);
    }, onPressed: () {
      if (widget.onPressed != null && isButtonDisabled == false) {
        widget.onPressed!();
      }
    });
  }

  @override
  void onWindowBlur() {
    windowIsFocused = false;
  }

  @override
  void onWindowFocus() {
    windowIsFocused = true;
  }

  @override
  void onWindowMinimize() {
    windowIsFocused = false;
  }

  @override
  void onWindowRestore() {
    windowIsFocused = true;
  }
}
