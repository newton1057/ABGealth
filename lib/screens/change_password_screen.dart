import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate password change
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() => _isLoading = false);
        _showSuccessDialog();
      });
    }
  }

  void _showSuccessDialog() {
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
                color: AppColors.semaforoVerde.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.semaforoVerde,
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Contraseña actualizada',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tu contraseña ha sido cambiada exitosamente.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back
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
                  'Aceptar',
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

  bool _hasMinLength(String password) => password.length >= 8;
  bool _hasUppercase(String password) => password.contains(RegExp(r'[A-Z]'));
  bool _hasLowercase(String password) => password.contains(RegExp(r'[a-z]'));
  bool _hasNumber(String password) => password.contains(RegExp(r'[0-9]'));
  bool _hasSpecialChar(String password) => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 32),
                      _buildInfoCard(),
                      const SizedBox(height: 28),
                      _buildPasswordField(
                        controller: _currentPasswordController,
                        label: 'Contraseña actual',
                        hint: 'Ingresa tu contraseña actual',
                        obscure: _obscureCurrentPassword,
                        onToggleObscure: () {
                          setState(() => _obscureCurrentPassword = !_obscureCurrentPassword);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa tu contraseña actual';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildPasswordField(
                        controller: _newPasswordController,
                        label: 'Nueva contraseña',
                        hint: 'Mínimo 8 caracteres',
                        obscure: _obscureNewPassword,
                        onToggleObscure: () {
                          setState(() => _obscureNewPassword = !_obscureNewPassword);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa una nueva contraseña';
                          }
                          if (value.length < 8) {
                            return 'Mínimo 8 caracteres';
                          }
                          if (!_hasUppercase(value) || !_hasLowercase(value)) {
                            return 'Debe incluir mayúsculas y minúsculas';
                          }
                          if (!_hasNumber(value)) {
                            return 'Debe incluir al menos un número';
                          }
                          return null;
                        },
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordStrengthIndicator(),
                      const SizedBox(height: 20),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        label: 'Confirmar contraseña',
                        hint: 'Repite la nueva contraseña',
                        obscure: _obscureConfirmPassword,
                        onToggleObscure: () {
                          setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirma tu contraseña';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 28),
                      _buildRequirementsList(),
                    ],
                  ),
                ),
              ),
            ),
            _buildChangeButton(),
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Cambiar contraseña',
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.semaforoAmarillo.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.semaforoAmarillo.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.semaforoAmarillo.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: AppColors.semaforoAmarillo,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Por seguridad, te recomendamos cambiar tu contraseña cada 3 meses.',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback onToggleObscure,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
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
          obscureText: obscure,
          validator: validator,
          onChanged: onChanged,
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
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: AppColors.textSecondary,
              size: 22,
            ),
            suffixIcon: IconButton(
              onPressed: onToggleObscure,
              icon: Icon(
                obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ),
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

  Widget _buildPasswordStrengthIndicator() {
    final password = _newPasswordController.text;
    int strength = 0;
    if (_hasMinLength(password)) strength++;
    if (_hasUppercase(password)) strength++;
    if (_hasLowercase(password)) strength++;
    if (_hasNumber(password)) strength++;
    if (_hasSpecialChar(password)) strength++;

    Color strengthColor;
    String strengthText;

    if (password.isEmpty) {
      strengthColor = AppColors.border;
      strengthText = '';
    } else if (strength <= 2) {
      strengthColor = AppColors.semaforoRojo;
      strengthText = 'Débil';
    } else if (strength <= 3) {
      strengthColor = AppColors.semaforoAmarillo;
      strengthText = 'Media';
    } else {
      strengthColor = AppColors.semaforoVerde;
      strengthText = 'Fuerte';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: strength >= 1 ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: strength >= 2 ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: strength >= 3 ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: strength >= 4 ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: strength >= 5 ? strengthColor : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        if (strengthText.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Seguridad: $strengthText',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: strengthColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRequirementsList() {
    final password = _newPasswordController.text;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Requisitos de la contraseña',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildRequirement('Mínimo 8 caracteres', _hasMinLength(password)),
          _buildRequirement('Una letra mayúscula', _hasUppercase(password)),
          _buildRequirement('Una letra minúscula', _hasLowercase(password)),
          _buildRequirement('Un número', _hasNumber(password)),
          _buildRequirement('Un carácter especial (!@#\$%)', _hasSpecialChar(password)),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle_rounded : Icons.circle_outlined,
            color: isMet ? AppColors.semaforoVerde : AppColors.textSecondary,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              color: isMet ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChangeButton() {
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
            onTap: _isLoading ? null : _changePassword,
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
                      'Cambiar contraseña',
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
