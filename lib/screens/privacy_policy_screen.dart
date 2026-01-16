import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../services/language_controller.dart';

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
                        _buildPrivacyContent(context),
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
              es: 'Politica de Privacidad',
              en: 'Privacy Policy',
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

  Widget _buildPrivacyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        _buildSectionTitle(
          _text(
            context,
            es: 'Aviso de Privacidad',
            en: 'Privacy Notice',
          ),
        ),
        const SizedBox(height: 16),
        _buildParagraph(
          _text(
            context,
            es:
                'Conforme a lo previsto en la Ley Federal de Proteccion de Datos Personales en Posesion de los Particulares (la "Ley"), y en cumplimiento de la obligacion a cargo de ABG Tech Capital Inc. (en adelante "demood") consistente en proteger los datos personales de sus clientes, suscriptores, instructores, asociados, trabajadores, proveedores y/o beneficiados de cualquiera de los productos, servicios o contratos pertenecientes a la operacion de nuestra empresa de consultoria, hacemos de su conocimiento lo siguiente:',
            en:
                'In accordance with the Federal Law on the Protection of Personal Data Held by Private Parties (the "Law"), and in fulfillment of the obligation of ABG Tech Capital Inc. (hereinafter "demood") to protect the personal data of its clients, subscribers, instructors, associates, employees, suppliers and/or beneficiaries of any of the products, services or contracts belonging to the operation of our consulting company, we inform you of the following:',
          ),
        ),
        const SizedBox(height: 24),

        // Tipos de Datos
        _buildSectionTitle(
          _text(
            context,
            es: 'Tipos de Datos Accedidos o Recopilados',
            en: 'Types of Data Accessed or Collected',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Nuestra aplicacion, demood, accede y procesa datos relacionados con la salud para proporcionar herramientas de gestion y recomendaciones personalizadas. Los datos recopilados o accedidos incluyen, pero no se limitan a:',
            en:
                'Our application, demood, accesses and processes health-related data to provide management tools and personalized recommendations. The data collected or accessed include, but are not limited to:',
          ),
        ),
        const SizedBox(height: 12),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Identificadores personales (como nombre, correo electronico y fecha de nacimiento) para crear perfiles de usuario.',
            en:
                'Personal identifiers (such as name, email address and date of birth) to create user profiles.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Metricas de salud (como estatura, peso, nivel de actividad, presion arterial, calorias activas quemadas, distancia, sesion de ejercicio, pisos subidos, pasos, velocidad, frecuencia respiratoria, tasa metabolica basal, grasa corporal, calorias totales quemadas, hidratacion, nutricion, sesion de sueno, glucosa en sangre, presion arterial, temperatura corporal, saturacion de oxigeno, frecuencia cardiaca en reposo y frecuencia cardiaca) para calcular puntajes de salud personalizados y proporcionar recomendaciones accionables.',
            en:
                'Health metrics (such as height, weight, activity level, blood pressure, active calories burned, distance, workout session, floors climbed, steps, speed, respiratory rate, basal metabolic rate, body fat, total calories burned, hydration, nutrition, sleep session, blood glucose, blood pressure, body temperature, oxygen saturation, resting heart rate and heart rate) to calculate personalized health scores and provide actionable recommendations.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Datos de Ubicacion: Como la ubicacion aproximada o precisa del dispositivo. El uso especifico de estos datos se detalla mas adelante.',
            en:
                'Location data: such as the approximate or precise device location. The specific use of these data is detailed below.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Datos de uso (como interacciones dentro de la aplicacion) para mejorar la experiencia del usuario y optimizar la funcionalidad de la aplicacion.',
            en:
                'Usage data (such as interactions within the application) to improve the user experience and optimize application functionality.',
          ),
        ),
        const SizedBox(height: 24),

        // Proposito del Uso
        _buildSectionTitle(
          _text(
            context,
            es: 'Proposito del Uso de los Datos',
            en: 'Purpose of Data Use',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es: 'Los datos recopilados se utilizan para los siguientes fines:',
            en: 'The collected data are used for the following purposes:',
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(
          _text(
            context,
            es: 'Brindar recomendaciones de salud ultrapersonalizadas.',
            en: 'Provide ultra-personalized health recommendations.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Monitorear y analizar tendencias de salud a lo largo del tiempo.',
            en: 'Monitor and analyze health trends over time.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Habilitar funciones como la Bitacora Medica, el Arbol Genealogico de Salud y el demood Score para la gestion preventiva de la salud.',
            en:
                'Enable features such as the Medical Log, the Health Family Tree and the demood Score for preventive health management.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Mejorar la experiencia del usuario y el rendimiento de la aplicacion mediante el analisis de datos agregados.',
            en:
                'Improve the user experience and application performance through aggregated data analysis.',
          ),
        ),
        const SizedBox(height: 24),

        // Uso de Datos de Ubicacion
        _buildSectionTitle(
          _text(
            context,
            es: 'Uso Especifico de los Datos de Ubicacion',
            en: 'Specific Use of Location Data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Para ofrecer una experiencia completa y funcional, nuestra aplicacion puede solicitar acceso a los datos de ubicacion de tu dispositivo. A continuacion, detallamos de forma exhaustiva como y por que accedemos, recogemos y usamos esta informacion:',
            en:
                'To offer a complete and functional experience, our application may request access to location data from your device. Below we detail how and why we access, collect and use this information:',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Integracion con Plataformas de Salud (Health Connect de Google):',
            en: 'Integration with Health Platforms (Google Health Connect):',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'La funcionalidad principal de nuestra app depende de la sincronizacion con servicios de salud como Health Connect de Google. La API de Health Connect requiere el permiso de ubicacion para descubrir y establecer conexiones seguras con dispositivos y sensores de salud cercanos. Sin este permiso, la sincronizacion automatica de datos clave podria no funcionar correctamente.',
            en:
                'The main functionality of our app depends on synchronization with health services such as Google Health Connect. The Health Connect API requires location permission to discover and establish secure connections with nearby health devices and sensors. Without this permission, automatic synchronization of key data may not work correctly.',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: 'Personalizacion de Contenido y Algoritmos de IA:',
            en: 'Content Personalization and AI Algorithms:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'Utilizamos los datos de ubicacion para contextualizar tu actividad y ofrecerte recomendaciones mas precisas y relevantes. Esto permite que la personalizacion de la IA y la informacion de la app sean significativamente mas efectivas para ti.',
            en:
                'We use location data to contextualize your activity and offer you more accurate and relevant recommendations. This allows AI personalization and app information to be significantly more effective for you.',
          ),
        ),
        const SizedBox(height: 12),
        _buildHighlightedBox(
          _text(
            context,
            es:
                'Es importante destacar que los datos de ubicacion se utilizan exclusivamente para los fines funcionales mencionados. No vendemos ni compartimos tus datos de ubicacion precisos con terceros para fines publicitarios.',
            en:
                'It is important to note that location data are used exclusively for the functional purposes mentioned. We do not sell or share your precise location data with third parties for advertising purposes.',
          ),
        ),
        const SizedBox(height: 24),

        // Manejo Seguro de Datos
        _buildSectionTitle(
          _text(
            context,
            es: 'Manejo Seguro de Datos',
            en: 'Secure Data Handling',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Aplicamos medidas de seguridad estandar en la industria para proteger los datos de los usuarios, incluyendo protocolos de cifrado para la transmision y almacenamiento de datos. El acceso a los datos sensibles esta limitado unicamente a personal autorizado.',
            en:
                'We apply industry-standard security measures to protect user data, including encryption protocols for data transmission and storage. Access to sensitive data is limited only to authorized personnel.',
          ),
        ),
        const SizedBox(height: 24),

        // Retencion y Eliminacion
        _buildSectionTitle(
          _text(
            context,
            es: 'Politica de Retencion y Eliminacion de Datos',
            en: 'Data Retention and Deletion Policy',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Los datos recopilados a traves de demood se retienen unicamente mientras sea necesario para proporcionar nuestros servicios. Los usuarios pueden solicitar la eliminacion de sus datos en cualquier momento contactando al responsable de privacidad indicado a continuacion. Una vez que se verifique la solicitud de eliminacion, todos los datos personales se eliminaran permanentemente de nuestros sistemas en un plazo razonable.',
            en:
                'Data collected through demood are retained only as long as necessary to provide our services. Users may request deletion of their data at any time by contacting the privacy officer listed below. Once the deletion request is verified, all personal data will be permanently deleted from our systems within a reasonable period.',
          ),
        ),
        const SizedBox(height: 24),

        // Contenido de los Datos Personales
        _buildSectionTitle(
          _text(
            context,
            es: '1. Contenido de los Datos Personales',
            en: '1. Contents of Personal Data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'Para efectos del presente Aviso de Privacidad, de manera enunciativa mas no limitativa, se entenderan como "Datos Personales":',
            en:
                'For purposes of this Privacy Notice, by way of example and not limitation, the following shall be understood as "Personal Data":',
          ),
        ),
        const SizedBox(height: 12),
        _buildSubsectionTitle(
          _text(
            context,
            es: '1.1. Datos generales:',
            en: '1.1. General data:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'demood recauda datos personales como nombre(s) y apellidos, fecha de nacimiento, genero, fotografia, RFC, CURP, correo electronico, telefono fijo, telefono celular, domicilio, entre otros similares.',
            en:
                'demood collects personal data such as first name(s) and last names, date of birth, gender, photograph, RFC, CURP, email, landline phone, mobile phone, address, among other similar.',
          ),
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
          _text(
            context,
            es: '1.2. Datos relacionados con membresias:',
            en: '1.2. Membership-related data:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'Nombre, domicilio, datos de tarjetas de credito/debito o cuenta CLABE.',
            en: 'Name, address, credit/debit card data or CLABE account.',
          ),
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
          _text(
            context,
            es: '1.3. Datos de terceros referidos:',
            en: '1.3. Data of referred third parties:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'Datos de personas que pudieran estar interesados en los servicios proporcionados por demood.',
            en:
                'Data of people who may be interested in the services provided by demood.',
          ),
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
          _text(
            context,
            es: '1.4. Datos relacionados con solicitudes de empleo:',
            en: '1.4. Data related to job applications:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'Nivel educativo, experiencia laboral, numero de seguridad social y curriculum vitae.',
            en:
                'Education level, work experience, social security number and resume.',
          ),
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
          _text(
            context,
            es: '1.5. Datos relacionados con la navegacion digital:',
            en: '1.5. Data related to digital browsing:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es:
                'Uso de cookies, etiquetas y metadatos para identificar el dispositivo y mejorar la experiencia.',
            en:
                'Use of cookies, tags and metadata to identify the device and improve the experience.',
          ),
        ),
        const SizedBox(height: 8),
        _buildSubsectionTitle(
          _text(
            context,
            es:
                '1.6. Datos relacionados con el procesamiento de datos y consejos para el estilo de vida:',
            en: '1.6. Data related to data processing and lifestyle advice:',
          ),
        ),
        _buildParagraph(
          _text(
            context,
            es: 'Datos biometricos, de morbilidad, de herencia y rutinas de vida.',
            en: 'Biometric data, morbidity, heredity and lifestyle routines.',
          ),
        ),
        const SizedBox(height: 24),

        // Persona responsable
        _buildSectionTitle(
          _text(
            context,
            es: '2. Persona responsable de recabar datos personales',
            en: '2. Person responsible for collecting personal data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'La persona responsable de recabar sus datos personales es demood. El domicilio para efectos de este aviso es 131 Continental Dr, Suite 305, City of Newmark, County of New Castle, Delaware 19713.',
            en:
                'The person responsible for collecting your personal data is demood. The address for purposes of this notice is 131 Continental Dr, Suite 305, City of Newmark, County of New Castle, Delaware 19713.',
          ),
        ),
        const SizedBox(height: 24),

        // Tratamiento
        _buildSectionTitle(
          _text(
            context,
            es: '3. Tratamiento de sus datos personales',
            en: '3. Processing of your personal data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'El Tratamiento de Datos Personales por parte de demood se limitara al cumplimiento de las Finalidades previstas en este Aviso de Privacidad.',
            en:
                'The processing of personal data by demood will be limited to compliance with the purposes set forth in this Privacy Notice.',
          ),
        ),
        const SizedBox(height: 24),

        // Finalidades
        _buildSectionTitle(
          _text(
            context,
            es: '4. Finalidades del tratamiento de datos personales',
            en: '4. Purposes of personal data processing',
          ),
        ),
        const SizedBox(height: 12),
        _buildBulletPoint(
          _text(
            context,
            es: 'a). Fines de suscripcion (expediente, cobro, facturacion).',
            en: 'a). Subscription purposes (records, collection, invoicing).',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'b). Publicidad (mercadotecnia, nuevos productos, eventos).',
            en: 'b). Advertising (marketing, new products, events).',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es:
                'c). Servicios de procesamiento y recomendaciones (estadistica y consejos de estilo de vida).',
            en:
                'c). Processing and recommendation services (statistics and lifestyle advice).',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'd). Reclutamiento y seleccion de personal.',
            en: 'd). Recruitment and staff selection.',
          ),
        ),
        const SizedBox(height: 24),

        // Aceptacion
        _buildSectionTitle(
          _text(
            context,
            es: '5. Aceptacion del tratamiento de datos personales',
            en: '5. Acceptance of personal data processing',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'La aceptacion se podra realizar a traves de medios electronicos (al suscribirse), medios fisicos (en nuestras oficinas) o de forma tacita conforme a la Ley.',
            en:
                'Acceptance may be made through electronic means (upon subscription), physical means (at our offices) or tacitly in accordance with the Law.',
          ),
        ),
        const SizedBox(height: 24),

        // Limitacion
        _buildSectionTitle(
          _text(
            context,
            es: '6. Limitacion del uso o divulgacion de tus datos personales',
            en: '6. Limitation of the use or disclosure of your personal data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'demood realiza acciones de confidencialidad, administracion restringida de bases de datos y sistemas de computo protegidos para evitar el uso no autorizado.',
            en:
                'demood carries out confidentiality actions, restricted administration of databases and protected computer systems to prevent unauthorized use.',
          ),
        ),
        const SizedBox(height: 24),

        // Derechos ARCO
        _buildSectionTitle(
          _text(
            context,
            es: '7. Derechos de acceso, rectificacion, cancelacion u oposicion',
            en: '7. Rights of access, rectification, cancellation or opposition',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'demood ha designado al Departamento de Datos Personales para dar tramite a sus solicitudes:',
            en:
                'demood has designated the Personal Data Department to process your requests:',
          ),
        ),
        const SizedBox(height: 8),
        _buildBulletPoint(
          _text(
            context,
            es:
                'Direccion: 131 Continental Dr, Suite 305, City of Newmark, County of New Castle, Delaware 19713.',
            en:
                'Address: 131 Continental Dr, Suite 305, City of Newmark, County of New Castle, Delaware 19713.',
          ),
        ),
        _buildBulletPoint(
          _text(
            context,
            es: 'Correo electronico: direccion@abgtechcapital.com',
            en: 'Email: direccion@abgtechcapital.com',
          ),
        ),
        const SizedBox(height: 24),

        // Cambios
        _buildSectionTitle(
          _text(
            context,
            es: '8. Cambios al aviso de privacidad',
            en: '8. Changes to the privacy notice',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'demood se reserva el derecho de efectuar modificaciones en cualquier momento. El presente Aviso de Privacidad fue actualizado por ultima ocasion el 12 de enero de 2026.',
            en:
                'demood reserves the right to make modifications at any time. This Privacy Notice was last updated on January 12, 2026.',
          ),
        ),
        const SizedBox(height: 24),

        // Transferencia
        _buildSectionTitle(
          _text(
            context,
            es: '9. Transferencia de datos personales',
            en: '9. Transfer of personal data',
          ),
        ),
        const SizedBox(height: 12),
        _buildParagraph(
          _text(
            context,
            es:
                'demood podra transferir sus Datos Personales a proveedores para cumplir con las finalidades de este aviso, bajo convenios de confidencialidad.',
            en:
                'demood may transfer your Personal Data to providers to fulfill the purposes of this notice, under confidentiality agreements.',
          ),
        ),
        const SizedBox(height: 24),

        // Footer
        _buildHighlightedBox(
          _text(
            context,
            es:
                'AL UTILIZAR DEMOOD, USTED CONFIRMA QUE HA LEIDO, ENTENDIDO Y ACEPTADO ESTE AVISO DE PRIVACIDAD EN SU TOTALIDAD.',
            en:
                'BY USING DEMOOD, YOU CONFIRM THAT YOU HAVE READ, UNDERSTOOD AND ACCEPTED THIS PRIVACY NOTICE IN FULL.',
          ),
        ),
        const SizedBox(height: 16),
        _buildDateInfo(
          _text(
            context,
            es: 'Ultima actualizacion: 12 de enero de 2026',
            en: 'Last update: January 12, 2026',
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
