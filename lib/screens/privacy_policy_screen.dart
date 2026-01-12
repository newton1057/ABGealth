import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLastUpdated(),
                    const SizedBox(height: 24),
                    _buildIntroduction(),
                    const SizedBox(height: 24),
                    _buildDataCollectionSection(),
                    _buildSection(
                      title: '2. Cómo Utilizamos su Información',
                      content:
                          'Utilizamos la información recopilada para:\n\n• Proporcionar y mantener nuestros servicios\n• Personalizar su experiencia en la App\n• Enviar recordatorios y notificaciones\n• Generar estadísticas y reportes de progreso\n• Mejorar nuestros servicios\n• Comunicarnos con usted sobre actualizaciones\n• Prevenir fraude y garantizar la seguridad',
                    ),
                    _buildSection(
                      title: '3. Compartición de Datos',
                      content:
                          'No vendemos su información personal. Podemos compartir datos con:\n\n• Proveedores de servicios: Empresas que nos ayudan a operar la App (hosting, análisis, soporte)\n• Dispositivos conectados: Cuando sincroniza wearables\n• Requisitos legales: Si la ley lo requiere\n• Con su consentimiento: Cuando usted lo autorice explícitamente\n\nTodos nuestros proveedores están obligados a proteger su información.',
                    ),
                    _buildSection(
                      title: '4. Seguridad de los Datos',
                      content:
                          'Implementamos medidas de seguridad para proteger su información:\n\n• Encriptación de datos en tránsito y reposo\n• Autenticación segura\n• Acceso restringido a datos personales\n• Monitoreo continuo de seguridad\n• Copias de seguridad regulares\n\nNingún sistema es 100% seguro, pero trabajamos continuamente para proteger sus datos.',
                    ),
                    _buildDataRightsSection(),
                    _buildSection(
                      title: '6. Retención de Datos',
                      content:
                          'Conservamos su información mientras:\n\n• Mantenga una cuenta activa\n• Sea necesario para proporcionar servicios\n• Lo requiera la ley\n\nAl eliminar su cuenta, sus datos serán eliminados dentro de 30 días, excepto cuando debamos conservarlos por obligaciones legales.',
                    ),
                    _buildSection(
                      title: '7. Cookies y Tecnologías Similares',
                      content:
                          'Utilizamos tecnologías de seguimiento para:\n\n• Recordar sus preferencias\n• Analizar el uso de la App\n• Mejorar la experiencia del usuario\n\nPuede controlar estas tecnologías desde la configuración de su dispositivo.',
                    ),
                    _buildSection(
                      title: '8. Servicios de Terceros',
                      content:
                          'La App puede conectarse con servicios de terceros:\n\n• Apple Health / Google Fit\n• Dispositivos wearables\n• Servicios de autenticación (Google, Apple)\n\nCada servicio tiene su propia política de privacidad. Le recomendamos revisarlas antes de conectar su cuenta.',
                    ),
                    _buildSection(
                      title: '9. Menores de Edad',
                      content:
                          'La App no está dirigida a menores de 13 años. No recopilamos intencionalmente información de niños.\n\nSi es padre o tutor y cree que su hijo nos ha proporcionado información, contáctenos para eliminarla.',
                    ),
                    _buildSection(
                      title: '10. Transferencias Internacionales',
                      content:
                          'Sus datos pueden ser transferidos y procesados en servidores ubicados fuera de su país de residencia.\n\nNos aseguramos de que estas transferencias cumplan con las leyes de protección de datos aplicables y que existan salvaguardas adecuadas.',
                    ),
                    _buildSection(
                      title: '11. Cambios a esta Política',
                      content:
                          'Podemos actualizar esta política ocasionalmente. Le notificaremos sobre cambios significativos mediante:\n\n• Notificación en la App\n• Correo electrónico\n• Aviso en nuestra web\n\nLa fecha de "última actualización" al inicio indica cuándo se realizaron cambios.',
                    ),
                    _buildContactSection(),
                    const SizedBox(height: 24),
                    _buildConsentNote(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5F2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
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
              'Política de Privacidad',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.semaforoVerde.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.semaforoVerde.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.semaforoVerde.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.verified_user_rounded,
              color: AppColors.semaforoVerde,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Última actualización',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '1 de enero de 2025',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.privacy_tip_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Tu privacidad es importante',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'En demood, nos comprometemos a proteger su privacidad y sus datos personales. Esta política explica qué información recopilamos, cómo la usamos y sus derechos sobre ella.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCollectionSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. Información que Recopilamos',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDataTypeCard(
            icon: Icons.person_outline_rounded,
            title: 'Datos de cuenta',
            items: ['Nombre y apellidos', 'Correo electrónico', 'Fecha de nacimiento', 'Foto de perfil'],
            color: AppColors.accentBlue,
          ),
          const SizedBox(height: 12),
          _buildDataTypeCard(
            icon: Icons.favorite_outline_rounded,
            title: 'Datos de salud',
            items: ['Peso y altura', 'Horas de sueño', 'Consumo de agua', 'Actividad física', 'Alimentación'],
            color: AppColors.semaforoVerde,
          ),
          const SizedBox(height: 12),
          _buildDataTypeCard(
            icon: Icons.phone_android_rounded,
            title: 'Datos del dispositivo',
            items: ['Modelo de dispositivo', 'Sistema operativo', 'Identificadores únicos', 'Datos de uso'],
            color: AppColors.accentIndigo,
          ),
        ],
      ),
    );
  }

  Widget _buildDataTypeCard({
    required IconData icon,
    required String title,
    required List<String> items,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRightsSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5. Sus Derechos',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildRightItem(
            icon: Icons.visibility_rounded,
            title: 'Acceso',
            description: 'Solicitar una copia de sus datos personales',
          ),
          _buildRightItem(
            icon: Icons.edit_rounded,
            title: 'Rectificación',
            description: 'Corregir datos inexactos o incompletos',
          ),
          _buildRightItem(
            icon: Icons.delete_rounded,
            title: 'Eliminación',
            description: 'Solicitar que eliminemos sus datos',
          ),
          _buildRightItem(
            icon: Icons.file_download_rounded,
            title: 'Portabilidad',
            description: 'Exportar sus datos en formato legible',
          ),
          _buildRightItem(
            icon: Icons.block_rounded,
            title: 'Oposición',
            description: 'Oponerse al procesamiento de sus datos',
          ),
        ],
      ),
    );
  }

  Widget _buildRightItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.mintBright.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 20),
            ),
            const SizedBox(width: 14),
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
                    description,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.mail_outline_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                '12. Contacto',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Si tiene preguntas sobre esta Política de Privacidad o desea ejercer sus derechos, contáctenos:',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactItem(Icons.email_rounded, 'privacidad@demood.app'),
          _buildContactItem(Icons.language_rounded, 'www.demood.app/privacidad'),
          _buildContactItem(Icons.support_agent_rounded, 'Soporte en la App'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 18),
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: AppColors.semaforoVerde,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Al utilizar demood, usted consiente el procesamiento de sus datos personales de acuerdo con esta Política de Privacidad.',
              style: GoogleFonts.montserrat(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
