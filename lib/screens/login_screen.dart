import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

// New login screen color palette
class _LoginColors {
  static const lavenderDark = Color(0xFF9C97D4);
  static const mintBright = Color(0xFF55FFA9); // New requested color
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginSuccess});

  final VoidCallback onLoginSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() => _isLoading = true);

    // Simulate login delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() => _isLoading = false);
      widget.onLoginSuccess();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 50),
                  // Logo and welcome
                  _buildHeader(),
                  const SizedBox(height: 32),
                  // Login form card
                  _buildLoginForm(),
                  const SizedBox(height: 20),
                  // Register link
                  _buildRegisterLink(),
                  const SizedBox(height: 32),
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
    return Column(
      children: [
        // Logo image
        Image.asset(
          'assets/images/icon.png',
          height: 60,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: _LoginColors
                    .lavenderDark, // Dark circle for icon visibility
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_hospital_rounded,
                color: Colors.white,
                size: 44,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Iniciar sesión',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Ingresa tus credenciales para continuar',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
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
                  return 'Ingresa tu contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            // Forgot password link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Login button
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: _LoginColors.mintBright,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _LoginColors.mintBright.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FilledButton(
                onPressed: _isLoading ? null : _handleLogin,
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
                        'Iniciar sesión',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors
                              .textPrimary, // Dark text for contrast on bright mint
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            // Divider
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'o continúa con',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Social login buttons vertical stack
            Column(
              children: [
                // Apple Button
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.apple, size: 24, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Continuar con Apple',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Google Button
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Official Google Logo Asset
                        Image.asset(
                          'assets/images/google_logo.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Continuar con Google',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
                color: _LoginColors.lavenderDark,
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

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta? ',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    RegisterScreen(onRegisterSuccess: widget.onLoginSuccess),
              ),
            );
          },
          child: Text(
            'Crear cuenta',
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
