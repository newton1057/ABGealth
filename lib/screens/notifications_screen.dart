import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class _NotificationsColors {
  static const lavenderDark = Color(0xFF9C97D4);
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = [
      const _NotificationItem(
        title: 'Agua de hoy',
        message: 'Te faltan 0.5 L para completar tu meta.',
        time: '10:20',
        icon: Icons.water_drop_rounded,
        color: AppColors.accentBlue,
        isUnread: true,
      ),
      const _NotificationItem(
        title: 'Sueño y descanso',
        message: 'Guarda tu hora para dormir y mejora tu energia.',
        time: '09:05',
        icon: Icons.nightlight_round,
        color: AppColors.accentIndigo,
        isUnread: true,
      ),
      const _NotificationItem(
        title: 'Movimiento de hoy',
        message: 'Registra 15 minutos de caminata para tu reto.',
        time: '08:10',
        icon: Icons.directions_walk,
        color: AppColors.accentTeal,
      ),
    ];

    final week = [
      const _NotificationItem(
        title: 'Mi cambio',
        message: 'Tu progreso semanal ya esta listo para revisar.',
        time: 'Lun',
        icon: Icons.stacked_line_chart,
        color: AppColors.accentGreen,
      ),
      const _NotificationItem(
        title: 'Reto 30 dias',
        message: 'Llevas 4 dias seguidos. Sigue asi.',
        time: 'Dom',
        icon: Icons.flag_rounded,
        color: AppColors.accentGreen,
      ),
      const _NotificationItem(
        title: 'Recordatorio',
        message: 'Programa tus pastillas para la tarde.',
        time: 'Sab',
        icon: Icons.alarm_add_rounded,
        color: AppColors.warning,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _NotificationsHeader(),
              const SizedBox(height: 20),
              _SummaryCard(
                newCount: today.where((item) => item.isUnread).length,
              ),
              const SizedBox(height: 20),
              const _SectionTitle('Hoy'),
              const SizedBox(height: 12),
              ...today.map((item) => _NotificationTile(item: item)),
              const SizedBox(height: 20),
              const _SectionTitle('Esta semana'),
              const SizedBox(height: 12),
              ...week.map((item) => _NotificationTile(item: item)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationsHeader extends StatelessWidget {
  const _NotificationsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Notificaciones',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
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
            onPressed: () {},
            icon: const Icon(
              Icons.done_all_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.newCount});

  final int newCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _NotificationsColors.lavenderDark,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _NotificationsColors.lavenderDark.withValues(
                    alpha: 0.35,
                  ),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mintBright,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'HOY',
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Resumen de hoy',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tienes $newCount notificaciones nuevas.',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.mintBright.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Activas',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Divider(
            color: AppColors.border.withValues(alpha: 0.8),
            thickness: 1,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _NotificationItem {
  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
    this.isUnread = false,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color color;
  final bool isUnread;
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});

  final _NotificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.message,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.time,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                if (item.isUnread)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.mintBright,
                      shape: BoxShape.circle,
                    ),
                  )
                else
                  const Icon(
                    Icons.check_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
