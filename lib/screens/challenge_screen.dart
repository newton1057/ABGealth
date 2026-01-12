import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'change_screen.dart';
import 'meals_today_screen.dart';
import 'movement_today_screen.dart';
import 'sleep_rest_screen.dart';
import 'water_today_screen.dart';

class Challenge30Screen extends StatelessWidget {
  const Challenge30Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reto 30 días'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Día 6 de 30 - Vas increíble, ya llevas 4 días seguidos.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _ChallengePill(label: 'Día 6 de 30'),
                _ChallengePill(label: 'Racha actual: 4 días'),
              ],
            ),
            const SizedBox(height: 18),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                _ChallengeTile(
                  icon: Icons.restaurant_rounded,
                  title: 'Comidas de hoy',
                  subtitle: 'Tómale foto a lo que comes.',
                  color: AppColors.accentGreen,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MealsTodayScreen(),
                      ),
                    );
                  },
                ),
                _ChallengeTile(
                  icon: Icons.directions_walk,
                  title: 'Movimiento de hoy',
                  subtitle: 'Elige cómo te vas a mover.',
                  color: AppColors.accentTeal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MovementTodayScreen(),
                      ),
                    );
                  },
                ),
                _ChallengeTile(
                  icon: Icons.water_drop_outlined,
                  title: 'Agua de hoy',
                  subtitle: 'Suma un vaso ahora.',
                  color: AppColors.accentBlue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WaterTodayScreen(),
                      ),
                    );
                  },
                ),
                _ChallengeTile(
                  icon: Icons.nightlight_round,
                  title: 'Sueño & descanso',
                  subtitle: 'Fija tu hora para dormir.',
                  color: AppColors.accentIndigo,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SleepRestScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Progreso del reto',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 6 / 30,
              minHeight: 8,
              backgroundColor: AppColors.muted,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.accentGreen),
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 8),
            Text(
              'Has completado 6 / 30 días',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            _ChangeSummaryCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChangeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengePill extends StatelessWidget {
  const _ChallengePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentGreen.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.accentGreen,
        ),
      ),
    );
  }
}

class _ChallengeTile extends StatelessWidget {
  const _ChallengeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangeSummaryCard extends StatelessWidget {
  const _ChangeSummaryCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accentGreen.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.stacked_line_chart,
                color: AppColors.accentGreen,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mi cambio',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Revisa tu progreso y logros',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
