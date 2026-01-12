import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  int selectedFilter = 0;

  final List<_ReminderItem> reminders = [
    _ReminderItem(
      title: 'Vitamina D',
      subtitle: 'Con comida',
      time: '08:00 AM',
      frequency: 'Diario',
      icon: Icons.medication_rounded,
      color: AppColors.warning,
      enabled: true,
    ),
    _ReminderItem(
      title: 'Agua',
      subtitle: 'Beber 1 vaso',
      time: '12:30 PM',
      frequency: 'Diario',
      icon: Icons.water_drop_rounded,
      color: AppColors.accentBlue,
      enabled: true,
    ),
    _ReminderItem(
      title: 'Caminata',
      subtitle: '15 min movimiento',
      time: '06:00 PM',
      frequency: 'Lun, Mie, Vie',
      icon: Icons.directions_walk,
      color: AppColors.accentTeal,
      enabled: false,
    ),
    _ReminderItem(
      title: 'Chequeo mensual',
      subtitle: 'Revisar presion y peso',
      time: '08:00 AM',
      frequency: '1 de cada mes',
      icon: Icons.favorite_border,
      color: AppColors.primary,
      enabled: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeCount = reminders.where((item) => item.enabled).length;
    final filters = const ['Todos', 'Medicinas', 'Habitos', 'Consultas'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recordatorios'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryCard(activeCount: activeCount, total: reminders.length),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(filters.length, (index) {
                final isSelected = selectedFilter == index;
                return ChoiceChip(
                  label: Text(filters[index]),
                  selected: isSelected,
                  selectedColor: AppColors.primary,
                  showCheckmark: false,
                  backgroundColor: AppColors.muted,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  onSelected: (_) {
                    setState(() => selectedFilter = index);
                  },
                );
              }),
            ),
            const SizedBox(height: 16),
            ...List.generate(reminders.length, (index) {
              final reminder = reminders[index];
              return _ReminderTile(
                reminder: reminder,
                onChanged: (value) {
                  setState(() => reminder.enabled = value);
                },
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Agregar recordatorio',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.activeCount, required this.total});

  final int activeCount;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.alarm, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recordatorios activos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  '$activeCount de $total activos hoy',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Hoy',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderItem {
  _ReminderItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.frequency,
    required this.icon,
    required this.color,
    required this.enabled,
  });

  final String title;
  final String subtitle;
  final String time;
  final String frequency;
  final IconData icon;
  final Color color;
  bool enabled;
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({required this.reminder, required this.onChanged});

  final _ReminderItem reminder;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: reminder.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(reminder.icon, color: reminder.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  reminder.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 6),
                Text(
                  '${reminder.time} · ${reminder.frequency}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: reminder.enabled,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
