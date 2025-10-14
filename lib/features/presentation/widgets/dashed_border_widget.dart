import 'package:flutter/material.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double radius, strokeWidth, dash, gap;
  final Color color;

  const DashedBorder({
    super.key,
    required this.child,
    this.radius = 6,
    this.strokeWidth = 1.2,
    this.dash = 6,
    this.gap = 4,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        radius: radius,
        strokeWidth: strokeWidth,
        dash: dash,
        gap: gap,
        color: color,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double radius, strokeWidth, dash, gap;
  final Color color;

  _DashedBorderPainter({
    required this.radius,
    required this.strokeWidth,
    required this.dash,
    required this.gap,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color;

    final dashed = _dashPath(path, dash, gap);
    canvas.drawPath(dashed, paint);
  }

  Path _dashPath(Path source, double dash, double gap) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dash;
        dest.addPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          Offset.zero,
        );
        distance = next + gap;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
