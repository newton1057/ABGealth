import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const _mintBright = Color(0xFF55FFA9);
  static const _lavenderDark = Color(0xFF9C97D4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Background
          _buildBackgroundOrbs(),

          // Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildHeader(context),
                ),
                const SizedBox(height: 24),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPrivacyContent(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                // Accept button
                _buildAcceptButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundOrbs() {
    return Stack(
      children: [
        // Top Right Orange Glow
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentOrange.withValues(alpha: 0.3),
                  AppColors.accentOrange.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        // Center Left Primary Glow
        Positioned(
          top: 200,
          left: -150,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryLight.withValues(alpha: 0.2),
                  AppColors.primaryLight.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        // Bottom Right Teal Glow
        Positioned(
          bottom: -100,
          right: -50,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accentTeal.withValues(alpha: 0.2),
                  AppColors.accentTeal.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        // Blur Mesh
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(color: Colors.transparent),
        ),
      ],
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
        Expanded(
          child: Text(
            'Politica de Privacidad',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        _buildSectionTitle('Aviso de Privacidad'),
        const SizedBox(height: 16),
        _buildParagraph(
          'Conforme a lo previsto en la Ley Federal de Proteccion de Datos Personales en Posesion de los Particulares (la "Ley"), y en cumplimiento de la obligacion a cargo de ABG Tech Capital Inc. (en adelante "demood") consistente en proteger los datos personales de sus clientes, suscriptores, instructores, asociados, trabajadores, proveedores y/o beneficiados de cualquiera de los productos, servicios o contratos pertenecientes a la operacion de nuestra empresa de consultoria, hacemos de su conocimiento lo siguiente:',
        ),
        const SizedBox(height: 24),

        // Tipos de Datos
        _buildSectionTitle('Tipos de Datos Accedidos o Recopilados'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Nuestra aplicacion, demood, accede y procesa datos relacionados con la salud para proporcionar herramientas de gestion y recomendaciones personalizadas. Los datos recopilados o accedidos incluyen, pero no se limitan a:',
        ),
        const SizedBox(height: 12),
        _buildBulletPoint(
            'Identificadores personales (como nombre, correo electronico y fecha de nacimiento) para crear perfiles de usuario.'),
        _buildBulletPoint(
            'Metricas de salud (como estatura, peso, nivel de actividad, presion arterial, calorias activas quemadas, distancia, sesion de ejercicio, pisos subidos, pasos, velocidad, frecuencia respiratoria, tasa metabolica basal, grasa corporal, calorias totales quemadas, hidratacion, nutricion, sesion de sueno, glucosa en sangre, presion arterial, temperatura corporal, saturacion de oxigeno, frecuencia cardiaca en reposo y frecuencia cardiaca) para calcular puntajes de salud personalizados y proporcionar recomendaciones accionables.'),
        _buildBulletPoint(
            'Datos de Ubicacion: Como la ubicacion aproximada o precisa del dispositivo. El uso especifico de estos datos se detalla mas adelante.'),
        _buildBulletPoint(
            'Datos de uso (como interacciones dentro de la aplicacion) para mejorar la experiencia del usuario y optimizar la funcionalidad de la aplicacion.'),
        const SizedBox(height: 24),

        // Proposito del Uso
        _buildSectionTitle('Proposito del Uso de los Datos'),
        const SizedBox(height: 12),
        _buildParagraph(
            'Los datos recopilados se utilizan para los siguientes fines:'),
        const SizedBox(height: 8),
        _buildBulletPoint(
            'Brindar recomendaciones de salud ultrapersonalizadas.'),
        _buildBulletPoint(
            'Monitorear y analizar tendencias de salud a lo largo del tiempo.'),
        _buildBulletPoint(
            'Habilitar funciones como la Bitacora Medica, el Arbol Genealogico de Salud y el demood Score para la gestion preventiva de la salud.'),
        _buildBulletPoint(
            'Mejorar la experiencia del usuario y el rendimiento de la aplicacion mediante el analisis de datos agregados.'),
        const SizedBox(height: 24),

        // Uso de Datos de Ubicacion
        _buildSectionTitle('Uso Especifico de los Datos de Ubicacion'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Para ofrecer una experiencia completa y funcional, nuestra aplicacion puede solicitar acceso a los datos de ubicacion de tu dispositivo. A continuacion, detallamos de forma exhaustiva como y por que accedemos, recogemos y usamos esta informacion:',
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
            'Integracion con Plataformas de Salud (Health Connect de Google):'),
        _buildParagraph(
          'La funcionalidad principal de nuestra app depende de la sincronizacion con servicios de salud como Health Connect de Google. La API de Health Connect requiere el permiso de ubicacion para descubrir y establecer conexiones seguras con dispositivos y sensores de salud cercanos. Sin este permiso, la sincronizacion automatica de datos clave podria no funcionar correctamente.',
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
            'Personalizacion de Contenido y Algoritmos de IA:'),
        _buildParagraph(
          'Utilizamos los datos de ubicacion para contextualizar tu actividad y ofrecerte recomendaciones mas precisas y relevantes. Esto permite que la personalizacion de la IA y la informacion de la app sean significativamente mas efectivas para ti.',
        ),
        const SizedBox(height: 12),
        _buildHighlightedBox(
          'Es importante destacar que los datos de ubicacion se utilizan exclusivamente para los fines funcionales mencionados. No vendemos ni compartimos tus datos de ubicacion precisos con terceros para fines publicitarios.',
        ),
        const SizedBox(height: 24),

        // Manejo Seguro de Datos
        _buildSectionTitle('Manejo Seguro de Datos'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Aplicamos medidas de seguridad estandar en la industria para proteger los datos de los usuarios, incluyendo protocolos de cifrado para la transmision y almacenamiento de datos. El acceso a los datos sensibles esta limitado unicamente a personal autorizado.',
        ),
        const SizedBox(height: 24),

        // Retencion y Eliminacion
        _buildSectionTitle('Politica de Retencion y Eliminacion de Datos'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Los datos recopilados a traves de demood se retienen unicamente mientras sea necesario para proporcionar nuestros servicios. Los usuarios pueden solicitar la eliminacion de sus datos en cualquier momento contactando al responsable de privacidad indicado a continuacion. Una vez que se verifique la solicitud de eliminacion, todos los datos personales se eliminaran permanentemente de nuestros sistemas en un plazo razonable.',
        ),
        const SizedBox(height: 24),

        // Contenido de los Datos Personales
        _buildSectionTitle('1. Contenido de los Datos Personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Para efectos del presente Aviso de Privacidad, de manera enunciativa mas no limitativa, se entenderan como "Datos Personales":',
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle('1.1. Datos generales:'),
        _buildParagraph(
          'demood recauda datos personales como nombre(s) y apellidos, fecha de nacimiento, genero, fotografia, RFC, CURP, correo electronico, telefono fijo, telefono celular, domicilio, entre otros similares.',
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle('1.2. Datos relacionados con membresias:'),
        _buildParagraph(
          'Nombre, domicilio, datos de tarjetas de credito/debito o cuenta CLABE.',
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle('1.3. Datos de terceros referidos:'),
        _buildParagraph(
          'Datos de personas que pudieran estar interesados en los servicios proporcionados por demood.',
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
            '1.4. Datos relacionados con solicitudes de empleo:'),
        _buildParagraph(
          'Nivel educativo, experiencia laboral, numero de seguridad social y curriculum vitae.',
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
            '1.5. Datos relacionados con la navegacion digital:'),
        _buildParagraph(
          'Uso de cookies, etiquetas y metadatos para identificar el dispositivo y mejorar la experiencia.',
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
            '1.6. Datos relacionados con el procesamiento de datos y consejos para el estilo de vida:'),
        _buildParagraph(
          'Datos biometricos, de morbilidad, de herencia y rutinas de vida.',
        ),
        const SizedBox(height: 24),

        // Persona responsable
        _buildSectionTitle(
            '2. Persona responsable de recabar datos personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'La persona responsable de recabar sus datos personales es demood. El domicilio para efectos de este aviso es 131 Continental Dr, Suite 305, City of Newmark, County of New Castle, Delaware 19713.',
        ),
        const SizedBox(height: 24),

        // Tratamiento
        _buildSectionTitle('3. Tratamiento de sus datos personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'El Tratamiento de Datos Personales por parte de demood se limitara al cumplimiento de las Finalidades previstas en este Aviso de Privacidad.',
        ),
        const SizedBox(height: 24),

        // Finalidades
        _buildSectionTitle(
            '4. Finalidades del tratamiento de datos personales'),
        const SizedBox(height: 12),
        _buildBulletPoint(
            'a). Fines de suscripcion (expediente, cobro, facturacion).'),
        _buildBulletPoint(
            'b). Publicidad (mercadotecnia, nuevos productos, eventos).'),
        _buildBulletPoint(
            'c). Servicios de procesamiento y recomendaciones (estadistica y consejos de estilo de vida).'),
        _buildBulletPoint('d). Reclutamiento y seleccion de personal.'),
        const SizedBox(height: 24),

        // Aceptacion
        _buildSectionTitle(
            '5. Aceptacion del tratamiento de datos personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'La aceptacion se podra realizar a traves de medios electronicos (al suscribirse), medios fisicos (en nuestras oficinas) o de forma tacita conforme a la Ley.',
        ),
        const SizedBox(height: 24),

        // Limitacion
        _buildSectionTitle(
            '6. Limitacion del uso o divulgacion de tus datos personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'demood realiza acciones de confidencialidad, administracion restringida de bases de datos y sistemas de computo protegidos para evitar el uso no autorizado.',
        ),
        const SizedBox(height: 24),

        // Derechos ARCO
        _buildSectionTitle(
            '7. Derechos de acceso, rectificacion, cancelacion u oposicion'),
        const SizedBox(height: 12),
        _buildParagraph(
          'demood ha designado al Departamento de Datos Personales para dar tramite a sus solicitudes:',
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(
            'Direccion: 131 Continental Dr, Suite 305, City of Newmark, County of New Castle, Delaware 19713.'),
        _buildBulletPoint('Correo electronico: direccion@abgtechcapital.com'),
        const SizedBox(height: 24),

        // Cambios
        _buildSectionTitle('8. Cambios al aviso de privacidad'),
        const SizedBox(height: 12),
        _buildParagraph(
          'demood se reserva el derecho de efectuar modificaciones en cualquier momento. El presente Aviso de Privacidad fue actualizado por ultima ocasion el 12 de enero de 2026.',
        ),
        const SizedBox(height: 24),

        // Transferencia
        _buildSectionTitle('9. Transferencia de datos personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'demood podra transferir sus Datos Personales a proveedores para cumplir con las finalidades de este aviso, bajo convenios de confidencialidad.',
        ),
        const SizedBox(height: 24),

        // Footer
        _buildHighlightedBox(
          'AL UTILIZAR DEMOOD, USTED CONFIRMA QUE HA LEIDO, ENTENDIDO Y ACEPTADO ESTE AVISO DE PRIVACIDAD EN SU TOTALIDAD.',
        ),
        const SizedBox(height: 16),
        _buildDateInfo('Ultima actualizacion: 12 de enero de 2026'),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.4,
      ),
    );
  }

  Widget _buildSubsectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.6,
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _lavenderDark,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _lavenderDark.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _lavenderDark.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildDateInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.background,
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
          color: _mintBright,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _mintBright.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FilledButton(
          onPressed: () => Navigator.pop(context),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Entendido',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
