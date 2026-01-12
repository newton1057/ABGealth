import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ModernGlassCard extends StatefulWidget {
  const ModernGlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius,
    this.color,
    this.gradient,
    this.elevation = 0,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
    this.border,
    this.blurStrength = 12.0,
    this.enableHoverEffect = true,
    this.showHighlight = false,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Color? color;
  final Gradient? gradient;
  final double elevation;
  final VoidCallback? onTap;
  final Clip clipBehavior;
  final BoxBorder? border;
  final double blurStrength;
  final bool enableHoverEffect;
  final bool showHighlight;

  @override
  State<ModernGlassCard> createState() => _ModernGlassCardState();
}

class _ModernGlassCardState extends State<ModernGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap != null && widget.enableHoverEffect) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap != null && widget.enableHoverEffect) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null && widget.enableHoverEffect) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        widget.borderRadius ?? BorderRadius.circular(24);

    // Content container
    Widget content = Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color ?? AppColors.card.withOpacity(0.85),
        gradient: widget.gradient,
        borderRadius: effectiveBorderRadius,
        border:
            widget.border ?? Border.all(color: AppColors.glassBorder, width: 1),
      ),
      child: Stack(
        children: [
          // Child content
          widget.child,
          // Optional highlight overlay
          if (widget.showHighlight)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.glassHighlight,
                  borderRadius: BorderRadius.only(
                    topLeft: effectiveBorderRadius.topLeft,
                    topRight: effectiveBorderRadius.topRight,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    // Wrap with blur and shadows
    Widget card = Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        boxShadow: widget.elevation > 0
            ? [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.06),
                  blurRadius: 16 + widget.elevation,
                  offset: const Offset(0, 8),
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        clipBehavior: widget.clipBehavior,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurStrength,
            sigmaY: widget.blurStrength,
          ),
          child: content,
        ),
      ),
    );

    // Wrap with tap detector if needed
    if (widget.onTap != null) {
      card = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: widget.enableHoverEffect
            ? AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        borderRadius: effectiveBorderRadius,
                        boxShadow: _isPressed
                            ? [
                                BoxShadow(
                                  color: AppColors.shadowColor.withOpacity(
                                    0.03,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: child,
                    ),
                  );
                },
                child: card,
              )
            : card,
      );
    }

    return card;
  }
}
