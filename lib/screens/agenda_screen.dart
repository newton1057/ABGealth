import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/gradient_card.dart';
import '../widgets/modern_glass_card.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDay = 24;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: 16),
            _CalendarCard(selectedDay: selectedDay),
            const SizedBox(height: 18),
            const _AiTipCard(),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Hoy, 24 Oct',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 14),
            const _ScheduleItemCard(
              title: 'Suplemento de Vitamina D',
              subtitle: 'Hábito · Tomar con comida',
              time: '08:00 AM',
              icon: Icons.medication_rounded,
              color: AppColors.warning,
              isCompleted: false,
            ),
            const SizedBox(height: 12),
            const _ScheduleItemCard(
              title: 'Caminata de 15 min',
              subtitle: 'Hábito · Movimiento diario',
              time: '01:00 PM',
              icon: Icons.directions_walk,
              color: AppColors.accentBlue,
              isCompleted: false,
            ),
            const SizedBox(height: 12),
            const _ScheduleItemCard(
              title: 'Medicinas nocturnas',
              subtitle: 'Completado',
              time: '06:00 PM',
              icon: Icons.medical_services_rounded,
              color: AppColors.primary,
              isCompleted: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Agenda', style: Theme.of(context).textTheme.headlineSmall),
        const Spacer(),
        ModernGlassCard(
          borderRadius: BorderRadius.circular(14),
          elevation: 4,
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.search, size: 22),
        ),
        const SizedBox(width: 10),
        Stack(
          clipBehavior: Clip.none,
          children: [
            ModernGlassCard(
              borderRadius: BorderRadius.circular(50),
              elevation: 4,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withOpacity(0.1),
                      AppColors.primary.withOpacity(0.05),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.card, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentGreen.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard({required this.selectedDay});

  final int selectedDay;

  @override
  Widget build(BuildContext context) {
    const year = 2023;
    const month = 10;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstWeekday = DateTime(year, month, 1).weekday;
    final startOffset = firstWeekday - 1;
    final daysInPrevMonth = DateUtils.getDaysInMonth(year, month - 1);

    final cells = <_CalendarCell>[];
    for (var i = 0; i < startOffset; i++) {
      final day = daysInPrevMonth - startOffset + 1 + i;
      cells.add(_CalendarCell(day: day, isCurrentMonth: false));
    }
    for (var day = 1; day <= daysInMonth; day++) {
      cells.add(
        _CalendarCell(
          day: day,
          isCurrentMonth: true,
          isSelected: day == selectedDay,
        ),
      );
    }
    var nextMonthDay = 1;
    while (cells.length < 42) {
      cells.add(_CalendarCell(day: nextMonthDay, isCurrentMonth: false));
      nextMonthDay++;
    }

    return ModernGlassCard(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(26),
      elevation: 6,
      showHighlight: true,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_left, size: 20),
                  padding: EdgeInsets.zero,
                ),
              ),
              Expanded(
                child: Text(
                  'Octubre 2023',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right, size: 20),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _WeekdayLabel('L'),
              _WeekdayLabel('M'),
              _WeekdayLabel('X'),
              _WeekdayLabel('J'),
              _WeekdayLabel('V'),
              _WeekdayLabel('S'),
              _WeekdayLabel('D'),
            ],
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cells.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final cell = cells[index];
              final isCurrent = cell.isCurrentMonth;
              final isSelected = cell.isSelected;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.primaryGradient : null,
                  color: isSelected ? null : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? AppColors.glowShadow(AppColors.primary)
                      : null,
                ),
                child: Center(
                  child: Text(
                    '${cell.day}',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : isCurrent
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withOpacity(0.4),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  const _WeekdayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _CalendarCell {
  _CalendarCell({
    required this.day,
    required this.isCurrentMonth,
    this.isSelected = false,
  });

  final int day;
  final bool isCurrentMonth;
  final bool isSelected;
}

class _AiTipCard extends StatelessWidget {
  const _AiTipCard();

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      colors: const [Color(0xFF2B0B48), Color(0xFF7C2AE8)],
      borderRadius: 26,
      padding: const EdgeInsets.all(20),
      boxShadow: AppColors.glowShadow(AppColors.accentIndigo),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: Colors.white.withOpacity(0.9),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'TIP IA',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.6),
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Alerta de tráfico',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tienes 2 citas hoy. Sal 15 minutos antes por tráfico en Av. Central.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleItemCard extends StatelessWidget {
  const _ScheduleItemCard({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
    required this.isCompleted,
  });

  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return ModernGlassCard(
      padding: const EdgeInsets.all(18),
      borderRadius: BorderRadius.circular(22),
      elevation: 5,
      enableHoverEffect: true,
      showHighlight: !isCompleted,
      border: isCompleted
          ? Border.all(color: AppColors.success.withOpacity(0.3))
          : null,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isCompleted
                    ? [
                        AppColors.success.withOpacity(0.15),
                        AppColors.success.withOpacity(0.05),
                      ]
                    : [color.withOpacity(0.15), color.withOpacity(0.05)],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: (isCompleted ? AppColors.success : color).withOpacity(
                  0.15,
                ),
              ),
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isCompleted ? AppColors.success : color,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted
                        ? AppColors.textSecondary
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isCompleted ? AppColors.success : null,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  gradient: isCompleted ? AppColors.accentGreenGradient : null,
                  color: isCompleted ? null : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? AppColors.success : AppColors.border,
                    width: 2,
                  ),
                  boxShadow: isCompleted
                      ? [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.3),
                            blurRadius: 6,
                          ),
                        ]
                      : null,
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
