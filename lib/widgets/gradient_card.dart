import 'package:flutter/material.dart';
import 'modern_glass_card.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({
    super.key,
    required this.colors,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 24,
    this.boxShadow,
  });

  final List<Color> colors;
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return ModernGlassCard(
      padding: padding,
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
      // If boxShadow was passed, we might need a way to support it or ignore it
      // since ModernGlassCard handles shadows via elevation.
      // For now, let's map existence of boxShadow to some elevation or just rely on ModernGlassCard's default.
      elevation: boxShadow != null ? 5 : 0,
      child: child,
    );
  }
}
