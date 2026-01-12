import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HabitBarsChart extends StatelessWidget {
  const HabitBarsChart({
    super.key,
    required this.values,
    required this.colors,
    this.height = 80,
  });

  final List<double> values;
  final List<Color> colors;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (index) {
          final value = values[index].clamp(0.0, 1.0);
          final color = index < colors.length ? colors[index] : AppColors.primary;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _MiniBar(value: value, color: color),
            ),
          );
        }),
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  const _MiniBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Stack(
        children: [
          Container(color: AppColors.muted),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: value,
              child: Container(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
