import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class EmailSettingsScreen extends StatefulWidget {
  const EmailSettingsScreen({super.key});

  @override
  State<EmailSettingsScreen> createState() => _EmailSettingsScreenState();
}

class _EmailSettingsScreenState extends State<EmailSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newEmailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _showChangeForm = false;

  final String _currentEmail = 'claudia@email.com';
  final bool _isVerified = true;

  @override
  void dispose() {
    _newEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _changeEmail() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate email change
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() => _isLoading = false);
        _showVerificationSentDialog();
      });
    }
  }

  void _resendVerification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.email_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              'Correo de verificación enviado',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        backgroundColor: AppColors.semaforoVerde,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showVerificationSentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_rounded,
                color: AppColors.accentBlue,
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Verifica tu correo',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hemos enviado un enlace de verificación a:',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _newEmailController.text,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mintBright,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Entendido',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 32),
                    _buildCurrentEmailCard(),
                    const SizedBox(height: 20),
                    if (!_showChangeForm) ...[
                      _buildChangeEmailButton(),
                      const SizedBox(height: 28),
                      _buildEmailPreferences(),
                    ] else ...[
                      _buildChangeEmailForm(),
                    ],
                  ],
                ),
              ),
            ),
            if (_showChangeForm) _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
            onPressed: () {
              if (_showChangeForm) {
                setState(() => _showChangeForm = false);
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          _showChangeForm ? 'Cambiar correo' : 'Correo electrónico',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentEmailCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.email_rounded,
                  color: AppColors.accentBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correo actual',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _currentEmail,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _isVerified
                  ? AppColors.semaforoVerde.withValues(alpha: 0.1)
                  : AppColors.semaforoAmarillo.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isVerified
                    ? AppColors.semaforoVerde.withValues(alpha: 0.3)
                    : AppColors.semaforoAmarillo.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isVerified ? Icons.verified_rounded : Icons.warning_amber_rounded,
                  color: _isVerified ? AppColors.semaforoVerde : AppColors.semaforoAmarillo,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _isVerified ? 'Correo verificado' : 'Pendiente de verificación',
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _isVerified ? AppColors.semaforoVerde : AppColors.semaforoAmarillo,
                  ),
                ),
              ],
            ),
          ),
          if (!_isVerified) ...[
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _resendVerification,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(
                'Reenviar verificación',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChangeEmailButton() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => setState(() => _showChangeForm = true),
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
                child: const Icon(
                  Icons.edit_rounded,
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
                      'Cambiar correo',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Actualiza tu dirección de correo',
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
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

  Widget _buildEmailPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notificaciones por correo',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 14),
        _buildEmailPreferenceItem(
          title: 'Resumen semanal',
          subtitle: 'Recibe un resumen de tu progreso',
          value: true,
        ),
        _buildEmailPreferenceItem(
          title: 'Recordatorios',
          subtitle: 'Alertas de medicamentos y citas',
          value: true,
        ),
        _buildEmailPreferenceItem(
          title: 'Novedades',
          subtitle: 'Nuevas funciones y actualizaciones',
          value: false,
        ),
        _buildEmailPreferenceItem(
          title: 'Promociones',
          subtitle: 'Ofertas y descuentos especiales',
          value: false,
        ),
      ],
    );
  }

  Widget _buildEmailPreferenceItem({
    required String title,
    required String subtitle,
    required bool value,
  }) {
    return StatefulBuilder(
      builder: (context, setItemState) {
        bool isEnabled = value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
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
                  value: isEnabled,
                  onChanged: (newValue) {
                    setItemState(() => isEnabled = newValue);
                  },
                  activeThumbColor: AppColors.mintBright,
                  activeTrackColor: AppColors.mintBright.withValues(alpha: 0.3),
                  inactiveThumbColor: AppColors.textSecondary,
                  inactiveTrackColor: AppColors.muted,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChangeEmailForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.accentBlue.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.accentBlue,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Recibirás un correo de verificación en tu nueva dirección.',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildFormField(
            controller: _newEmailController,
            label: 'Nuevo correo electrónico',
            hint: 'tu@nuevomail.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu nuevo correo';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Ingresa un correo válido';
              }
              if (value == _currentEmail) {
                return 'El correo debe ser diferente al actual';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildFormField(
            controller: _passwordController,
            label: 'Confirma tu contraseña',
            hint: 'Ingresa tu contraseña actual',
            icon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.montserrat(
              color: AppColors.textSecondary.withValues(alpha: 0.6),
            ),
            prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 22),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.mintBright, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.semaforoRojo),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5F2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.mintBright,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.mintBright.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isLoading ? null : _changeEmail,
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.textPrimary,
                      ),
                    )
                  : Text(
                      'Actualizar correo',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
