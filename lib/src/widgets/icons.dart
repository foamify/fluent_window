library fluent_window;

import 'dart:ui';

import 'package:flutter/widgets.dart';

// Switched to CustomPaint icons by https://github.com/esDotDev

/// Close
class CloseIcon extends StatelessWidget {
  final Color color;

  const CloseIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(_ClosePainter(color));
}

class _ClosePainter extends _IconPainter {
  _ClosePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    Paint p2 = getPaint(color.withOpacity(.2));
    List<Offset> cross = [];
    List<Offset> crossOutline = [];
    for (double i = 0; i < 10; i++) {
      cross.add(Offset(i, i));
      cross.add(Offset(i, 9 - i));
    }
    for (double i = 0; i < 9; i++) {
      if (i != 4) {
        crossOutline.add(Offset(i, i + 1));
        crossOutline.add(Offset(i + 1, i));
        crossOutline.add(Offset(i, 8 - i));
        crossOutline.add(Offset(i + 1, 9 - i));
      }
    }
    canvas.drawPoints(PointMode.points, cross, p);
    canvas.drawPoints(PointMode.points, crossOutline, p2);
  }
}

/// Maximize
class MaximizeIcon extends StatelessWidget {
  final Color color;

  const MaximizeIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(_MaximizePainter(color));
}

class _MaximizePainter extends _IconPainter {
  _MaximizePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width - 1, size.height - 1), p);
  }
}

/// Restore
class RestoreIcon extends StatelessWidget {
  final Color color;

  const RestoreIcon({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(
        _RestorePainter(color),
        size: const Size(9, 9),
      );
}

class _RestorePainter extends _IconPainter {
  _RestorePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawRect(Rect.fromLTRB(0, 2, size.width - 2, size.height), p);
    canvas.drawLine(const Offset(2, 2), const Offset(2, 0), p);
    canvas.drawLine(const Offset(2, 0), Offset(size.width, 0), p);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, size.height - 2), p);
    canvas.drawLine(Offset(size.width, size.height - 2),
        Offset(size.width - 2, size.height - 2), p);
  }
}

/// Minimize
class MinimizeIcon extends StatelessWidget {
  final Color color;

  const MinimizeIcon({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(_MinimizePainter(color));
}

class _MinimizePainter extends _IconPainter {
  _MinimizePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), p);
  }
}

/// Fullscreen Maximize
class FullScreenMaximizeIcon extends StatelessWidget {
  final Color color;

  const FullScreenMaximizeIcon({Key? key, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(
        _FullScreenMaximizePainter(color),
        size: const Size(9, 9),
      );
}

class _FullScreenMaximizePainter extends _IconPainter {
  _FullScreenMaximizePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawPoints(
        PointMode.points,
        [
          const Offset(0, 2),
          const Offset(0, 1),
          const Offset(0, 0),
          const Offset(1, 0),
          const Offset(2, 0),
          Offset(size.width, 2),
          Offset(size.width, 1),
          Offset(size.width, 0),
          Offset(size.width - 1, 0),
          Offset(size.width - 2, 0),
          Offset(0, size.height - 2),
          Offset(0, size.height - 1),
          Offset(0, size.height),
          Offset(1, size.height),
          Offset(2, size.height),
          Offset(size.width, size.height - 2),
          Offset(size.width, size.height - 1),
          Offset(size.width, size.height),
          Offset(size.width - 1, size.height),
          Offset(size.width - 2, size.height),
        ],
        p);
  }
}

/// Fullscreen Minimize
class FullScreenMinimizeIcon extends StatelessWidget {
  final Color color;

  const FullScreenMinimizeIcon({Key? key, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(
        _FullScreenMinimizePainter(color),
        size: const Size(9, 9),
      );
}

class _FullScreenMinimizePainter extends _IconPainter {
  _FullScreenMinimizePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint p = getPaint(color);
    canvas.drawPoints(
        PointMode.points,
        [
          const Offset(0, 2),
          const Offset(1, 2),
          const Offset(2, 0),
          const Offset(2, 1),
          const Offset(2, 2),
          Offset(size.width, 2),
          Offset(size.width - 1, 2),
          Offset(size.width - 2, 2),
          Offset(size.width - 2, 1),
          Offset(size.width - 2, 0),
          Offset(0, size.height - 2),
          Offset(1, size.height - 2),
          Offset(2, size.height),
          Offset(2, size.height - 1),
          Offset(2, size.height - 2),
          Offset(size.width, size.height - 2),
          Offset(size.width - 1, size.height - 2),
          Offset(size.width - 2, size.height - 2),
          Offset(size.width - 2, size.height - 1),
          Offset(size.width - 2, size.height),
        ],
        p);
  }
}

/// ShadowToggle
class ShadowToggleIcon extends StatelessWidget {
  final Color color;

  const ShadowToggleIcon({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _AlignedPaint(
        _ShadowTogglePainter(color),
        size: const Size(9, 9),
      );
}

class _ShadowTogglePainter extends _IconPainter {
  _ShadowTogglePainter(Color color) : super(color);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> rectangle = [];
    List<Offset> rectangleBehind = [];
    for (double i = 0; i <= 7; i++) {
      for (double j = 0; j <= 7; j++) {
        rectangle.add(Offset(i, j));
      }
    }
    for (double i = 8; i <= 9; i++) {
      for (double j = 2; j <= 8; j++) {
        rectangleBehind.add(Offset(j, i));
      }
    }
    for (double j = 2; j <= 9; j++) {
      rectangleBehind.add(Offset(9, j));
    }
    for (double j = 2; j <= 7; j++) {
      rectangleBehind.add(Offset(8, j));
    }
    Paint p = getPaint(color, style: PaintingStyle.fill);
    Paint p2 = getPaint(color.withOpacity(.375));
    canvas.drawPoints(PointMode.points, rectangle, p);
    canvas.drawPoints(PointMode.points, rectangleBehind, p2);
  }
}

/// Helpers
abstract class _IconPainter extends CustomPainter {
  _IconPainter(this.color);

  final Color color;

  @override
  bool shouldRepaint(covariant _IconPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class _AlignedPaint extends StatelessWidget {
  const _AlignedPaint(this.painter, {Key? key, this.size = const Size(10, 10)})
      : super(key: key);
  final CustomPainter painter;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: CustomPaint(size: size, painter: painter));
  }
}

Paint getPaint(Color color,
        {PaintingStyle style = PaintingStyle.stroke,
        bool isAntiAlias = false,
        double strokeWidth = 1}) =>
    Paint()
      ..color = color
      ..style = style
      ..isAntiAlias = isAntiAlias
      ..strokeWidth = strokeWidth;
