import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'name_check_screen.dart';

class SubstancesCheckScreen extends StatefulWidget {
  const SubstancesCheckScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<SubstancesCheckScreen> createState() => _SubstancesCheckScreenState();
}

class _SubstancesCheckScreenState extends State<SubstancesCheckScreen>
    with TickerProviderStateMixin {
  int? _selectedSubstance;

  late AnimationController _introController;
  late AnimationController _questionController;
  late Animation<double> _introFadeAnimation;
  late Animation<Offset> _introSlideAnimation;
  late Animation<double> _questionFadeAnimation;
  late Animation<Offset> _questionSlideAnimation;

  bool _showQuestionScreen = false;

  static const _mintBright = Color(0xFF55FFA9);
  static const _amber = Color(0xFFF59E0B);
  static const _background = Color(0xFFF8F5F2);

  final List<SubstanceOption> _substanceOptions = [
    SubstanceOption(
      title: 'Alcohol',
      emoji: '🍺',
      color: Color(0xFFF59E0B),
    ),
    SubstanceOption(
      title: 'Tabaco',
      emoji: '🚬',
      color: Color(0xFF9CA3AF),
    ),
    SubstanceOption(
      title: 'Ninguno',
      emoji: '✅',
      color: Color(0xFF55FFA9),
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

  void _selectSubstance(int index) {
    setState(() {
      _selectedSubstance = index;
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
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _amber.withValues(alpha: 0.2),
                        _mintBright.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: _amber.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.spa_rounded,
                    size: 48,
                    color: _amber,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Sin juicios, solo contexto',
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
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      _amber,
                      _mintBright,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'para entender mejor tu día.',
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
                      ..._substanceOptions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final option = entry.value;
                        final isSelected = _selectedSubstance == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildSubstanceCard(option, index, isSelected),
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
              'Pregunta adicional',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              'Casi listo',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _amber,
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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, _amber, _mintBright],
              ),
              borderRadius: BorderRadius.circular(3),
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
            color: _amber.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.spa_rounded,
                size: 16,
                color: _amber,
              ),
              const SizedBox(width: 6),
              Text(
                'Tu bienestar',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _amber,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '¿Consumes algo de esto\ncon frecuencia?',
          style: GoogleFonts.montserrat(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  Widget _buildSubstanceCard(
    SubstanceOption option,
    int index,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () => _selectSubstance(index),
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
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                option.title,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? option.color : AppColors.textPrimary,
                ),
              ),
            ),
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
    final hasSelection = _selectedSubstance != null;
    return GestureDetector(
      onTap: hasSelection
          ? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => NameCheckScreen(
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
                'Finalizar',
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
                Icons.check_rounded,
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

class SubstanceOption {
  final String title;
  final String emoji;
  final Color color;

  SubstanceOption({
    required this.title,
    required this.emoji,
    required this.color,
  });
}
