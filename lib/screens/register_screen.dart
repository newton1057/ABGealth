import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'onboarding_screen.dart';

// New register screen color palette (matching login)
class _RegisterColors {
  static const lavenderDark = Color(0xFF9C97D4);
  static const mintBright = Color(0xFF55FFA9);
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.onRegisterSuccess});

  final VoidCallback onRegisterSuccess;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    // Skip validation for demo - go directly to onboarding
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            OnboardingScreen(onRegisterSuccess: widget.onRegisterSuccess),
      ),
    );
  }

  double _getPasswordStrength(String password) {
    if (password.isEmpty) return 0;
    double strength = 0;
    if (password.length >= 6) strength += 0.25;
    if (password.length >= 8) strength += 0.15;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.2;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.2;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.2;
    return strength.clamp(0.0, 1.0);
  }

  Color _getStrengthColor(double strength) {
    if (strength < 0.3) return AppColors.warning;
    if (strength < 0.6) return AppColors.accentOrange;
    return AppColors.success;
  }

  String _getStrengthText(double strength) {
    if (strength < 0.3) return 'Débil';
    if (strength < 0.6) return 'Media';
    return 'Fuerte';
  }

  @override
  Widget build(BuildContext context) {
    final passwordStrength = _getPasswordStrength(_passwordController.text);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Background
          _buildBackgroundOrbs(),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Back button and title
                  _buildHeader(),
                  const SizedBox(height: 32),
                  // Register form
                  _buildRegisterForm(passwordStrength),
                  const SizedBox(height: 24),
                  // Login link
                  _buildLoginLink(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundOrbs() {
    return Stack(
      children: [
        // Top Right Orange Glow
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentOrange.withOpacity(0.3),
                  AppColors.accentOrange.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        // Center Left Primary Glow
        Positioned(
          top: 200,
          left: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryLight.withOpacity(0.2),
                  AppColors.primaryLight.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        // Bottom Right Teal Glow
        Positioned(
          bottom: -100,
          right: -50,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentTeal.withOpacity(0.2),
                  AppColors.accentTeal.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
        // Blur Mesh
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(color: Colors.transparent),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
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
        Text(
          'Crear cuenta',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary, // Dark text
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm(double passwordStrength) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenido',
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Completa tus datos para registrarte',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          // Name field
          _buildTextField(
            controller: _nameController,
            label: 'Nombre completo',
            hint: 'Tu nombre',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu nombre';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Email field
          _buildTextField(
            controller: _emailController,
            label: 'Correo electrónico',
            hint: 'tu@email.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu correo electrónico';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Ingresa un correo válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          // Password field
          _buildTextField(
            controller: _passwordController,
            label: 'Contraseña',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            onChanged: (_) => setState(() {}),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa una contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          // Password strength indicator
          if (_passwordController.text.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.muted,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: passwordStrength,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getStrengthColor(
                                passwordStrength,
                              ).withOpacity(0.6),
                              _getStrengthColor(passwordStrength),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _getStrengthText(passwordStrength),
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getStrengthColor(passwordStrength),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          // Confirm password field
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Confirmar contraseña',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                );
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirma tu contraseña';
              }
              if (value != _passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          // Terms checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() => _acceptTerms = value ?? false);
                  },
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: 'Acepto los ',
                    style: Theme.of(context).textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: 'Términos y Condiciones',
                        style: GoogleFonts.montserrat(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: ' y la '),
                      TextSpan(
                        text: 'Política de Privacidad',
                        style: GoogleFonts.montserrat(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Register button
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: _RegisterColors.mintBright,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _RegisterColors.mintBright.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FilledButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Crear cuenta',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary, // Dark text for contrast
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.muted,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: _RegisterColors.lavenderDark,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.warning),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Ya tienes cuenta? ',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Iniciar sesión',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
