import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'energy_check_screen.dart';

class BodyCheckScreen extends StatefulWidget {
  const BodyCheckScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<BodyCheckScreen> createState() => _BodyCheckScreenState();
}

class _BodyCheckScreenState extends State<BodyCheckScreen>
    with TickerProviderStateMixin {
  final Set<int> _selectedSymptoms = {};

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

  final List<SymptomOption> _symptoms = [
    SymptomOption(
      title: 'Cansancio frecuente',
      icon: Icons.battery_2_bar_rounded,
      color: const Color(0xFFFF6B6B),
    ),
    SymptomOption(
      title: 'Cambios de peso',
      icon: Icons.monitor_weight_outlined,
      color: const Color(0xFF4ECDC4),
    ),
    SymptomOption(
      title: 'Dolor recurrente',
      icon: Icons.healing_rounded,
      color: const Color(0xFFFFBE0B),
    ),
    SymptomOption(
      title: 'Problemas digestivos',
      icon: Icons.water_drop_outlined,
      color: const Color(0xFF845EC2),
    ),
    SymptomOption(
      title: 'Dolores de cabeza',
      icon: Icons.psychology_alt_rounded,
      color: const Color(0xFFFF9671),
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Intro animation controller
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

    // Question screen animation controller
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

    // Start animation sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Show intro title
    await Future.delayed(const Duration(milliseconds: 300));
    _introController.forward();

    // Wait, then transition to question screen
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      // Fade out intro
      await _introController.reverse();

      setState(() {
        _showQuestionScreen = true;
      });

      // Fade in question screen
      _questionController.forward();
    }
  }

  @override
  void dispose() {
    _introController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _toggleSymptom(int index) {
    setState(() {
      if (_selectedSymptoms.contains(-1)) {
        _selectedSymptoms.remove(-1);
      }
      if (_selectedSymptoms.contains(index)) {
        _selectedSymptoms.remove(index);
      } else {
        _selectedSymptoms.add(index);
      }
    });
  }

  void _selectNone() {
    setState(() {
      _selectedSymptoms.clear();
      _selectedSymptoms.add(-1);
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
                        AppColors.primary.withValues(alpha: 0.1),
                        _lavenderDark.withValues(alpha: 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: _lavenderDark.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_rounded,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  'Primero,',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppColors.primary,
                      _lavenderDark,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'escuchemos tu cuerpo',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
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
              // Progress indicator
              _buildProgressBar(),
              const SizedBox(height: 40),
              // Header
              _buildHeader(),
              const SizedBox(height: 24),
              // Symptoms grid
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSymptomsGrid(),
                      const SizedBox(height: 16),
                      _buildNoneOption(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              // Continue button
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
              'Paso 1 de 5',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '20%',
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
            widthFactor: 0.20,
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
            color: _lavenderDark.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.favorite_rounded,
                size: 16,
                color: _lavenderDark,
              ),
              const SizedBox(width: 6),
              Text(
                'Tu cuerpo',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _lavenderDark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'En los últimos meses,\n¿has notado alguno de estos?',
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

  Widget _buildSymptomsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: _symptoms.length,
      itemBuilder: (context, index) {
        final symptom = _symptoms[index];
        final isSelected = _selectedSymptoms.contains(index);
        return _buildSymptomCard(symptom, index, isSelected);
      },
    );
  }

  Widget _buildSymptomCard(SymptomOption symptom, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleSymptom(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: isSelected
              ? symptom.color.withValues(alpha: 0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? symptom.color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: symptom.color.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? symptom.color.withValues(alpha: 0.2)
                          : symptom.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      symptom.icon,
                      color: symptom.color,
                      size: 22,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isSelected ? symptom.color : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? symptom.color : AppColors.border,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                ],
              ),
              Text(
                symptom.title,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? symptom.color : AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoneOption() {
    final isSelected = _selectedSymptoms.contains(-1);
    return GestureDetector(
      onTap: _selectNone,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? _mintBright.withValues(alpha: 0.15)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _mintBright : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isSelected
                    ? _mintBright.withValues(alpha: 0.2)
                    : _mintBright.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: _mintBright,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                'Ninguno de estos',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? const Color(0xFF2D8F6F)
                      : AppColors.textPrimary,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? _mintBright : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? _mintBright : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final hasSelection = _selectedSymptoms.isNotEmpty;
    return GestureDetector(
      onTap: hasSelection
          ? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => EnergyCheckScreen(
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

class SymptomOption {
  final String title;
  final IconData icon;
  final Color color;

  SymptomOption({
    required this.title,
    required this.icon,
    required this.color,
  });
}
