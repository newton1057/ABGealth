import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'gender_check_screen.dart';

class AgeCheckScreen extends StatefulWidget {
  const AgeCheckScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  State<AgeCheckScreen> createState() => _AgeCheckScreenState();
}

class _AgeCheckScreenState extends State<AgeCheckScreen>
    with TickerProviderStateMixin {
  static const int _minAge = 10;
  static const int _maxAge = 100;
  static const int _defaultAge = 28;

  late FixedExtentScrollController _ageScrollController;
  int _selectedAge = _defaultAge;

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

  @override
  void initState() {
    super.initState();
    _ageScrollController = FixedExtentScrollController(
      initialItem: _defaultAge - _minAge,
    );

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
    _ageScrollController.dispose();
    _introController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  bool get _hasAge => _selectedAge >= _minAge;

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
                        AppColors.primary.withValues(alpha: 0.15),
                        _lavenderDark.withValues(alpha: 0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: _lavenderDark.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.cake_rounded,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Cada etapa importa,',
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
                      AppColors.primary,
                      _lavenderDark,
                    ],
                  ).createShader(bounds),
                  child: Text(
                    'para cuidarte mejor.',
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
              _buildAgePicker(),
              const Spacer(),
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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, _lavenderDark, _mintBright],
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
            color: _lavenderDark.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cake_rounded,
                size: 16,
                color: _lavenderDark,
              ),
              const SizedBox(width: 6),
              Text(
                'Tu perfil',
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
          '¿Cuántos años tienes?',
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

  Widget _buildAgePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tu edad',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: SizedBox(
            height: 200,
            child: CupertinoPicker(
              scrollController: _ageScrollController,
              itemExtent: 44,
              magnification: 1.1,
              squeeze: 1.15,
              useMagnifier: true,
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedAge = _minAge + index;
                });
              },
              selectionOverlay: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: _lavenderDark.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _lavenderDark.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
              ),
              children: List.generate(_maxAge - _minAge + 1, (index) {
                final age = _minAge + index;
                final isSelected = age == _selectedAge;
                return Center(
                  child: Text(
                    age.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: isSelected ? 24 : 18,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Desliza para elegir tu edad',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: _hasAge
          ? () {
              FocusScope.of(context).unfocus();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => GenderCheckScreen(
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
          color: _hasAge ? _mintBright : AppColors.border,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hasAge
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
                  color: _hasAge
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.check_rounded,
                color:
                    _hasAge ? AppColors.textPrimary : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
