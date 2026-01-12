import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'modern_glass_card.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.unit = '',
    this.subtitle,
    this.trend,
    this.progress = 0,
    this.actionIcon,
    this.onTap,
    this.onActionTap,
  });

  final String title;
  final String value;
  final String unit;
  final String? subtitle;
  final String? trend;
  final IconData icon;
  final Color color;
  final double progress;
  final IconData? actionIcon;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return ModernGlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(24),
      elevation: 6,
      onTap: onTap,
      showHighlight: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon container with gradient background
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.18), color.withOpacity(0.08)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.15), width: 1),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              // Action button with hover effect
              GestureDetector(
                onTap: onActionTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor.withOpacity(0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    actionIcon ?? Icons.add,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Title with letter spacing
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          // Value with unit
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),
              if (unit.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Text(
                    unit,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (trend != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.success.withOpacity(0.12),
                    AppColors.success.withOpacity(0.06),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.trending_down, size: 12, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(
                    trend!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          // Animated gradient progress bar
          _AnimatedProgressBar(progress: progress, color: color),
        ],
      ),
    );
  }
}

class _AnimatedProgressBar extends StatelessWidget {
  const _AnimatedProgressBar({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.muted,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              // Animated progress fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.8), color],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              // Shimmer highlight effect
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcOver,
                    child: Container(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
