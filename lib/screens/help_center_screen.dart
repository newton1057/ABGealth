import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'Todas';
  int? _expandedIndex;

  final List<String> _categories = [
    'Todas',
    'Cuenta',
    'Salud',
    'Dispositivos',
    'Pagos',
  ];

  final List<_FAQItem> _faqItems = [
    _FAQItem(
      category: 'Cuenta',
      question: '¿Cómo cambio mi contraseña?',
      answer:
          'Para cambiar tu contraseña, ve a Configuración > Cuenta > Cambiar contraseña. Ingresa tu contraseña actual y luego la nueva contraseña dos veces para confirmar.',
    ),
    _FAQItem(
      category: 'Cuenta',
      question: '¿Cómo elimino mi cuenta?',
      answer:
          'Puedes eliminar tu cuenta desde Configuración > Eliminar cuenta. Ten en cuenta que esta acción es irreversible y todos tus datos serán eliminados permanentemente.',
    ),
    _FAQItem(
      category: 'Salud',
      question: '¿Cómo registro mis comidas?',
      answer:
          'Desde la pantalla de Inicio, toca "Comidas de hoy" para acceder al registro de alimentación. Puedes tomar fotos de tus comidas o registrarlas manualmente.',
    ),
    _FAQItem(
      category: 'Salud',
      question: '¿Cómo funciona el reto de 30 días?',
      answer:
          'El reto de 30 días te ayuda a crear hábitos saludables. Cada día que completes tus objetivos (agua, comidas, ejercicio, sueño) se marcará como completado. Intenta mantener una racha sin días perdidos.',
    ),
    _FAQItem(
      category: 'Salud',
      question: '¿Cómo se calculan mis métricas de salud?',
      answer:
          'Tus métricas se calculan basándose en los datos que registras diariamente y la información de dispositivos conectados. El anillo de progreso muestra tu cumplimiento general de objetivos.',
    ),
    _FAQItem(
      category: 'Dispositivos',
      question: '¿Qué dispositivos puedo conectar?',
      answer:
          'Puedes conectar smartwatches y bandas de fitness como Apple Watch, Fitbit, Garmin, Samsung Galaxy Watch y más. Ve a Configuración > Dispositivos para ver la lista completa.',
    ),
    _FAQItem(
      category: 'Dispositivos',
      question: '¿Cómo sincronizo mi smartwatch?',
      answer:
          'Ve a Configuración > Dispositivos y selecciona "Agregar dispositivo". Asegúrate de que el Bluetooth esté activado y sigue las instrucciones en pantalla.',
    ),
    _FAQItem(
      category: 'Pagos',
      question: '¿La app es gratuita?',
      answer:
          'Sí, la app es gratuita con funciones básicas. Ofrecemos una suscripción premium con características adicionales como análisis avanzados, planes personalizados y más.',
    ),
    _FAQItem(
      category: 'Pagos',
      question: '¿Cómo cancelo mi suscripción?',
      answer:
          'Las suscripciones se administran a través de la tienda de aplicaciones (App Store o Google Play). Ve a la configuración de tu cuenta en la tienda correspondiente para cancelar.',
    ),
  ];

  List<_FAQItem> get _filteredFAQ {
    var items = _faqItems;

    if (_selectedCategory != 'Todas') {
      items = items.where((item) => item.category == _selectedCategory).toList();
    }

    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      items = items
          .where((item) =>
              item.question.toLowerCase().contains(query) ||
              item.answer.toLowerCase().contains(query))
          .toList();
    }

    return items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildCategoryChips(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredFAQ.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: _filteredFAQ.length,
                      itemBuilder: (context, index) {
                        return _buildFAQCard(_filteredFAQ[index], index);
                      },
                    ),
            ),
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
        Text(
          'Centro de ayuda',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.montserrat(
          fontSize: 15,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Buscar en preguntas frecuentes...',
          hintStyle: GoogleFonts.montserrat(
            color: AppColors.textSecondary,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = category),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.mintBright : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.mintBright : AppColors.border,
                  ),
                ),
                child: Text(
                  category,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFAQCard(_FAQItem item, int index) {
    final isExpanded = _expandedIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded ? AppColors.mintBright : AppColors.border,
            width: isExpanded ? 2 : 1,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppColors.mintBright.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _expandedIndex = isExpanded ? null : index;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(item.category).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.category,
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getCategoryColor(item.category),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.question,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.expand_more_rounded,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: AppColors.border),
                    const SizedBox(height: 8),
                    Text(
                      item.answer,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '¿Te fue útil?',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildFeedbackButton(Icons.thumb_up_outlined, true),
                        const SizedBox(width: 8),
                        _buildFeedbackButton(Icons.thumb_down_outlined, false),
                      ],
                    ),
                  ],
                ),
              ),
              crossFadeState:
                  isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackButton(IconData icon, bool isPositive) {
    return Material(
      color: AppColors.muted,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Gracias por tu feedback',
                style: GoogleFonts.montserrat(),
              ),
              backgroundColor: AppColors.semaforoVerde,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.muted,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No se encontraron resultados',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta con otras palabras clave',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Cuenta':
        return AppColors.accentBlue;
      case 'Salud':
        return AppColors.semaforoVerde;
      case 'Dispositivos':
        return AppColors.accentIndigo;
      case 'Pagos':
        return AppColors.semaforoAmarillo;
      default:
        return AppColors.textSecondary;
    }
  }
}

class _FAQItem {
  final String category;
  final String question;
  final String answer;

  _FAQItem({
    required this.category,
    required this.question,
    required this.answer,
  });
}
