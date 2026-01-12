import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'modern_glass_card.dart';

/// A modern error state widget with retry functionality
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.message,
    this.title = 'Algo salió mal',
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: ModernGlassCard(
          padding: const EdgeInsets.all(24),
          borderRadius: BorderRadius.circular(24),
          elevation: 4,
          border: Border.all(
            color: AppColors.warning.withOpacity(0.3),
            width: 1,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error icon with gradient background
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.warning.withOpacity(0.15),
                      AppColors.warning.withOpacity(0.05),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: AppColors.warning),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Message
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Intentar de nuevo'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.warning,
                    side: BorderSide(color: AppColors.warning.withOpacity(0.5)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
