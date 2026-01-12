import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'activity_frequency_screen.dart';
import 'food_relation_screen.dart';

class ActivityCheckScreen extends StatefulWidget {
  const ActivityCheckScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<ActivityCheckScreen> createState() => _ActivityCheckScreenState();
}

class _ActivityCheckScreenState extends State<ActivityCheckScreen>
    with TickerProviderStateMixin {
  int? _selectedActivity;

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

  final List<ActivityOption> _activityOptions = [
    ActivityOption(
      title: 'Muy poco',
      emoji: '🛋️',
      description: 'Paso la mayor parte del día sentado',
      color: const Color(0xFFFF6B6B),
    ),
    ActivityOption(
      title: 'Un poco',
      emoji: '🚶',
      description: 'Camino algo pero no hago ejercicio regular',
      color: const Color(0xFFFFBE0B),
    ),
    ActivityOption(
      title: 'Bastante',
      emoji: '🏃',
      description: 'Entreno o me muevo algunos días a la semana',
      color: const Color(0xFF4ECDC4),
    ),
    ActivityOption(
      title: 'Mucho',
      emoji: '🏋️',
      description: 'Entreno duro o soy muy activo físicamente',
      color: const Color(0xFF55FFA9),
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

  void _selectActivity(int index) {
    setState(() {
      _selectedActivity = index;
    });
  }

  bool get _needsFrequency => _selectedActivity == 2 || _selectedActivity == 3;

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
                        const Color(0xFF4ECDC4).withValues(alpha: 0.15),
                        const Color(0xFF55FFA9).withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFF4ECDC4).withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.directions_run_rounded,
                    size: 48,
                    color: Color(0xFF4ECDC4),
                  ),
                ),
                const SizedBox(height: 32),
                // Title
                Text(
                  'No se trata de entrenar duro,',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF4ECDC4),
                      Color(0xFF55FFA9),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'sino de moverte a tu ritmo.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
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
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ..._activityOptions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        final isSelected = _selectedActivity == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildActivityCard(option, index, isSelected),
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
              'Paso 5 de 5',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '100%',
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
            widthFactor: 1.0,
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
            color: const Color(0xFF4ECDC4).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.directions_run_rounded,
                size: 16,
                color: Color(0xFF4ECDC4),
              ),
              const SizedBox(width: 6),
              Text(
                'Tu movimiento',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4ECDC4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'En tu semana típica,\n¿cuánto se mueve tu cuerpo?',
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

  Widget _buildActivityCard(ActivityOption option, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => _selectActivity(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? option.color.withValues(alpha: 0.12)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? option.color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: option.color.withValues(alpha: 0.2),
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
        child: Row(
          children: [
            // Emoji container
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected
                    ? option.color.withValues(alpha: 0.15)
                    : option.color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  option.emoji,
                  style: const TextStyle(fontSize: 26),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? option.color : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.description,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
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
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: isSelected ? option.color : Colors.transparent,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: isSelected ? option.color : AppColors.border,
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
    final hasSelection = _selectedActivity != null;
    return GestureDetector(
      onTap: hasSelection
          ? () {
              if (_needsFrequency) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ActivityFrequencyScreen(
                      onContinue: widget.onContinue,
                    ),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FoodRelationScreen(
                      onContinue: widget.onContinue,
                    ),
                  ),
                );
              }
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

class ActivityOption {
  final String title;
  final String emoji;
  final String description;
  final Color color;

  ActivityOption({
    required this.title,
    required this.emoji,
    required this.description,
    required this.color,
  });
}
