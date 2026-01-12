import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'mood_check_screen.dart';

class EnergyCheckScreen extends StatefulWidget {
  const EnergyCheckScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<EnergyCheckScreen> createState() => _EnergyCheckScreenState();
}

class _EnergyCheckScreenState extends State<EnergyCheckScreen>
    with TickerProviderStateMixin {
  int? _selectedEnergy;

  // Animation controllers
  late AnimationController _introController;
  late AnimationController _questionController;
  late Animation<double> _introFadeAnimation;
  late Animation<Offset> _introSlideAnimation;
  late Animation<double> _questionFadeAnimation;
  late Animation<Offset> _questionSlideAnimation;

  bool _showQuestionScreen = false;

  static const _mintBright = Color(0xFF55FFA9);
  static const _lavenderDark = Color(0xFF9C97D4);
  static const _background = Color(0xFFF8F5F2);

  final List<EnergyOption> _energyOptions = [
    EnergyOption(
      title: 'Baja',
      description: 'Me siento cansado la mayor parte del tiempo',
      icon: Icons.battery_1_bar_rounded,
      color: const Color(0xFFFF6B6B),
    ),
    EnergyOption(
      title: 'Variable',
      description: 'Depende del día, a veces bien y a veces mal',
      icon: Icons.battery_4_bar_rounded,
      color: const Color(0xFFFFBE0B),
    ),
    EnergyOption(
      title: 'Buena',
      description: 'Generalmente me siento con energía',
      icon: Icons.battery_full_rounded,
      color: const Color(0xFF4ECDC4),
    ),
  ];

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _introFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOut),
    );

    _introSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutCubic),
    );

    _questionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _questionFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _questionController, curve: Curves.easeOut),
    );

    _questionSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _questionController, curve: Curves.easeOutCubic),
    );

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _introController.forward();

    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      await _introController.reverse();

      setState(() {
        _showQuestionScreen = true;
      });

      _questionController.forward();
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _selectEnergy(int index) {
    setState(() {
      _selectedEnergy = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _background,
        child: SafeArea(
          child: _showQuestionScreen ? _buildQuestionScreen() : _buildIntroScreen(),
        ),
      ),
    );
  }

  Widget _buildIntroScreen() {
    return FadeTransition(
      opacity: _introFadeAnimation,
      child: SlideTransition(
        position: _introSlideAnimation,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFBE0B).withValues(alpha: 0.15),
                        const Color(0xFFFF9671).withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFFFFBE0B).withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    size: 48,
                    color: Color(0xFFFFBE0B),
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  'Tu energía dice mucho',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFFFBE0B),
                      Color(0xFFFF9671),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'de cómo estás viviendo.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
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

  Widget _buildQuestionScreen() {
    return FadeTransition(
      opacity: _questionFadeAnimation,
      child: SlideTransition(
        position: _questionSlideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildProgressBar(),
              const SizedBox(height: 40),
              _buildHeader(),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ..._energyOptions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        final isSelected = _selectedEnergy == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildEnergyCard(option, index, isSelected),
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Paso 2 de 5',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '40%',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _lavenderDark,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.40,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, _lavenderDark],
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFBE0B).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bolt_rounded,
                size: 16,
                color: Color(0xFFFFBE0B),
              ),
              const SizedBox(width: 6),
              Text(
                'Tu energía',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFD4A00B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'En general, tu energía\ndiaria es…',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyCard(EnergyOption option, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => _selectEnergy(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? option.color.withValues(alpha: 0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? option.color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: option.color.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected
                    ? option.color.withValues(alpha: 0.2)
                    : option.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                option.icon,
                color: option.color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? option.color : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.description,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isSelected ? option.color : Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? option.color : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final hasSelection = _selectedEnergy != null;
    return GestureDetector(
      onTap: hasSelection
          ? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MoodCheckScreen(
                    onContinue: widget.onContinue,
                  ),
                ),
              );
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: hasSelection ? _mintBright : AppColors.border,
          borderRadius: BorderRadius.circular(16),
          boxShadow: hasSelection
              ? [
                  BoxShadow(
                    color: _mintBright.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continuar',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: hasSelection
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: hasSelection
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnergyOption {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  EnergyOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
