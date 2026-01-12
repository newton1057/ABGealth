import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/health_quadrants_widget.dart';
import 'change_screen.dart';
import 'challenge_screen.dart';
import 'meals_today_screen.dart';
import 'movement_today_screen.dart';
import 'notifications_screen.dart';
import 'sleep_rest_screen.dart';
import 'water_today_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HomeHeader(),
              const SizedBox(height: 16),
              const _StatusRow(),
              const SizedBox(height: 8),
              const HealthQuadrantsWidget(
                showProgressRing: true,
                progress: 0.75,
              ),
              const SizedBox(height: 20),
              const _ChallengeCard(showFutureWeeks: false),
              const SizedBox(height: 24),
              _buildSectionTitle('Hábitos diarios'),
              const SizedBox(height: 14),
              const _HabitsGrid(),
              const SizedBox(height: 20),
              const _ProgressCard(),
              const SizedBox(height: 20),
              const _SecurityNote(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar con borde mint
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.mintBright, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.mintBright.withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: -2,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.mintBright.withValues(alpha: 0.15),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.textPrimary,
              size: 26,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mintBright,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'MI PREVENCIÓN',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Hola, Claudia',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            ),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.mintBright,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentGreen.withValues(alpha: 0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Sincronizado',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accentGreen,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            'Hoy, 24 Oct',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({this.showFutureWeeks = true});

  final bool showFutureWeeks;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    const completedDays = 6;
    const challengeDays = 30;
    const streakColumns = 10;
    final completedCount =
        completedDays > daysInMonth ? daysInMonth : completedDays;
    final totalCells =
        ((daysInMonth + streakColumns - 1) ~/ streakColumns) * streakColumns;
    const previewMissedDays = <int>{2, 5};
    final dayCells = List<int?>.generate(totalCells, (index) {
      final dayNumber = index + 1;
      if (dayNumber > daysInMonth) {
        return null;
      }
      return dayNumber;
    });
    final weeks = <List<int?>>[];
    for (var i = 0; i < dayCells.length; i += streakColumns) {
      weeks.add(dayCells.sublist(i, i + streakColumns));
    }
    final visibleWeeks = showFutureWeeks
        ? weeks
        : weeks
            .where(
              (week) => week.any(
                (day) => day != null && day <= now.day,
              ),
            )
            .toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.flag_rounded,
                  color: AppColors.accentGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reto 30 días',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Día $completedDays de $challengeDays - sigue así',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 1),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: streakColumns,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              childAspectRatio: 1,
            ),
            itemCount: visibleWeeks.length * streakColumns,
            itemBuilder: (context, index) {
              final week = visibleWeeks[index ~/ streakColumns];
              final day = week[index % streakColumns];
              final isToday = day != null && day == now.day;
              final _StreakStatus status;
              if (day == null) {
                status = _StreakStatus.future;
              } else if (day == now.day) {
                status = _StreakStatus.partial;
              } else if (previewMissedDays.contains(day)) {
                status = _StreakStatus.missed;
              } else if (day <= completedCount) {
                status = _StreakStatus.completed;
              } else if (day < now.day) {
                status = _StreakStatus.missed;
              } else {
                status = _StreakStatus.future;
              }
              return Center(
                child: _StreakDay(
                  day: day,
                  status: status,
                  isToday: isToday,
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$completedDays de $challengeDays días completados',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _StreakStatus { completed, partial, missed, future }

class _StreakDay extends StatelessWidget {
  const _StreakDay({
    required this.day,
    required this.isToday,
    required this.status,
  });

  final int? day;
  final bool isToday;
  final _StreakStatus status;

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const SizedBox.shrink();
    }

    Color backgroundColor;
    Color borderColor;
    Color textColor;
    List<BoxShadow>? shadow;

    switch (status) {
      case _StreakStatus.completed:
        backgroundColor = AppColors.semaforoVerde;
        borderColor = AppColors.semaforoVerde;
        textColor = AppColors.textPrimary;
        shadow = [
          BoxShadow(
            color: AppColors.semaforoVerde.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ];
        break;
      case _StreakStatus.partial:
        backgroundColor = AppColors.semaforoAmarillo;
        borderColor = AppColors.semaforoAmarillo;
        textColor = AppColors.textPrimary;
        shadow = [
          BoxShadow(
            color: AppColors.semaforoAmarillo.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ];
        break;
      case _StreakStatus.missed:
        backgroundColor = AppColors.semaforoRojo;
        borderColor = AppColors.semaforoRojo;
        textColor = AppColors.textPrimary;
        shadow = [
          BoxShadow(
            color: AppColors.semaforoRojo.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ];
        break;
      case _StreakStatus.future:
        backgroundColor = Colors.white;
        borderColor = AppColors.border;
        textColor = AppColors.textSecondary;
        shadow = null;
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        final fontSize = (size * 0.38).clamp(8.0, 12.0);
        final borderWidth = isToday ? 2.0 : 1.0;

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: Border.all(
              color: isToday ? AppColors.textPrimary : borderColor,
              width: borderWidth,
            ),
            boxShadow: shadow,
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: GoogleFonts.montserrat(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HabitsGrid extends StatelessWidget {
  const _HabitsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
              MaterialPageRoute(builder: (_) => const MealsTodayScreen()),
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
              MaterialPageRoute(builder: (_) => const MovementTodayScreen()),
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
              MaterialPageRoute(builder: (_) => const WaterTodayScreen()),
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
              MaterialPageRoute(builder: (_) => const SleepRestScreen()),
            );
          },
        ),
      ],
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

class _HabitItem extends StatelessWidget {
  const _HabitItem({
    required this.icon,
    required this.title,
    required this.value,
    this.unit,
    required this.progress,
    this.trend,
    this.highlight = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? unit;
  final double progress;
  final String? trend;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: highlight ? Border.all(color: AppColors.mintBright, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: highlight
                ? AppColors.mintBright.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: highlight ? 12 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.textPrimary, size: 18),
              ),
              if (trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.mintBright,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trend!,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            title.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 3),
                Text(
                  unit!,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.muted,
              borderRadius: BorderRadius.circular(10),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      width: constraints.maxWidth * progress.clamp(0.0, 1.0),
                      decoration: BoxDecoration(
                        color: progress >= 0.8
                            ? AppColors.mintBright
                            : AppColors.textSecondary.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChangeScreen()),
          );
        },
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.mintBright,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mi progreso',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Ver reporte mensual',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppColors.textPrimary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecurityNote extends StatelessWidget {
  const _SecurityNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.muted.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_outline_rounded,
              size: 14,
              color: AppColors.accentGreen,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Tus datos están protegidos',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
