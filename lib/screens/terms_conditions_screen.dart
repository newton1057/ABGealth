import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
                    _buildSection(
                      title: '1. Aceptación de los Términos',
                      content:
                          'Al acceder y utilizar la aplicación demood ("la App"), usted acepta estar legalmente obligado por estos Términos y Condiciones. Si no está de acuerdo con alguno de estos términos, no debe utilizar la App.\n\nEstos términos constituyen un acuerdo legal entre usted y demood. El uso continuado de la App después de cualquier modificación de estos términos constituirá su aceptación de dichos cambios.',
                    ),
                    _buildSection(
                      title: '2. Descripción del Servicio',
                      content:
                          'demood es una aplicación de salud y bienestar que permite a los usuarios:\n\n• Registrar y monitorear hábitos de salud\n• Seguir su progreso en metas de bienestar\n• Recibir recordatorios personalizados\n• Conectar dispositivos wearables\n• Acceder a información de salud preventiva\n\nLa App no proporciona diagnósticos médicos ni sustituye la consulta con profesionales de la salud.',
                    ),
                    _buildSection(
                      title: '3. Registro y Cuenta de Usuario',
                      content:
                          'Para utilizar ciertas funciones de la App, debe crear una cuenta proporcionando información precisa y completa. Usted es responsable de:\n\n• Mantener la confidencialidad de su contraseña\n• Todas las actividades que ocurran bajo su cuenta\n• Notificarnos inmediatamente sobre cualquier uso no autorizado\n\nNos reservamos el derecho de suspender o terminar cuentas que violen estos términos.',
                    ),
                    _buildSection(
                      title: '4. Uso Aceptable',
                      content:
                          'Al utilizar la App, usted acepta NO:\n\n• Utilizar la App para fines ilegales\n• Intentar acceder a sistemas no autorizados\n• Transmitir virus o código malicioso\n• Hacerse pasar por otra persona\n• Recopilar información de otros usuarios\n• Interferir con el funcionamiento de la App\n• Usar la información para diagnósticos médicos sin consultar profesionales',
                    ),
                    _buildSection(
                      title: '5. Propiedad Intelectual',
                      content:
                          'Todo el contenido de la App, incluyendo pero no limitado a textos, gráficos, logos, iconos, imágenes, clips de audio, descargas digitales y compilaciones de datos, es propiedad de demood o sus proveedores de contenido y está protegido por leyes de propiedad intelectual.\n\nNo se le otorga ningún derecho de propiedad sobre el contenido al que accede a través de la App.',
                    ),
                    _buildSection(
                      title: '6. Datos de Salud',
                      content:
                          'Los datos de salud que usted ingresa en la App son de su exclusiva responsabilidad. demood:\n\n• No verifica la exactitud de los datos ingresados\n• No proporciona asesoramiento médico\n• Recomienda consultar con profesionales de salud\n• Procesa sus datos según nuestra Política de Privacidad\n\nLa información proporcionada es solo para fines informativos y de seguimiento personal.',
                    ),
                    _buildSection(
                      title: '7. Dispositivos de Terceros',
                      content:
                          'La App puede conectarse con dispositivos y servicios de terceros (wearables, apps de salud). demood no es responsable de:\n\n• La precisión de datos de dispositivos externos\n• El funcionamiento de servicios de terceros\n• Cambios en APIs o servicios externos\n• Pérdida de datos debido a terceros',
                    ),
                    _buildSection(
                      title: '8. Suscripciones y Pagos',
                      content:
                          'Algunas funciones de la App requieren una suscripción de pago:\n\n• Los precios se muestran antes de la compra\n• Las suscripciones se renuevan automáticamente\n• Puede cancelar en cualquier momento desde su tienda de apps\n• No se realizan reembolsos por períodos parciales\n• Los precios pueden cambiar con previo aviso',
                    ),
                    _buildSection(
                      title: '9. Limitación de Responsabilidad',
                      content:
                          'La App se proporciona "tal cual" y "según disponibilidad". demood no garantiza que:\n\n• La App funcione sin interrupciones\n• Los resultados sean precisos o confiables\n• La App cumpla sus expectativas específicas\n\nEn ningún caso demood será responsable por daños indirectos, incidentales, especiales o consecuentes.',
                    ),
                    _buildSection(
                      title: '10. Modificaciones',
                      content:
                          'Nos reservamos el derecho de modificar estos términos en cualquier momento. Los cambios entrarán en vigor inmediatamente después de su publicación en la App.\n\nSe le notificará sobre cambios significativos mediante la App o por correo electrónico. El uso continuado después de los cambios constituye aceptación.',
                    ),
                    _buildSection(
                      title: '11. Terminación',
                      content:
                          'Podemos terminar o suspender su acceso a la App inmediatamente, sin previo aviso, por cualquier razón, incluyendo violación de estos términos.\n\nUsted puede terminar su cuenta en cualquier momento desde la configuración de la App. Tras la terminación, su derecho a usar la App cesará inmediatamente.',
                    ),
                    _buildSection(
                      title: '12. Ley Aplicable',
                      content:
                          'Estos términos se regirán e interpretarán de acuerdo con las leyes de México, sin tener en cuenta sus disposiciones sobre conflictos de leyes.\n\nCualquier disputa relacionada con estos términos estará sujeta a la jurisdicción exclusiva de los tribunales de la Ciudad de México.',
                    ),
                    _buildSection(
                      title: '13. Contacto',
                      content:
                          'Si tiene preguntas sobre estos Términos y Condiciones, puede contactarnos:\n\n• Email: legal@demood.app\n• Soporte en la App: Configuración > Soporte\n• Sitio web: www.demood.app/legal',
                    ),
                    const SizedBox(height: 24),
                    _buildAcceptanceNote(),
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
              'Términos y Condiciones',
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
              Icons.update_rounded,
              color: AppColors.accentBlue,
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

  Widget _buildAcceptanceNote() {
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
            Icons.info_outline_rounded,
            color: AppColors.textSecondary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Al utilizar demood, usted confirma que ha leído, entendido y aceptado estos Términos y Condiciones en su totalidad.',
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
