import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A modern shimmer loading placeholder widget
class AnimatedShimmer extends StatefulWidget {
  const AnimatedShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 16,
    this.child,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? child;

  @override
  State<AnimatedShimmer> createState() => _AnimatedShimmerState();
}

class _AnimatedShimmerState extends State<AnimatedShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: const [
                AppColors.shimmerBase,
                AppColors.shimmerHighlight,
                AppColors.shimmerBase,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Card-shaped shimmer placeholder for loading states
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key, this.height = 120, this.width});

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return AnimatedShimmer(width: width, height: height, borderRadius: 24);
  }
}

/// List item shimmer placeholder
class ShimmerListItem extends StatelessWidget {
  const ShimmerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const AnimatedShimmer(width: 48, height: 48, borderRadius: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AnimatedShimmer(
                  width: double.infinity,
                  height: 16,
                  borderRadius: 8,
                ),
                SizedBox(height: 8),
                AnimatedShimmer(width: 120, height: 12, borderRadius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
