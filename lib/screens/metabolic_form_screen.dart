import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class MetabolicFormScreen extends StatefulWidget {
  const MetabolicFormScreen({super.key});

  @override
  State<MetabolicFormScreen> createState() => _MetabolicFormScreenState();
}

class _MetabolicFormScreenState extends State<MetabolicFormScreen> {
  int? _diabetesAnswer;
  int? _obesityAnswer;

  bool get _canFinish => _diabetesAnswer != null && _obesityAnswer != null;

  static const _mintBright = Color(0xFF55FFA9);
  static const _background = Color(0xFFF8F5F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              Text(
                'Formulario metabólico',
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Solo son un par de preguntas rápidas.',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              _buildQuestionCard(
                question:
                    '¿Ha habido casos de diabetes o colesterol alto en tu familia cercana?',
                options: const [
                  _OptionData(label: 'Sí', value: -1, color: Color(0xFF55FFA9)),
                  _OptionData(label: 'No', value: 1, color: Color(0xFFF97316)),
                  _OptionData(label: 'No lo sé', value: 0, color: Color(0xFF9C97D4)),
                ],
                selectedValue: _diabetesAnswer,
                onSelect: (value) {
                  setState(() {
                    _diabetesAnswer = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildQuestionCard(
                question: '¿Ha habido casos de obesidad en tu familia cercana?',
                options: const [
                  _OptionData(label: 'Sí', value: -1, color: Color(0xFF55FFA9)),
                  _OptionData(label: 'No', value: 1, color: Color(0xFFF97316)),
                  _OptionData(label: 'No lo sé', value: 0, color: Color(0xFF9C97D4)),
                ],
                selectedValue: _obesityAnswer,
                onSelect: (value) {
                  setState(() {
                    _obesityAnswer = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildFinishButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
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
          'Metabólico',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard({
    required String question,
    required List<_OptionData> options,
    required int? selectedValue,
    required ValueChanged<int> onSelect,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          ...options.map((option) {
            final isSelected = selectedValue == option.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildOptionCard(option, isSelected, onSelect),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    _OptionData option,
    bool isSelected,
    ValueChanged<int> onSelect,
  ) {
    return GestureDetector(
      onTap: () => onSelect(option.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? option.color.withValues(alpha: 0.12) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? option.color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? option.color : Colors.transparent,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: isSelected ? option.color : AppColors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              option.label,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? option.color : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return GestureDetector(
      onTap: _canFinish ? () => Navigator.pop(context) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: _canFinish ? _mintBright : AppColors.border,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _canFinish
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
                  color: _canFinish
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.check_rounded,
                color:
                    _canFinish ? AppColors.textPrimary : AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionData {
  final String label;
  final int value;
  final Color color;

  const _OptionData({
    required this.label,
    required this.value,
    required this.color,
  });
}
