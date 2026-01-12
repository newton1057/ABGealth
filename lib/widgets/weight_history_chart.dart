import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WeightHistoryChart extends StatelessWidget {
  const WeightHistoryChart({
    super.key,
    required this.values,
    this.height = 140,
    this.lineColor = AppColors.primary,
  });

  final List<double> values;
  final double height;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _WeightHistoryPainter(
          values: values,
          lineColor: lineColor,
        ),
      ),
    );
  }
}

class _WeightHistoryPainter extends CustomPainter {
  _WeightHistoryPainter({required this.values, required this.lineColor});

  final List<double> values;
  final Color lineColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) {
      return;
    }

    final path = Path();
    final fillPath = Path();
    final spacing = size.width / (values.length - 1);

    for (var i = 0; i < values.length; i++) {
      final x = spacing * i;
      final y = size.height - (values[i].clamp(0.0, 1.0) * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevX = spacing * (i - 1);
        final prevY = size.height -
            (values[i - 1].clamp(0.0, 1.0) * size.height);
        final controlPoint = Offset((prevX + x) / 2, prevY);
        final controlPoint2 = Offset((prevX + x) / 2, y);
        path.cubicTo(
          controlPoint.dx,
          controlPoint.dy,
          controlPoint2.dx,
          controlPoint2.dy,
          x,
          y,
        );
      }
    }

    fillPath.addPath(path, Offset.zero);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final gradient = LinearGradient(
      colors: [
        lineColor.withOpacity(0.3),
        lineColor.withOpacity(0.05),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final fillPaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = lineColor;
    final dotStroke = Paint()
      ..color = AppColors.card
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < values.length; i++) {
      final x = spacing * i;
      final y = size.height - (values[i].clamp(0.0, 1.0) * size.height);
      canvas.drawCircle(Offset(x, y), 4.5, dotPaint);
      canvas.drawCircle(Offset(x, y), 4.5, dotStroke);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
