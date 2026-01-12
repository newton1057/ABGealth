import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: '¡Hola! Soy el asistente de soporte de demood. ¿En qué puedo ayudarte hoy?',
      isFromUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];
  bool _isTyping = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(
        text: text,
        isFromUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(_ChatMessage(
            text: _getAutoResponse(text),
            isFromUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      }
    });
  }

  String _getAutoResponse(String message) {
    final lower = message.toLowerCase();

    if (lower.contains('hola') || lower.contains('buenos') || lower.contains('buenas')) {
      return '¡Hola! Es un gusto saludarte. ¿Cómo puedo ayudarte el día de hoy?';
    } else if (lower.contains('contraseña') || lower.contains('password')) {
      return 'Para cambiar tu contraseña, ve a Configuración > Cuenta > Cambiar contraseña. Si olvidaste tu contraseña, puedes restablecerla desde la pantalla de inicio de sesión.';
    } else if (lower.contains('eliminar') && lower.contains('cuenta')) {
      return 'Entiendo que quieres eliminar tu cuenta. Esta opción está disponible en Configuración > Eliminar cuenta. Ten en cuenta que esta acción es irreversible. ¿Hay algo que podamos hacer para ayudarte antes?';
    } else if (lower.contains('error') || lower.contains('problema') || lower.contains('falla')) {
      return 'Lamento que estés experimentando problemas. ¿Podrías describir con más detalle qué error estás viendo? Esto nos ayudará a resolver tu problema más rápido.';
    } else if (lower.contains('gracias') || lower.contains('thanks')) {
      return '¡De nada! Si tienes alguna otra pregunta, no dudes en escribirme. Estoy aquí para ayudarte.';
    } else if (lower.contains('dispositivo') || lower.contains('watch') || lower.contains('sincronizar')) {
      return 'Para conectar un dispositivo, ve a Configuración > Dispositivos > Agregar dispositivo. Asegúrate de que el Bluetooth esté activado en tu teléfono y que tu dispositivo esté en modo de emparejamiento.';
    } else {
      return 'Gracias por tu mensaje. Un agente de soporte revisará tu consulta y te responderá pronto. Mientras tanto, ¿hay algo más en lo que pueda ayudarte?';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isTyping && index == _messages.length) {
                    return _buildTypingIndicator();
                  }
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
            _buildQuickReplies(),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
          const SizedBox(width: 14),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.mintBright,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soporte demood',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.semaforoVerde,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'En línea',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: AppColors.semaforoVerde,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isFromUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.mintBright,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.support_agent_rounded,
                color: AppColors.textPrimary,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isFromUser ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(message.isFromUser ? 18 : 4),
                  bottomRight: Radius.circular(message.isFromUser ? 4 : 18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: message.isFromUser ? Colors.white : AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      color: message.isFromUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isFromUser) const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.mintBright,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              color: AppColors.textPrimary,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.textSecondary.withValues(alpha: 0.3 + (0.5 * value)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _buildQuickReplies() {
    final quickReplies = [
      'Tengo un problema',
      'Cambiar contraseña',
      'Conectar dispositivo',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: quickReplies.map((reply) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    _messageController.text = reply;
                    _sendMessage();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      reply,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file_rounded,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        hintStyle: GoogleFonts.montserrat(
                          color: AppColors.textSecondary,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.mintBright,
              shape: BoxShape.circle,
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
                onTap: _sendMessage,
                borderRadius: BorderRadius.circular(24),
                child: const Icon(
                  Icons.send_rounded,
                  color: AppColors.textPrimary,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _ChatMessage {
  final String text;
  final bool isFromUser;
  final DateTime timestamp;

  _ChatMessage({
    required this.text,
    required this.isFromUser,
    required this.timestamp,
  });
}
