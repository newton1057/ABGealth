import 'dart:math' as math;

import 'package:flutter/material.dart';

class RingSegment {
  const RingSegment({
    required this.progress,
    required this.color,
    this.strokeWidth = 14,
  });

  final double progress;
  final Color color;
  final double strokeWidth;
}

class ConcentricRingsChart extends StatelessWidget {
  const ConcentricRingsChart({
    super.key,
    required this.segments,
    this.size = 220,
    this.gap = 10,
    this.center,
  });

  final List<RingSegment> segments;
  final double size;
  final double gap;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ConcentricRingsPainter(segments: segments, gap: gap),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _ConcentricRingsPainter extends CustomPainter {
  _ConcentricRingsPainter({required this.segments, required this.gap});

  final List<RingSegment> segments;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    var radius = size.width / 2;

    for (final segment in segments) {
      final stroke = segment.strokeWidth;
      radius -= stroke / 2;

      final backgroundPaint = Paint()
        ..color = segment.color.withOpacity(0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;

      final foregroundPaint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;

      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, 0, math.pi * 2, false, backgroundPaint);
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * segment.progress,
        false,
        foregroundPaint,
      );

      radius -= stroke / 2 + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
