import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

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
                        _buildTermsContent(),
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
            'Terminos y condiciones',
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

  Widget _buildTermsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        _buildSectionTitle(
            'Terminos y condiciones de uso de la Plataforma Digital demood'),
        const SizedBox(height: 16),
        _buildParagraph(
          'El presente documento es un acuerdo vinculante entre el usuario (en lo sucesivo "USUARIO" o "USTED") y ABG Tech Capital Inc. (en lo sucesivo "LA EMPRESA") que establece los terminos y condiciones (en lo sucesivo el "ACUERDO") para el uso y aprovechamiento de la Plataforma Digital demood (en lo sucesivo "demood"). El presente ACUERDO resulta aplicable a todas las actividades e interaccion que realice el USUARIO dentro de demood, las aplicaciones moviles relacionadas, y todos los demas servicios vinculados (en lo sucesivo los "SERVICIOS").',
        ),
        const SizedBox(height: 24),

        // Uso de la Plataforma
        _buildSectionTitle('Uso de la Plataforma demood'),
        const SizedBox(height: 12),
        _buildParagraph(
          'La plataforma proporciona a nuestros usuarios una guia de salud y ofrece muchas caracteristicas como las siguientes: asistencia e informacion de salud personalizada, funcionalidad de seguimiento de sintomas y acceso a nuestra base de datos medicos ("Biblioteca medica") impulsada por el sistema de inteligencia artificial unico de demood.',
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          'La guia y asistencia de salud esta disponible como una aplicacion que se puede descargar gratuitamente a traves de su dispositivo movil (en lo sucesivo, la "Aplicacion de demood"), y (cuando y donde este disponible) a traves de nuestra aplicacion basada en la web (en lo sucesivo, el "Sitio Web"). demood tambien ha desarrollado una herramienta de evaluacion (en lo sucesivo denominada "Herramienta de evaluacion") y servicios relacionados. El Sitio Web, la Aplicacion de demood y la Herramienta de evaluacion, incluyendo cualquier software, servicio u otra tecnologia en la que se basen, se denominaran en adelante la "Plataforma de demood".',
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          'La plataforma demood le ofrece la oportunidad de averiguar su estado de salud, asi como darle recomendaciones para su estilo de vida basadas en sus respuestas (sin que pueda sustituir el consejo o asesoria de un experto medico con patente medica). La Plataforma de demood utiliza una base de documentos que contienen conocimientos medicos y cientificos para recomendaciones de bienestar (en lo sucesivo, el "Informe de evaluacion").',
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          'La plataforma demood se le proporciona por distintos canales de distribucion y se le permite realizar un numero ilimitado de solicitudes de asistencia de salud, recomendaciones y evaluacion.',
        ),
        const SizedBox(height: 12),
        _buildHighlightedBox(
          'Por favor, tenga en cuenta que proporcionamos la plataforma demood unicamente con fines informativos. No es una consulta medica. La plataforma demood no es un sustituto adecuado para el asesoramiento medico obtenido de su medico, medico general u otro proveedor de servicios de salud. La plataforma demood NO proporciona diagnosticos para condiciones medicas, ni prescribe como tratar cualquier problema medico que pueda tener. Esto solo puede hacerse consultando a un profesional medico.',
        ),
        const SizedBox(height: 24),

        // Uso referencial
        _buildSectionTitle('Uso referencial y responsabilidad'),
        const SizedBox(height: 12),
        _buildSubsectionTitle('Uso referencial:'),
        _buildParagraph(
          'La informacion proporcionada por la herramienta de macronutrientes solo es estimativa y depende de los datos ingresados por el usuario. Puede haber variaciones en los calculos debido a diferencias en la preparacion, ingredientes y porciones.',
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle('Responsabilidad del usuario:'),
        _buildParagraph(
          'Es responsabilidad exclusiva del usuario todas las decisiones relacionadas con la alimentacion y la nutricion, por lo que es su obligacion verificar con un profesional de la salud o nutricion la validez y confiabilidad de la informacion proporcionada por la herramienta de macronutrientes. La herramienta no reemplaza el consejo de un profesional de la salud o nutricion.',
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          'En ultima instancia, si tiene algun problema medico relacionado con la informacion que ha introducido en la Plataforma de demood, usted es responsable de si decide o no consultar a un profesional medico, por lo que desde este momento deslinda a LA EMPRESA de cualquier dano, directo o indirecto, que pudiera tener su origen en el uso de demood o de cualquier informacion vinculada a LA EMPRESA y/o sus servicios digitales o electronicos.',
        ),
        const SizedBox(height: 24),

        // Limitacion especifica
        _buildSectionTitle('Limitacion especifica de los servicios'),
        const SizedBox(height: 12),
        _buildWarningBox(
          'EL SERVICIO PROPORCIONADO POR demood ES UNICAMENTE DE INVESTIGACION Y PROCESAMIENTO DE DATOS. TENGA EN CUENTA QUE demood NO REALIZA NINGUN DIAGNOSTICO MEDICO. POR FAVOR, CONSULTE A UN PROFESIONAL MEDICO SI LE PREOCUPA SU SALUD. EN CASO DE EMERGENCIA, DEBE CONTACTAR CON LOS SERVICIOS DE EMERGENCIA INMEDIATAMENTE. NUNCA DEBE HACER CASO OMISO DEL CONSEJO PROFESIONAL DE UN MEDICO O CANCELAR UNA CITA CON UN MEDICO PORQUE SE BASA EN INFORMACION QUE HA LEIDO U OIDO EN demood y/o en cualquier otra tecnologia vinculada directa o indirectamente a LA EMPRESA.',
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          'Debe tener al menos 18 anos si desea utilizar demood. Si es menor de 18 anos, el uso de la plataforma y la aceptacion de estos Terminos y Condiciones requiere el consentimiento de su tutor legal.',
        ),
        const SizedBox(height: 24),

        // Registro
        _buildSectionTitle('Registro'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Para acceder a los servicios de demood necesitara primero un ID de Apple o una cuenta de Google. A continuacion, podra descargar la Aplicacion de demood desde Apple App Store o Google Play Store. Los datos minimos requeridos para poder crear y dar de alta una CUENTA son: Nombre, Apellido, Correo electronico, Edad y Genero. La cancelacion de la cuenta puede efectuarse en cualquier momento.',
        ),
        const SizedBox(height: 24),

        // Confidencialidad
        _buildSectionTitle('Confidencialidad de la CUENTA'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Es indispensable que USTED mantenga en estricta confidencialidad la contrasena que permite el ingreso a la CUENTA creada. USTED es el unico responsable por el uso que se haga de la misma. En caso de que el USUARIO tenga conocimiento o presuma de una afectacion a su contrasena, es importante que lo notifique a la brevedad a LA EMPRESA a traves de direccion@abgtechcapital.com.',
        ),
        const SizedBox(height: 24),

        // Tipos de membresias
        _buildSectionTitle('Tipos de membresias'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Los USUARIOS que se registren obtendran una membresia individual e intransferible. Para membresias corporativas consultar al departamento comercial en direccion@abgtechcapital.com.',
        ),
        const SizedBox(height: 24),

        // Pago de servicios
        _buildSectionTitle('Pago de servicios'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Para que USTED pueda acceder a los servicios de demood es necesario realizar el pago correspondiente mediante tarjeta de debito, credito o transferencia electronica.',
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle('Precios y tarifas:'),
        _buildParagraph(
          'LA EMPRESA se reserva el derecho exclusivo de modificar los precios y tarifas, para lo cual se avisara via email con al menos diez dias de anticipacion al responsable de la cuenta.',
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle('Reembolsos:'),
        _buildParagraph(
          'En la contratacion de membresias anuales de contado se podra solicitar un reembolso por los meses pendientes de devengar el servicio mediante correo electronico a direccion@abgtechcapital.com, cada caso sera revisado de acuerdo a los contratos de servicio firmados y se aplicara la pena acordada en cada caso corporativo.',
        ),
        const SizedBox(height: 24),

        // Comportamiento
        _buildSectionTitle('Comportamiento y reglas de uso'),
        const SizedBox(height: 12),
        _buildSubsectionTitle('Esta prohibido:'),
        const SizedBox(height: 8),
        _buildBulletPoint(
            'Evadir, desactivar o manipular las caracteristicas de seguridad de la Plataforma de demood.'),
        _buildBulletPoint('Crear varias cuentas de usuario.'),
        _buildBulletPoint('Proporcionar informacion falsa o enganosa.'),
        _buildBulletPoint(
            'Permitir que cualquier otra persona use la plataforma en su nombre.'),
        _buildBulletPoint('Enviar correo basura, spam o mensajes repetidos.'),
        _buildBulletPoint(
            'Modificar, interferir, hackear o interrumpir la Plataforma de demood.'),
        _buildBulletPoint(
            'Extraer datos de la plataforma salvo lo permitido expresamente.'),
        const SizedBox(height: 12),
        _buildParagraph(
          'El incumplimiento representa una violacion material y puede resultar en la suspension inmediata, temporal o retirada permanente del derecho de acceso, asi como el inicio de procedimientos legales.',
        ),
        const SizedBox(height: 24),

        // Derechos de LA EMPRESA
        _buildSectionTitle('Derechos de LA EMPRESA'),
        const SizedBox(height: 12),
        _buildParagraph(
          'LA EMPRESA es la propietaria de demood, el sitio web, los SERVICIOS relacionados, el nombre comercial, la marca y los logotipos, el codigo fuente y los derechos patrimoniales de toda la propiedad intelectual. El USUARIO no puede modificar ni manipular cualquiera de esos elementos ni utilizarlos sin autorizacion por escrito.',
        ),
        const SizedBox(height: 24),

        // Vinculo del ACUERDO
        _buildSectionTitle('Vinculo del ACUERDO'),
        const SizedBox(height: 12),
        _buildParagraph(
          'En el momento en que el USUARIO se registra en demood, se establece un contrato legalmente vinculante con LA EMPRESA. Si USTED no acepta este ACUERDO no debe registrarse, ni crear una cuenta, ni generar alguna MEMBRESIA.',
        ),
        const SizedBox(height: 24),

        // Temporalidad
        _buildSectionTitle('Temporalidad del ACUERDO'),
        const SizedBox(height: 12),
        _buildParagraph(
          'El presente ACUERDO durara por todo el tiempo en que USTED y LA EMPRESA mantengan una relacion operativa. En caso de que desee dar por terminado el ACUERDO bastara con una comunicacion via correo electronico a direccion@abgtechcapital.com, por lo cual LA EMPRESA procedera a dar de baja las cuentas y suscripciones.',
        ),
        const SizedBox(height: 24),

        // Excluyentes
        _buildSectionTitle('Excluyentes de responsabilidad'),
        const SizedBox(height: 12),
        _buildParagraph(
          'LA EMPRESA no puede garantizar que no existan momentos fuera de su alcance que dificulten la accesibilidad a la informacion o la estabilidad en las conexiones de internet. Asimismo, se reitera que los servicios que ofrece demood son estrictamente de investigacion y procesamiento de informacion, por lo que por ningun motivo se debe entender que la informacion proporcionada constituye un diagnostico medico.',
        ),
        const SizedBox(height: 24),

        // Datos personales
        _buildSectionTitle('Datos personales'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Los datos personales que LA EMPRESA recabe del USUARIO o se generen por el uso inherente de demood se encuentran comprendidos en nuestro aviso de privacidad disponible en abgtechcapital.com.',
        ),
        const SizedBox(height: 24),

        // Solucion de controversias
        _buildSectionTitle('Solucion de controversias'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Desde el momento en que Usted acepta utilizar nuestro website, la plataforma demood o cualquier otra tecnologia vinculada a LA EMPRESA, usted esta renunciando expresamente a cualquier fuero que le pudiera corresponder por razon de su domicilio, nacionalidad o cualquier otra circunstancia y expresamente se somete a la Jurisdiccion de los Tribunales de la Ciudad de Mexico.',
        ),
        const SizedBox(height: 24),

        // Comunicaciones
        _buildSectionTitle('Comunicaciones electronicas'),
        const SizedBox(height: 12),
        _buildParagraph(
          'Al utilizar demood, el USUARIO aprueba recibir comunicaciones electronicas de LA EMPRESA desde la direccion direccion@abgtechcapital.com, las cuales pueden incluir notificaciones acerca de su cuenta, confirmaciones e informacion promocional.',
        ),
        const SizedBox(height: 24),

        // Footer
        _buildHighlightedBox(
          'EL PRESENTE ACUERDO ESTABLECE LOS TERMINOS Y CONDICIONES DEL USO DE LA PLATAFORMA DIGITAL demood DE ABG TECH CAPITAL INC.',
        ),
        const SizedBox(height: 16),
        _buildDateInfo('Fecha de elaboracion: 12 de marzo de 2024'),
        _buildDateInfo('Ultima actualizacion: 15 de enero de 2026'),
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

  Widget _buildWarningBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: AppColors.warning,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
        ],
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
