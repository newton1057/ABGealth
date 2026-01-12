import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  bool _includeDeviceInfo = true;
  bool _includeLogs = false;
  bool _isLoading = false;
  final List<String> _attachments = [];

  final List<_ProblemCategory> _categories = [
    _ProblemCategory(
      id: 'crash',
      title: 'La app se cierra',
      icon: Icons.error_outline_rounded,
      color: AppColors.semaforoRojo,
    ),
    _ProblemCategory(
      id: 'slow',
      title: 'Funciona lento',
      icon: Icons.speed_rounded,
      color: AppColors.semaforoAmarillo,
    ),
    _ProblemCategory(
      id: 'sync',
      title: 'No sincroniza',
      icon: Icons.sync_problem_rounded,
      color: AppColors.accentBlue,
    ),
    _ProblemCategory(
      id: 'feature',
      title: 'Función no funciona',
      icon: Icons.build_circle_outlined,
      color: AppColors.accentIndigo,
    ),
    _ProblemCategory(
      id: 'ui',
      title: 'Problema visual',
      icon: Icons.visibility_outlined,
      color: AppColors.accentTeal,
    ),
    _ProblemCategory(
      id: 'other',
      title: 'Otro problema',
      icon: Icons.help_outline_rounded,
      color: AppColors.textSecondary,
    ),
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() => _isLoading = false);
        _showSuccessDialog();
      });
    } else if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Selecciona una categoría',
            style: GoogleFonts.montserrat(),
          ),
          backgroundColor: AppColors.semaforoRojo,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.semaforoVerde.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.semaforoVerde,
                size: 36,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Reporte enviado',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Gracias por ayudarnos a mejorar. Revisaremos tu reporte y te contactaremos si necesitamos más información.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Ticket #${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mintBright,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Aceptar',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addAttachment() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Agregar archivo',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                _buildAttachmentOption(
                  icon: Icons.camera_alt_rounded,
                  title: 'Tomar foto',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _attachments.add('screenshot_${_attachments.length + 1}.png');
                    });
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.photo_library_rounded,
                  title: 'Elegir de galería',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _attachments.add('image_${_attachments.length + 1}.jpg');
                    });
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.screenshot_rounded,
                  title: 'Captura de pantalla reciente',
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _attachments.add('screenshot_recent.png');
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: AppColors.textPrimary, size: 22),
                ),
                const SizedBox(width: 14),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildInfoCard(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('¿Qué tipo de problema es?'),
                      const SizedBox(height: 14),
                      _buildCategoryGrid(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Describe el problema'),
                      const SizedBox(height: 14),
                      _buildDescriptionField(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Archivos adjuntos'),
                      const SizedBox(height: 14),
                      _buildAttachmentSection(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Información adicional'),
                      const SizedBox(height: 14),
                      _buildAdditionalOptions(),
                    ],
                  ),
                ),
              ),
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Reportar problema',
            style: GoogleFonts.montserrat(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accentBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.accentBlue.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.accentBlue.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: AppColors.accentBlue,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Entre más detalles nos proporciones, más rápido podremos resolver tu problema.',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        final isSelected = _selectedCategory == category.id;

        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = category.id),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? category.color.withValues(alpha: 0.15) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? category.color : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  category.icon,
                  color: isSelected ? category.color : AppColors.textSecondary,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  category.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? category.color : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      maxLines: 5,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: '¿Qué pasó? ¿Qué estabas haciendo cuando ocurrió el problema?',
        hintStyle: GoogleFonts.montserrat(
          color: AppColors.textSecondary.withValues(alpha: 0.7),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.mintBright, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Describe el problema';
        }
        if (value.length < 20) {
          return 'Proporciona más detalles (mínimo 20 caracteres)';
        }
        return null;
      },
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      children: [
        if (_attachments.isNotEmpty) ...[
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _attachments.asMap().entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.image_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.value,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _attachments.removeAt(entry.key);
                        });
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: _addAttachment,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.muted,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.add_photo_alternate_rounded,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Agregar captura de pantalla',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalOptions() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            title: 'Incluir información del dispositivo',
            subtitle: 'Modelo, versión del SO, versión de la app',
            value: _includeDeviceInfo,
            onChanged: (value) => setState(() => _includeDeviceInfo = value),
          ),
          const Divider(height: 1, color: AppColors.border),
          _buildOptionTile(
            title: 'Incluir registros de la app',
            subtitle: 'Información técnica para diagnóstico',
            value: _includeLogs,
            onChanged: (value) => setState(() => _includeLogs = value),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.mintBright,
            activeTrackColor: AppColors.mintBright.withValues(alpha: 0.3),
            inactiveThumbColor: AppColors.textSecondary,
            inactiveTrackColor: AppColors.muted,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5F2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.mintBright,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.mintBright.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _isLoading ? null : _submitReport,
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.textPrimary,
                      ),
                    )
                  : Text(
                      'Enviar reporte',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProblemCategory {
  final String id;
  final String title;
  final IconData icon;
  final Color color;

  _ProblemCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
  });
}
