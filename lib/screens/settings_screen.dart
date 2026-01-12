import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'email_settings_screen.dart';
import 'help_center_screen.dart';
import 'contact_support_screen.dart';
import 'report_problem_screen.dart';
import 'terms_conditions_screen.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  bool _biometricEnabled = true;
  String _selectedLanguage = 'Español';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 28),
              _buildSectionTitle('Cuenta'),
              const SizedBox(height: 14),
              _SettingsTile(
                icon: Icons.person_outline_rounded,
                title: 'Editar perfil',
                subtitle: 'Nombre, foto y datos personales',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                ),
              ),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: 'Cambiar contraseña',
                subtitle: 'Actualiza tu contraseña',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                ),
              ),
              _SettingsTile(
                icon: Icons.email_outlined,
                title: 'Correo electrónico',
                subtitle: 'claudia@email.com',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmailSettingsScreen()),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Preferencias'),
              const SizedBox(height: 14),
              _SettingsToggle(
                icon: Icons.notifications_none_rounded,
                title: 'Notificaciones',
                subtitle: 'Recibir alertas y recordatorios',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() => _notificationsEnabled = value);
                },
              ),
              _SettingsToggle(
                icon: Icons.dark_mode_outlined,
                title: 'Modo oscuro',
                subtitle: 'Cambiar apariencia de la app',
                value: _darkMode,
                onChanged: (value) {
                  setState(() => _darkMode = value);
                },
              ),
              _SettingsSelector(
                icon: Icons.language_rounded,
                title: 'Idioma',
                value: _selectedLanguage,
                options: const ['Español', 'English', 'Português'],
                onChanged: (value) {
                  setState(() => _selectedLanguage = value);
                },
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Seguridad'),
              const SizedBox(height: 14),
              _SettingsToggle(
                icon: Icons.fingerprint_rounded,
                title: 'Autenticación biométrica',
                subtitle: 'Usar Face ID o huella digital',
                value: _biometricEnabled,
                onChanged: (value) {
                  setState(() => _biometricEnabled = value);
                },
              ),
              _SettingsTile(
                icon: Icons.security_rounded,
                title: 'Sesiones activas',
                subtitle: 'Administra tus dispositivos',
                onTap: () {},
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Soporte'),
              const SizedBox(height: 14),
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                title: 'Centro de ayuda',
                subtitle: 'Preguntas frecuentes',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
                ),
              ),
              _SettingsTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Contactar soporte',
                subtitle: 'Escríbenos por chat',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactSupportScreen()),
                ),
              ),
              _SettingsTile(
                icon: Icons.bug_report_outlined,
                title: 'Reportar un problema',
                subtitle: 'Ayúdanos a mejorar',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReportProblemScreen()),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Acerca de'),
              const SizedBox(height: 14),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'Versión de la app',
                subtitle: '1.0.0 (Build 1)',
                showChevron: false,
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: 'Términos y condiciones',
                subtitle: 'Políticas de uso',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TermsConditionsScreen()),
                ),
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Política de privacidad',
                subtitle: 'Cómo usamos tus datos',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                ),
              ),
              const SizedBox(height: 28),
              _buildDeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          'Configuración',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.semaforoRojo.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.semaforoRojo.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showDeleteAccountDialog();
          },
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline_rounded,
                color: AppColors.semaforoRojo,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                'Eliminar cuenta',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.semaforoRojo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          '¿Eliminar cuenta?',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.',
          style: GoogleFonts.montserrat(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement account deletion
            },
            child: Text(
              'Eliminar',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: AppColors.semaforoRojo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
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
                  child: Icon(
                    icon,
                    color: AppColors.textPrimary,
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
                if (showChevron)
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  const _SettingsToggle({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
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
              child: Icon(
                icon,
                color: AppColors.textPrimary,
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
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.mintBright,
              activeTrackColor: AppColors.mintBright.withValues(alpha: 0.3),
              inactiveThumbColor: AppColors.textSecondary,
              inactiveTrackColor: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSelector extends StatelessWidget {
  const _SettingsSelector({
    required this.icon,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showOptionsSheet(context),
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
                  child: Icon(
                    icon,
                    color: AppColors.textPrimary,
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
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.expand_more_rounded,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
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
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ...options.map((option) => _buildOptionTile(context, option)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String option) {
    final isSelected = option == value;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected
            ? AppColors.mintBright.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: () {
            onChanged(option);
            Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? AppColors.mintBright : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_rounded,
                    color: AppColors.mintBright,
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
