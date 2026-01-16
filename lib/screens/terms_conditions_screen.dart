import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../services/language_controller.dart';

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
                        _buildTermsContent(context),
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
            _text(
              context,
              es: 'Terminos y condiciones',
              en: 'Terms and conditions',
            ),
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

  Widget _buildTermsContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        _buildSectionTitle(
          _text(
            context,
            es: 'Terminos y condiciones de uso de la Plataforma Digital demood',
            en: 'Terms and conditions for use of the demood Digital Platform',
          ),
        ),
        const SizedBox(height: 16),
        _buildParagraph(
          _text(
            context,
            es:
                'El presente documento es un acuerdo vinculante entre el usuario (en lo sucesivo "USUARIO" o "USTED") y ABG Tech Capital Inc. (en lo sucesivo "LA EMPRESA") que establece los terminos y condiciones (en lo sucesivo el "ACUERDO") para el uso y aprovechamiento de la Plataforma Digital demood (en lo sucesivo "demood"). El presente ACUERDO resulta aplicable a todas las actividades e interaccion que realice el USUARIO dentro de demood, las aplicaciones moviles relacionadas, y todos los demas servicios vinculados (en lo sucesivo los "SERVICIOS").',
            en:
                'This document is a binding agreement between the user (hereinafter "USER" or "YOU") and ABG Tech Capital Inc. (hereinafter "THE COMPANY") that sets out the terms and conditions (hereinafter the "AGREEMENT") for the use and enjoyment of the demood Digital Platform (hereinafter "demood"). This AGREEMENT applies to all activities and interactions carried out by the USER within demood, the related mobile applications, and all other linked services (hereinafter the "SERVICES").',
          ),
        ),
        const SizedBox(height: 24),

        // Uso de la Plataforma
        _buildSectionTitle(
          _text(
            context,
            es: 'Uso de la Plataforma demood',
            en: 'Use of the demood Platform',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'La plataforma proporciona a nuestros usuarios una guia de salud y ofrece muchas caracteristicas como las siguientes: asistencia e informacion de salud personalizada, funcionalidad de seguimiento de sintomas y acceso a nuestra base de datos medicos ("Biblioteca medica") impulsada por el sistema de inteligencia artificial unico de demood.',
            en:
                'The platform provides our users with a health guide and offers many features such as: personalized health assistance and information, symptom tracking functionality, and access to our medical database ("Medical Library") powered by demood\'s unique artificial intelligence system.',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'La guia y asistencia de salud esta disponible como una aplicacion que se puede descargar gratuitamente a traves de su dispositivo movil (en lo sucesivo, la "Aplicacion de demood"), y (cuando y donde este disponible) a traves de nuestra aplicacion basada en la web (en lo sucesivo, el "Sitio Web"). demood tambien ha desarrollado una herramienta de evaluacion (en lo sucesivo denominada "Herramienta de evaluacion") y servicios relacionados. El Sitio Web, la Aplicacion de demood y la Herramienta de evaluacion, incluyendo cualquier software, servicio u otra tecnologia en la que se basen, se denominaran en adelante la "Plataforma de demood".',
            en:
                'The health guide and assistance are available as an application that can be downloaded for free through your mobile device (hereinafter, the "demood App"), and (when and where available) through our web-based application (hereinafter, the "Website"). demood has also developed an assessment tool (hereinafter referred to as the "Assessment Tool") and related services. The Website, the demood App and the Assessment Tool, including any software, service or other technology on which they are based, shall hereinafter be referred to as the "demood Platform".',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'La plataforma demood le ofrece la oportunidad de averiguar su estado de salud, asi como darle recomendaciones para su estilo de vida basadas en sus respuestas (sin que pueda sustituir el consejo o asesoria de un experto medico con patente medica). La Plataforma de demood utiliza una base de documentos que contienen conocimientos medicos y cientificos para recomendaciones de bienestar (en lo sucesivo, el "Informe de evaluacion").',
            en:
                'The demood platform offers you the opportunity to find out your health status, as well as provide lifestyle recommendations based on your answers (without being able to replace the advice or counseling of a licensed medical expert). The demood Platform uses a database of documents containing medical and scientific knowledge for wellness recommendations (hereinafter, the "Assessment Report").',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'La plataforma demood se le proporciona por distintos canales de distribucion y se le permite realizar un numero ilimitado de solicitudes de asistencia de salud, recomendaciones y evaluacion.',
            en:
                'The demood platform is provided to you through different distribution channels and you are allowed to make an unlimited number of requests for health assistance, recommendations, and assessment.',
          ),
        ),
        const SizedBox(height: 12),
        _buildHighlightedBox(
          _text(
            context,
            es:
                'Por favor, tenga en cuenta que proporcionamos la plataforma demood unicamente con fines informativos. No es una consulta medica. La plataforma demood no es un sustituto adecuado para el asesoramiento medico obtenido de su medico, medico general u otro proveedor de servicios de salud. La plataforma demood NO proporciona diagnosticos para condiciones medicas, ni prescribe como tratar cualquier problema medico que pueda tener. Esto solo puede hacerse consultando a un profesional medico.',
            en:
                'Please note that we provide the demood platform for informational purposes only. It is not a medical consultation. The demood platform is not a suitable substitute for medical advice obtained from your doctor, general practitioner or other health care provider. The demood platform does NOT provide diagnoses for medical conditions, nor does it prescribe how to treat any medical issue you may have. This can only be done by consulting a medical professional.',
          ),
        ),
        const SizedBox(height: 24),

        // Uso referencial
        _buildSectionTitle(
          _text(
            context,
            es: 'Uso referencial y responsabilidad',
            en: 'Reference use and responsibility',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Uso referencial:',
            en: 'Reference use:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'La informacion proporcionada por la herramienta de macronutrientes solo es estimativa y depende de los datos ingresados por el usuario. Puede haber variaciones en los calculos debido a diferencias en la preparacion, ingredientes y porciones.',
            en:
                'The information provided by the macronutrients tool is only an estimate and depends on the data entered by the user. There may be variations in the calculations due to differences in preparation, ingredients, and portions.',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Responsabilidad del usuario:',
            en: 'User responsibility:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'Es responsabilidad exclusiva del usuario todas las decisiones relacionadas con la alimentacion y la nutricion, por lo que es su obligacion verificar con un profesional de la salud o nutricion la validez y confiabilidad de la informacion proporcionada por la herramienta de macronutrientes. La herramienta no reemplaza el consejo de un profesional de la salud o nutricion.',
            en:
                'All decisions related to diet and nutrition are the sole responsibility of the user, so it is your obligation to verify with a health or nutrition professional the validity and reliability of the information provided by the macronutrients tool. The tool does not replace the advice of a health or nutrition professional.',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'En ultima instancia, si tiene algun problema medico relacionado con la informacion que ha introducido en la Plataforma de demood, usted es responsable de si decide o no consultar a un profesional medico, por lo que desde este momento deslinda a LA EMPRESA de cualquier dano, directo o indirecto, que pudiera tener su origen en el uso de demood o de cualquier informacion vinculada a LA EMPRESA y/o sus servicios digitales o electronicos.',
            en:
                'Ultimately, if you have any medical issue related to the information you have entered into the demood Platform, you are responsible for whether or not you decide to consult a medical professional, and therefore from this moment you release THE COMPANY from any direct or indirect damage that may arise from the use of demood or any information linked to THE COMPANY and/or its digital or electronic services.',
          ),
        ),
        const SizedBox(height: 24),

        // Limitacion especifica
        _buildSectionTitle(
          _text(
            context,
            es: 'Limitacion especifica de los servicios',
            en: 'Specific limitation of the services',
          ),
        ),
        const SizedBox(height: 12),
        _buildWarningBox(
          _text(
            context,
            es:
                'EL SERVICIO PROPORCIONADO POR demood ES UNICAMENTE DE INVESTIGACION Y PROCESAMIENTO DE DATOS. TENGA EN CUENTA QUE demood NO REALIZA NINGUN DIAGNOSTICO MEDICO. POR FAVOR, CONSULTE A UN PROFESIONAL MEDICO SI LE PREOCUPA SU SALUD. EN CASO DE EMERGENCIA, DEBE CONTACTAR CON LOS SERVICIOS DE EMERGENCIA INMEDIATAMENTE. NUNCA DEBE HACER CASO OMISO DEL CONSEJO PROFESIONAL DE UN MEDICO O CANCELAR UNA CITA CON UN MEDICO PORQUE SE BASA EN INFORMACION QUE HA LEIDO U OIDO EN demood y/o en cualquier otra tecnologia vinculada directa o indirectamente a LA EMPRESA.',
            en:
                'THE SERVICE PROVIDED BY demood IS ONLY FOR RESEARCH AND DATA PROCESSING. PLEASE NOTE THAT demood DOES NOT PERFORM ANY MEDICAL DIAGNOSIS. PLEASE CONSULT A MEDICAL PROFESSIONAL IF YOU ARE CONCERNED ABOUT YOUR HEALTH. IN CASE OF EMERGENCY, YOU MUST CONTACT EMERGENCY SERVICES IMMEDIATELY. YOU SHOULD NEVER DISREGARD PROFESSIONAL MEDICAL ADVICE OR CANCEL A MEDICAL APPOINTMENT BECAUSE YOU RELY ON INFORMATION YOU HAVE READ OR HEARD ON demood and/or any other technology linked directly or indirectly to THE COMPANY.',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Debe tener al menos 18 anos si desea utilizar demood. Si es menor de 18 anos, el uso de la plataforma y la aceptacion de estos Terminos y Condiciones requiere el consentimiento de su tutor legal.',
            en:
                'You must be at least 18 years old to use demood. If you are under 18, use of the platform and acceptance of these Terms and Conditions require the consent of your legal guardian.',
          ),
        ),
        const SizedBox(height: 24),

        // Registro
        _buildSectionTitle(
          _text(
            context,
            es: 'Registro',
            en: 'Registration',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Para acceder a los servicios de demood necesitara primero un ID de Apple o una cuenta de Google. A continuacion, podra descargar la Aplicacion de demood desde Apple App Store o Google Play Store. Los datos minimos requeridos para poder crear y dar de alta una CUENTA son: Nombre, Apellido, Correo electronico, Edad y Genero. La cancelacion de la cuenta puede efectuarse en cualquier momento.',
            en:
                'To access demood services you will first need an Apple ID or a Google account. You can then download the demood App from the Apple App Store or Google Play Store. The minimum data required to create and register an ACCOUNT are: First Name, Last Name, Email, Age and Gender. Account cancellation may be carried out at any time.',
          ),
        ),
        const SizedBox(height: 24),

        // Confidencialidad
        _buildSectionTitle(
          _text(
            context,
            es: 'Confidencialidad de la CUENTA',
            en: 'ACCOUNT confidentiality',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Es indispensable que USTED mantenga en estricta confidencialidad la contrasena que permite el ingreso a la CUENTA creada. USTED es el unico responsable por el uso que se haga de la misma. En caso de que el USUARIO tenga conocimiento o presuma de una afectacion a su contrasena, es importante que lo notifique a la brevedad a LA EMPRESA a traves de direccion@abgtechcapital.com.',
            en:
                'It is essential that YOU keep in strict confidentiality the password that allows access to the created ACCOUNT. YOU are solely responsible for its use. If the USER becomes aware of or suspects any compromise of your password, it is important to notify THE COMPANY as soon as possible at direccion@abgtechcapital.com.',
          ),
        ),
        const SizedBox(height: 24),

        // Tipos de membresias
        _buildSectionTitle(
          _text(
            context,
            es: 'Tipos de membresias',
            en: 'Types of memberships',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Los USUARIOS que se registren obtendran una membresia individual e intransferible. Para membresias corporativas consultar al departamento comercial en direccion@abgtechcapital.com.',
            en:
                'USERS who register will obtain an individual, non-transferable membership. For corporate memberships, contact the sales department at direccion@abgtechcapital.com.',
          ),
        ),
        const SizedBox(height: 24),

        // Pago de servicios
        _buildSectionTitle(
          _text(
            context,
            es: 'Pago de servicios',
            en: 'Payment for services',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Para que USTED pueda acceder a los servicios de demood es necesario realizar el pago correspondiente mediante tarjeta de debito, credito o transferencia electronica.',
            en:
                'For YOU to access demood services it is necessary to make the corresponding payment by debit card, credit card or electronic transfer.',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Precios y tarifas:',
            en: 'Prices and fees:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'LA EMPRESA se reserva el derecho exclusivo de modificar los precios y tarifas, para lo cual se avisara via email con al menos diez dias de anticipacion al responsable de la cuenta.',
            en:
                'THE COMPANY reserves the exclusive right to modify prices and fees, for which notice will be sent by email at least ten days in advance to the account holder.',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Reembolsos:',
            en: 'Refunds:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'En la contratacion de membresias anuales de contado se podra solicitar un reembolso por los meses pendientes de devengar el servicio mediante correo electronico a direccion@abgtechcapital.com, cada caso sera revisado de acuerdo a los contratos de servicio firmados y se aplicara la pena acordada en cada caso corporativo.',
            en:
                'For annual memberships paid in full, a refund for the remaining months of service may be requested by email to direccion@abgtechcapital.com. Each case will be reviewed according to the signed service contracts and the penalty agreed in each corporate case will apply.',
          ),
        ),
        const SizedBox(height: 24),

        // Comportamiento
        _buildSectionTitle(
          _text(
            context,
            es: 'Comportamiento y reglas de uso',
            en: 'Behavior and rules of use',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Esta prohibido:',
            en: 'Prohibited:',
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Evadir, desactivar o manipular las caracteristicas de seguridad de la Plataforma de demood.',
            en:
                'Evade, disable, or tamper with the security features of the demood Platform.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Crear varias cuentas de usuario.',
            en: 'Create multiple user accounts.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Proporcionar informacion falsa o enganosa.',
            en: 'Provide false or misleading information.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Permitir que cualquier otra persona use la plataforma en su nombre.',
            en: 'Allow any other person to use the platform on your behalf.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Enviar correo basura, spam o mensajes repetidos.',
            en: 'Send junk mail, spam, or repeated messages.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Modificar, interferir, hackear o interrumpir la Plataforma de demood.',
            en: 'Modify, interfere with, hack, or disrupt the demood Platform.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Extraer datos de la plataforma salvo lo permitido expresamente.',
            en: 'Extract data from the platform except as expressly permitted.',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'El incumplimiento representa una violacion material y puede resultar en la suspension inmediata, temporal o retirada permanente del derecho de acceso, asi como el inicio de procedimientos legales.',
            en:
                'Non-compliance constitutes a material breach and may result in immediate suspension, temporary or permanent withdrawal of access rights, as well as the initiation of legal proceedings.',
          ),
        ),
        const SizedBox(height: 24),

        // Derechos de LA EMPRESA
        _buildSectionTitle(
          _text(
            context,
            es: 'Derechos de LA EMPRESA',
            en: 'Rights of THE COMPANY',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'LA EMPRESA es la propietaria de demood, el sitio web, los SERVICIOS relacionados, el nombre comercial, la marca y los logotipos, el codigo fuente y los derechos patrimoniales de toda la propiedad intelectual. El USUARIO no puede modificar ni manipular cualquiera de esos elementos ni utilizarlos sin autorizacion por escrito.',
            en:
                'THE COMPANY owns demood, the website, the related SERVICES, the trade name, the trademark and logos, the source code and the patrimonial rights of all intellectual property. The USER may not modify or tamper with any of these elements or use them without written authorization.',
          ),
        ),
        const SizedBox(height: 24),

        // Vinculo del ACUERDO
        _buildSectionTitle(
          _text(
            context,
            es: 'Vinculo del ACUERDO',
            en: 'Binding nature of the AGREEMENT',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'En el momento en que el USUARIO se registra en demood, se establece un contrato legalmente vinculante con LA EMPRESA. Si USTED no acepta este ACUERDO no debe registrarse, ni crear una cuenta, ni generar alguna MEMBRESIA.',
            en:
                'At the moment the USER registers on demood, a legally binding contract is established with THE COMPANY. If YOU do not accept this AGREEMENT, you must not register, create an account, or obtain any MEMBERSHIP.',
          ),
        ),
        const SizedBox(height: 24),

        // Temporalidad
        _buildSectionTitle(
          _text(
            context,
            es: 'Temporalidad del ACUERDO',
            en: 'Term of the AGREEMENT',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'El presente ACUERDO durara por todo el tiempo en que USTED y LA EMPRESA mantengan una relacion operativa. En caso de que desee dar por terminado el ACUERDO bastara con una comunicacion via correo electronico a direccion@abgtechcapital.com, por lo cual LA EMPRESA procedera a dar de baja las cuentas y suscripciones.',
            en:
                'This AGREEMENT will remain in effect for as long as YOU and THE COMPANY maintain an operational relationship. If you wish to terminate the AGREEMENT, it will be sufficient to send an email to direccion@abgtechcapital.com, after which THE COMPANY will proceed to cancel the accounts and subscriptions.',
          ),
        ),
        const SizedBox(height: 24),

        // Excluyentes
        _buildSectionTitle(
          _text(
            context,
            es: 'Excluyentes de responsabilidad',
            en: 'Exclusions of liability',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'LA EMPRESA no puede garantizar que no existan momentos fuera de su alcance que dificulten la accesibilidad a la informacion o la estabilidad en las conexiones de internet. Asimismo, se reitera que los servicios que ofrece demood son estrictamente de investigacion y procesamiento de informacion, por lo que por ningun motivo se debe entender que la informacion proporcionada constituye un diagnostico medico.',
            en:
                'THE COMPANY cannot guarantee that there will be no circumstances beyond its control that hinder access to information or stability of internet connections. Likewise, it is reiterated that the services offered by demood are strictly for research and information processing, therefore under no circumstances should the information provided be understood as a medical diagnosis.',
          ),
        ),
        const SizedBox(height: 24),

        // Datos personales
        _buildSectionTitle(
          _text(
            context,
            es: 'Datos personales',
            en: 'Personal data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Los datos personales que LA EMPRESA recabe del USUARIO o se generen por el uso inherente de demood se encuentran comprendidos en nuestro aviso de privacidad disponible en abgtechcapital.com.',
            en:
                'The personal data that THE COMPANY collects from the USER or that is generated by the inherent use of demood are covered in our privacy notice available at abgtechcapital.com.',
          ),
        ),
        const SizedBox(height: 24),

        // Solucion de controversias
        _buildSectionTitle(
          _text(
            context,
            es: 'Solucion de controversias',
            en: 'Dispute resolution',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Desde el momento en que Usted acepta utilizar nuestro website, la plataforma demood o cualquier otra tecnologia vinculada a LA EMPRESA, usted esta renunciando expresamente a cualquier fuero que le pudiera corresponder por razon de su domicilio, nacionalidad o cualquier otra circunstancia y expresamente se somete a la Jurisdiccion de los Tribunales de la Ciudad de Mexico.',
            en:
                'From the moment you agree to use our website, the demood platform or any other technology linked to THE COMPANY, you expressly waive any venue that may correspond to you due to your domicile, nationality or any other circumstance and expressly submit to the jurisdiction of the Courts of Mexico City.',
          ),
        ),
        const SizedBox(height: 24),

        // Comunicaciones
        _buildSectionTitle(
          _text(
            context,
            es: 'Comunicaciones electronicas',
            en: 'Electronic communications',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Al utilizar demood, el USUARIO aprueba recibir comunicaciones electronicas de LA EMPRESA desde la direccion direccion@abgtechcapital.com, las cuales pueden incluir notificaciones acerca de su cuenta, confirmaciones e informacion promocional.',
            en:
                'By using demood, the USER agrees to receive electronic communications from THE COMPANY at direccion@abgtechcapital.com, which may include notifications about your account, confirmations and promotional information.',
          ),
        ),
        const SizedBox(height: 24),

        // Footer
        _buildHighlightedBox(
          _text(
            context,
            es:
                'EL PRESENTE ACUERDO ESTABLECE LOS TERMINOS Y CONDICIONES DEL USO DE LA PLATAFORMA DIGITAL demood DE ABG TECH CAPITAL INC.',
            en:
                'THIS AGREEMENT SETS OUT THE TERMS AND CONDITIONS FOR THE USE OF THE demood DIGITAL PLATFORM OF ABG TECH CAPITAL INC.',
          ),
        ),
        const SizedBox(height: 16),
        _buildDateInfo(
          _text(
            context,
            es: 'Fecha de elaboracion: 12 de marzo de 2024',
            en: 'Date of preparation: March 12, 2024',
          ),
        ),
        _buildDateInfo(
          _text(
            context,
            es: 'Ultima actualizacion: 15 de enero de 2026',
            en: 'Last update: January 15, 2026',
          ),
        ),
      ],
    );
  }

  String _text(BuildContext context, {required String es, required String en}) {
    return LanguageScope.of(context).isEnglish ? en : es;
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
            _text(
              context,
              es: 'Entendido',
              en: 'Understood',
            ),
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
