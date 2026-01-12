import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class CycleOnboardingScreen extends StatefulWidget {
  const CycleOnboardingScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<CycleOnboardingScreen> createState() => _CycleOnboardingScreenState();
}

class _CycleOnboardingScreenState extends State<CycleOnboardingScreen>
    with TickerProviderStateMixin {
  int _currentPage = 0;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const _mintBright = Color(0xFF55FFA9);
  static const _lavenderDark = Color(0xFF9C97D4);
  static const _background = Color(0xFFF8F5F2);

  final List<_CycleOnboardingPage> _pages = [
    _CycleOnboardingPage(
      title: 'Listo.',
      highlight: 'Estas en demood\ncorrecto!',
      subtitle: null,
      icon: Icons.check_circle_rounded,
    ),
    _CycleOnboardingPage(
      title: 'A partir de ahora comienzas tu',
      highlight: 'primer ciclo transformacional',
      subtitle: 'de 30 días con demood.',
      icon: Icons.autorenew_rounded,
    ),
    _CycleOnboardingPage(
      title: 'No necesitas hacerlo todo perfecto.',
      highlight: 'Solo enfocarte en\n4 cosas clave.',
      subtitle: null,
      icon: Icons.tune_rounded,
    ),
    _CycleOnboardingPage(
      title: 'Registrar tu alimentación.',
      highlight: null,
      subtitle:
          'Estar consciente es el primer paso y la IA nos dará recomendaciones.\n'
          'Toma foto de tu comida.',
      icon: Icons.camera_alt_rounded,
    ),
    _CycleOnboardingPage(
      title: 'Medir tu hidratación.',
      highlight: null,
      subtitle: 'Algo tan básico nos dará grandes cambios.',
      icon: Icons.water_drop_rounded,
    ),
    _CycleOnboardingPage(
      title: 'Moverte a tu ritmo,',
      highlight: 'pero moverte.',
      subtitle: null,
      icon: Icons.directions_run_rounded,
    ),
    _CycleOnboardingPage(
      title: 'Cuidar nuestro sueño.',
      highlight: null,
      subtitle: 'La recuperación será clave para cuidarnos.',
      icon: Icons.nightlight_round,
    ),
    _CycleOnboardingPage(
      title: 'Durante los próximos 30 días,',
      highlight: 'demood te ayudará a:',
      subtitle: '1️⃣ Registrar lo esencial\n'
          '2️⃣ Escuchar a tu cuerpo\n'
          '3️⃣ Ajustar pequeños hábitos\n'
          '4️⃣ Medir tu progreso real',
      icon: Icons.auto_graph_rounded,
    ),
    _CycleOnboardingPage(
      title: 'Nuestra IA se encarga del análisis.',
      highlight: null,
      subtitle: 'Tú solo enfócate en avanzar.',
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _nextPage() async {
    if (_currentPage < _pages.length - 1) {
      await Future.wait([
        _fadeController.reverse(),
        _slideController.reverse(),
      ]);

      setState(() {
        _currentPage++;
      });

      _fadeController.forward();
      _slideController.forward();
    } else {
      widget.onContinue();
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: _background,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildProgressIndicator(),
                const Spacer(flex: 1),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildIconContainer(page),
                  ),
                ),
                const SizedBox(height: 48),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildContent(page),
                  ),
                ),
                const Spacer(flex: 2),
                _buildNextButton(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isActive = index == _currentPage;
        final isPast = index < _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 32 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : isPast
                    ? _lavenderDark
                    : AppColors.border,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildIconContainer(_CycleOnboardingPage page) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            _lavenderDark.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: _lavenderDark.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Icon(
        page.icon,
        size: 56,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildContent(_CycleOnboardingPage page) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (page.title != null) ...[
          Text(
            page.title!,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          if (page.highlight != null) ...[
            const SizedBox(height: 4),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppColors.primary,
                  _lavenderDark,
                ],
              ).createShader(bounds),
              child: Text(
                page.highlight!,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ],
        if (page.subtitle != null) ...[
          if (page.title != null) const SizedBox(height: 20),
          Text(
            page.subtitle!,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNextButton() {
    final isLastPage = _currentPage == _pages.length - 1;

    return GestureDetector(
      onTap: _nextPage,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: _mintBright,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _mintBright.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLastPage ? 'Comenzar' : 'Siguiente',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isLastPage ? Icons.check_rounded : Icons.arrow_forward_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CycleOnboardingPage {
  final String? title;
  final String? highlight;
  final String? subtitle;
  final IconData icon;

  _CycleOnboardingPage({
    this.title,
    this.highlight,
    this.subtitle,
    required this.icon,
  });
}
