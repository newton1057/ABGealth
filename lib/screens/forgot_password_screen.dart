import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/modern_glass_card.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate sending email
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
              AppColors.background,
            ],
            stops: const [0.0, 0.3, 0.5],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Back button and title
                _buildHeader(),
                const SizedBox(height: 48),
                // Form or success state
                _emailSent ? _buildSuccessState() : _buildForm(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        ModernGlassCard(
          borderRadius: BorderRadius.circular(14),
          elevation: 4,
          color: Colors.white.withOpacity(0.2),
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 44,
            height: 44,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          'Recuperar contraseña',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return ModernGlassCard(
      padding: const EdgeInsets.all(28),
      borderRadius: BorderRadius.circular(28),
      elevation: 10,
      showHighlight: true,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
                boxShadow: AppColors.glowShadow(AppColors.primary),
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¿Olvidaste tu contraseña?',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Text(
              'Ingresa tu correo electrónico y te enviaremos las instrucciones para restablecer tu contraseña.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 28),
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
            const SizedBox(height: 28),
            // Submit button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
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
                    : const Text(
                        'Enviar instrucciones',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            // Back to login
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Volver al inicio de sesión',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return ModernGlassCard(
      padding: const EdgeInsets.all(32),
      borderRadius: BorderRadius.circular(28),
      elevation: 10,
      showHighlight: true,
      child: Column(
        children: [
          // Success icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppColors.accentGreenGradient,
              shape: BoxShape.circle,
              boxShadow: AppColors.glowShadow(AppColors.accentGreen),
            ),
            child: const Icon(
              Icons.mark_email_read_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            '¡Correo enviado!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Hemos enviado las instrucciones para restablecer tu contraseña a:',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.muted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _emailController.text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Revisa tu bandeja de entrada y sigue las instrucciones. Si no recibes el correo, revisa tu carpeta de spam.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Volver al inicio de sesión',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() => _emailSent = false);
            },
            child: const Text(
              '¿No recibiste el correo? Reintentar',
              style: TextStyle(fontWeight: FontWeight.w600),
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
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
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
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
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
}
