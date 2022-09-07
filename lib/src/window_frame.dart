library fluent_window;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_window/src/global_vars.dart';
import 'package:fluent_window/src/widgets/clippers.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

class WindowFrame extends StatefulWidget {
  final Widget child;
  final bool active;
  final bool frameless;
  final bool movable;
  final bool enableWin10Borders;
  final bool enableWindowButtons;
  final bool enableCustomButtons;
  final bool enableResize;
  final bool resizeAboveButtons;
  final bool dark;
  final Size buttonSize;

  const WindowFrame({
    Key? key,
    required this.child,
    required this.active,
    required this.frameless,
    required this.movable,
    required this.enableWin10Borders,
    required this.enableWindowButtons,
    required this.enableCustomButtons,
    required this.enableResize,
    required this.dark,
    required this.resizeAboveButtons,
    this.buttonSize = const Size(46, 32),
  }) : super(key: key);

  @override
  State<WindowFrame> createState() => _WindowFrameState();
}

class _WindowFrameState extends State<WindowFrame> with WindowListener {
  final ValueNotifier<bool> isMaximised = ValueNotifier(false);
  final ValueNotifier<bool> isFullScreen = ValueNotifier(false);
  bool windowIsFocused = true;
  final borderColorFocus = const Color(0xA6262626);
  final borderColorBlur = const Color(0x81555555);

  void asyncInit() async {
    windowIsFocused = await windowManager.isFocused();
    isMaximised.value = await windowManager.isMaximized();
    isFullScreen.value = await windowManager.isFullScreen();
  }

  @override
  void initState() {
    windowManager.addListener(this);
    asyncInit();
    super.initState();
  }

  @override
  void onWindowBlur() {
    setState(() {
      windowIsFocused = false;
    });
  }

  @override
  void onWindowFocus() {
    setState(() {
      windowIsFocused = true;
    });
  }

  @override
  void onWindowMinimize() {
    setState(() {
      windowIsFocused = false;
    });
  }

  @override
  void onWindowRestore() {
    setState(() {
      windowIsFocused = true;
    });
  }

  @override
  void onWindowEnterFullScreen() {
    setState(() {
      isFullScreen.value = true;
    });
    super.onWindowEnterFullScreen();
  }

  @override
  void onWindowLeaveFullScreen() {
    isFullScreen.value = false;
    Future.delayed(
      const Duration(milliseconds: 30),
      () {
        setState(() {});
      },
    );
    super.onWindowLeaveFullScreen();
  }

  @override
  void onWindowMaximize() {
    setState(() {
      isMaximised.value = true;
    });
    super.onWindowMaximize();
  }

  @override
  void onWindowUnmaximize() {
    isMaximised.value = false;
    Future.delayed(
      const Duration(milliseconds: 30),
      () {
        setState(() {});
      },
    );
    super.onWindowUnmaximize();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return widget.child;
    // const borderWidth = 8.0;
    // const borderHeight = 8.0;
    return Stack(
      children: [
        /// App
        Container(
          padding: const EdgeInsets.all(1).copyWith(top: 0),
          decoration: BoxDecoration(
            border: (widget.enableWin10Borders &&
                    isMaximised.value == false &&
                    isFullScreen.value == false)
                ? Border(
                    top: BorderSide(
                        color: windowIsFocused
                            ? widget.dark
                                ? const Color(0xFF202020)
                                // ? const Color(0xFF242424)
                                // ? Colors.transparent
                                : borderColorFocus
                            : borderColorBlur,
                        width: 1),

                    /// on SetAsFrameless(), the bottom part of the app is cut off by
                    /// one pixel
                  )
                : null,
          ),
          child: ClipPath(
            /// Cut the app by one pixel in the bottom so the border isn't
            /// overlapped
            clipper: BorderClipper(),
            child: widget.child,
          ),
        ),

        if (widget.enableWin10Borders)
          IgnorePointer(
            ignoring: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(top: 1),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                      color:
                          windowIsFocused ? borderColorFocus : borderColorBlur,
                      width: 1),
                  right: BorderSide(
                      color:
                          windowIsFocused ? borderColorFocus : borderColorBlur,
                      width: 1),
                  bottom: BorderSide(
                      color:
                          windowIsFocused ? borderColorFocus : borderColorBlur,
                      width: 2),
                ),
              ),
            ),
          ),

        /// DragToMove
        if (widget.movable)
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: const DragToMoveArea(
                child: SizedBox(),
              ),
            ),
          ),

        /// Resizing widgets if resize area below buttons
        if (!widget.resizeAboveButtons && widget.enableResize)
          DragToResizeArea(
            enableResizeEdges: !isMaximised.value && !isFullScreen.value
                ? widget.frameless
                    ? [
                        ResizeEdge.topLeft,
                        ResizeEdge.topRight,
                        ResizeEdge.left,
                        ResizeEdge.right,
                        ResizeEdge.bottomLeft,
                        ResizeEdge.bottom,
                        ResizeEdge.bottomRight
                      ]
                    : []
                : [],
            child: const SizedBox(),
          ),
        if (!widget.resizeAboveButtons && widget.enableResize)
          DragToResizeArea(
            enableResizeEdges: !isMaximised.value && !isFullScreen.value
                ? widget.frameless
                    ? [
                        ResizeEdge.topLeft,
                        ResizeEdge.top,
                        ResizeEdge.topRight,
                      ]
                    : []
                : [],
            child: const SizedBox(),
          ),

        /// Buttons
        Buttons(
          widget.enableCustomButtons,
          widget.buttonSize,
          isFullScreen,
          widget.enableWindowButtons,
          isMaximised,
          widget.dark,
        ),

        /// Resizing widgets if resize area above buttons
        if (widget.resizeAboveButtons && widget.enableResize)
          DragToResizeArea(
            enableResizeEdges: !isMaximised.value && !isFullScreen.value
                ? widget.frameless
                    ? [
                        ResizeEdge.topLeft,
                        ResizeEdge.topRight,
                        ResizeEdge.left,
                        ResizeEdge.right,
                        ResizeEdge.bottomLeft,
                        ResizeEdge.bottom,
                        ResizeEdge.bottomRight
                      ]
                    : []
                : [],
            child: const SizedBox(),
          ),
        if (widget.resizeAboveButtons && widget.enableResize)
          DragToResizeArea(
            resizeEdgeMargin: const EdgeInsets.symmetric(horizontal: 8),
            enableResizeEdges: !isMaximised.value && !isFullScreen.value
                ? widget.frameless
                    ? [
                        ResizeEdge.topLeft,
                        ResizeEdge.top,
                        ResizeEdge.topRight,
                      ]
                    : []
                : [],
            child: const SizedBox(),
          ),
      ],
    );
  }
}

