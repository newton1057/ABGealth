import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'cardio_form_screen.dart';
import 'metabolic_form_screen.dart';
import 'oncology_form_screen.dart';
import 'reminders_screen.dart';
import 'reports_screen.dart';
import 'studies_upload_screen.dart';

class _PreventionColors {
  static const boneWhite = Color(0xFFF8F5F2);
}

class PreventionScreen extends StatelessWidget {
  const PreventionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _PreventionColors.boneWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PreventionHeader(),
              const SizedBox(height: 8),
              Text(
                'Tu estado de prevención hoy',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatusItem(
                      title: 'Cardio',
                      icon: Icons.favorite_rounded,
                      color: AppColors.warning,
                      hasNotification: true,
                      notificationColor: AppColors.warning,
                      isCheck: false,
                      isWarning: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CardioFormScreen(),
                        ),
                      ),
                    ),
                    _StatusItem(
                      title: 'Metabólico',
                      icon: Icons.water_drop_rounded,
                      color: AppColors.accentTeal,
                      hasNotification: true,
                      notificationColor: AppColors.accentTeal,
                      isCheck: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MetabolicFormScreen(),
                        ),
                      ),
                    ),
                    _StatusItem(
                      title: 'Oncológico',
                      icon: Icons.shield_rounded,
                      color: AppColors.accentGreen,
                      hasNotification: true,
                      notificationColor: AppColors.accentGreen,
                      isCheck: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OncologyFormScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Divider(height: 32, color: AppColors.border),
              const SizedBox(height: 4),
              _ActionCard(
                title: 'Cargar estudios',
                subtitle: 'Sube tus últimos análisis',
                icon: Icons.upload_file_rounded,
                iconColor: AppColors.accentBlue,
                iconBgColor: AppColors.accentBlue.withValues(alpha: 0.12),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudiesUploadScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _ActionCard(
                title: 'Recordatorios',
                subtitle: 'Activar pastillero y alertas',
                icon: Icons.medical_services_rounded,
                iconColor: AppColors.accentGreen,
                iconBgColor: AppColors.accentGreen.withValues(alpha: 0.12),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RemindersScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _ActionCard(
                title: 'Mi registro',
                subtitle: 'Historial y seguimiento',
                icon: Icons.edit_note_rounded,
                iconColor: AppColors.accentOrange,
                iconBgColor: AppColors.accentOrange.withValues(alpha: 0.12),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReportsScreen()),
                ),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.muted.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.mintBright.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        size: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tus datos están protegidos y encriptados.',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreventionHeader extends StatelessWidget {
  const _PreventionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Mi prevención',
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
            onPressed: () => _showInfoModal(context),
            icon: const Icon(
              Icons.help_outline_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  void _showInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '¿Cómo funciona mi prevención?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Estas preguntas revisan antecedentes familiares para darte recomendaciones preventivas. No reemplaza una consulta médica.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mintBright,
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Entendido',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool hasNotification;
  final Color notificationColor;
  final bool isCheck;
  final bool isWarning;
  final VoidCallback? onTap;

  const _StatusItem({
    required this.title,
    required this.icon,
    required this.color,
    this.hasNotification = false,
    required this.notificationColor,
    this.isCheck = false,
    this.isWarning = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        SizedBox(
          width: 66,
          height: 66,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.muted,
                  border: Border.all(
                    color: color.withValues(alpha: 0.45),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.18),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              if (hasNotification)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: notificationColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        isCheck
                            ? Icons.check
                            : (isWarning
                                  ? Icons.priority_high
                                  : Icons.notifications),
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: content,
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback? onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
