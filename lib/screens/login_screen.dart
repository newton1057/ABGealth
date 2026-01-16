import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';
import '../services/language_controller.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

// New login screen color palette
class _LoginColors {
  static const lavenderDark = Color(0xFF9C97D4);
  static const mintBright = Color(0xFF55FFA9); // New requested color
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  late LanguageController _languageController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageController = LanguageScope.of(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorBottomSheet(String message) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
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
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Error icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.warning,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  Text(
                    _text(
                      es: 'Error al iniciar sesión',
                      en: 'Sign-in error',
                    ),
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Message
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      style: FilledButton.styleFrom(
                        backgroundColor: _LoginColors.mintBright,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _text(
                          es: 'Intentar de nuevo',
                          en: 'Try again',
                        ),
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _authService.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Navigation is handled automatically by AuthWrapper
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        _showErrorBottomSheet(
          _authService.getErrorMessage(e, isEnglish: _isEnglish),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorBottomSheet(
          _text(
            es: 'Ocurrió un error. Intenta de nuevo.',
            en: 'Something went wrong. Please try again.',
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    if (_isGoogleLoading || _isLoading) return;

    setState(() => _isGoogleLoading = true);

    try {
      final result = await _authService.signInWithGoogle();
      if (result == null) {
        return;
      }
      // Navigation is handled automatically by AuthWrapper
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        _showErrorBottomSheet(
          _authService.getErrorMessage(e, isEnglish: _isEnglish),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorBottomSheet(
          _text(
            es: 'Ocurrió un error. Intenta de nuevo.',
            en: 'Something went wrong. Please try again.',
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
      }
    }
  }

  String _text({required String es, required String en}) {
    return _isEnglish ? en : es;
  }

  bool get _isEnglish => _languageController.isEnglish;

  String get _languageToggleLabel {
    return _isEnglish ? 'Switch to Spanish' : 'Cambiar a inglés';
  }

  void _toggleLanguage() {
    _languageController.toggle();
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
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, right: 16),
                child: _buildLanguageToggle(),
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

  Widget _buildLanguageToggle() {
    return Tooltip(
      message: _languageToggleLabel,
      child: Semantics(
        button: true,
        label: _languageToggleLabel,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggleLanguage,
            customBorder: const CircleBorder(),
            child: Container(
              width: 44,
              height: 44,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
                boxShadow: AppColors.softShadow,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: KeyedSubtree(
                  key: ValueKey(_isEnglish),
                  child: _buildFlag(isEnglish: _isEnglish),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlag({required bool isEnglish}) {
    final code = isEnglish ? 'US' : 'MX';

    return CountryFlag.fromCountryCode(
      code,
      theme: const ImageTheme(
        width: 28,
        height: 28,
        shape: Circle(),
      ),
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
              _text(
                es: 'Iniciar sesión',
                en: 'Sign in',
              ),
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              _text(
                es: 'Ingresa tus credenciales para continuar',
                en: 'Enter your credentials to continue',
              ),
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            // Email field
            _buildTextField(
              controller: _emailController,
              label: _text(
                es: 'Correo electrónico',
                en: 'Email',
              ),
              hint: _text(
                es: 'tu@email.com',
                en: 'you@email.com',
              ),
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return _text(
                    es: 'Ingresa tu correo electrónico',
                    en: 'Enter your email',
                  );
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return _text(
                    es: 'Ingresa un correo válido',
                    en: 'Enter a valid email',
                  );
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            // Password field
            _buildTextField(
              controller: _passwordController,
              label: _text(
                es: 'Contraseña',
                en: 'Password',
              ),
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
                  return _text(
                    es: 'Ingresa tu contraseña',
                    en: 'Enter your password',
                  );
                }
                if (value.length < 6) {
                  return _text(
                    es: 'La contraseña debe tener al menos 6 caracteres',
                    en: 'Password must be at least 6 characters',
                  );
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
                  _text(
                    es: '¿Olvidaste tu contraseña?',
                    en: 'Forgot your password?',
                  ),
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
                onPressed:
                    (_isLoading || _isGoogleLoading) ? null : _handleLogin,
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
                        _text(
                          es: 'Iniciar sesión',
                          en: 'Sign in',
                        ),
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
                    _text(
                      es: 'o continúa con',
                      en: 'or continue with',
                    ),
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
                          _text(
                            es: 'Continuar con Apple',
                            en: 'Continue with Apple',
                          ),
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
                  onTap: (_isLoading || _isGoogleLoading)
                      ? null
                      : _handleGoogleSignIn,
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
                          _text(
                            es: 'Continuar con Google',
                            en: 'Continue with Google',
                          ),
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (_isGoogleLoading) ...[
                          const SizedBox(width: 12),
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
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
          _text(
            es: '¿No tienes cuenta? ',
            en: "Don't have an account? ",
          ),
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
                builder: (_) => const RegisterScreen(),
              ),
            );
          },
          child: Text(
            _text(
              es: 'Crear cuenta',
              en: 'Create account',
            ),
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