class Buttons extends StatefulWidget {
  final bool enableCustomButton;
  final Size buttonSize;
  final ValueNotifier<bool> isFullScreen;
  final bool enableWindowButtons;
  final ValueNotifier<bool> isMaximised;
  final bool dark;

  const Buttons(this.enableCustomButton, this.buttonSize, this.isFullScreen,
      this.enableWindowButtons, this.isMaximised, this.dark,
      {Key? key})
      : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.enableCustomButton)
          Positioned(
            top: 1,
            right: 184,
            child: ShadowToggleButton(
                dark: widget.dark, buttonSize: widget.buttonSize),
          ),
        if (widget.enableCustomButton)
          Positioned(
            top: 1,
            right: 138,
            child: ValueListenableBuilder(
                valueListenable: widget.isFullScreen,
                builder: (BuildContext context, bool value, Widget? child) =>
                    IndexedStack(
                      index: value ? 0 : 1,
                      children: [
                        FullScreenMinimizeWindowButton(
                          dark: widget.dark,
                          buttonSize: widget.buttonSize,
                        ),
                        FullScreenMaximizeWindowButton(
                          dark: widget.dark,
                          buttonSize: widget.buttonSize,
                        ),
                      ],
                    )),
          ),
        if (widget.enableWindowButtons)
          Positioned(
            top: 1,
            right: 92,
            child: MinimizeWindowButton(
              dark: widget.dark,
              buttonSize: widget.buttonSize,
            ),
          ),
        if (widget.enableWindowButtons)
          Positioned(
            top: 1,
            right: 46,
            child: ValueListenableBuilder(
              valueListenable: widget.isMaximised,
              builder: (BuildContext context, bool value, Widget? child) =>
                  IndexedStack(
                index: value ? 0 : 1,
                children: [
                  UnmaximizeWindowButton(
                    dark: widget.dark,
                  ),
                  ValueListenableBuilder(
                      valueListenable: widget.isFullScreen,
                      builder: (context, bool value, child) =>
                          MaximizeWindowButton(
                            dark: widget.dark,
                            disabled: value,
                            buttonSize: widget.buttonSize,
                          )),
                ],
              ),
            ),
          ),
        if (widget.enableWindowButtons)
          Positioned(
            top: 0,
            right: 0,
            child: CloseWindowButton(
              dark: widget.dark,
              buttonSize: widget.buttonSize,
            ),
          ),
      ],
    );
  }

  @override
  void onWindowBlur() {
    setState(() {});
  }

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  void onWindowMinimize() {
    setState(() {});
  }

  @override
  void onWindowRestore() {
    setState(() {});
  }
}

class AppTitle extends StatefulWidget {
  final String title;
  final Color focusColor;

  const AppTitle({Key? key, required this.title, required this.focusColor})
      : super(key: key);

  @override
  _AppTitleState createState() => _AppTitleState();
}

class _AppTitleState extends State<AppTitle> with WindowListener {
  bool windowIsFocused = true;

  void asyncInit() async {
    windowIsFocused = await windowManager.isFocused();
  }

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void onWindowBlur() {
    setState(() {
      windowIsFocused = false;
    });
  }

  @override
  void onWindowFocus() {
    setState(() {
      windowIsFocused = true;
    });
  }

  @override
  void onWindowMinimize() {
    setState(() {
      windowIsFocused = false;
    });
  }

  @override
  void onWindowRestore() {
    setState(() {
      windowIsFocused = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 12,
        color: windowIsFocused ? widget.focusColor : const Color(0xFF999999),
      ),
    );
  }
}
