import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HealthQuadrantsWidget extends StatefulWidget {
  const HealthQuadrantsWidget({
    super.key,
    this.showProgressRing = false,
    this.progress = 0.75,
  });

  final bool showProgressRing;
  final double progress;

  @override
  State<HealthQuadrantsWidget> createState() => _HealthQuadrantsWidgetState();
}

class _HealthQuadrantsWidgetState extends State<HealthQuadrantsWidget>
    with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  void _showOverlay(
    BuildContext context,
    Offset position,
    String title,
    String rating,
    IconData icon,
    Color color,
  ) {
    _removeOverlay(immediately: true); // Safety cleanup

    final overlay = Overlay.of(context);

    // Position calculation
    double left = position.dx + 20;
    double top = position.dy - 80; // slightly higher for visibility

    // Screen edge checks
    if (left + 160 > MediaQuery.of(context).size.width) {
      left = position.dx - 180; // Flip to left side
    }
    // Top check
    if (top < 50) top = position.dy + 20;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: left,
        top: top,
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: _scaleAnimation,
            alignment: left < position.dx
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _buildGlassCard(title, rating, icon, color),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    _controller.forward();
  }

  Widget _buildGlassCard(
    String title,
    String rating,
    IconData icon,
    Color color,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: -4,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.2)),
                ),
                child: Icon(icon, size: 24, color: color),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        rating.split('/')[0], // The score
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        '/${rating.split('/')[1]}', // The max
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _removeOverlay({bool immediately = false}) async {
    if (_overlayEntry == null) return;

    if (!immediately) {
      await _controller.reverse();
    }
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay(immediately: true);
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCenterOrb({
    VoidCallback? onTap,
    bool showProgressRing = false,
    double progress = 0.0,
  }) {
    final baseDecoration = BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 25,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          blurRadius: 0,
          spreadRadius: 2,
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Colors.grey.shade100],
      ),
    );

    final orb = SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: Container(decoration: baseDecoration)),
          if (showProgressRing)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: CircularProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  strokeWidth: 6,
                  backgroundColor: AppColors.muted,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.mintBright,
                  ),
                ),
              ),
            ),
          Image.asset(
            'assets/images/icon_transparent.png',
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );

    if (onTap == null) {
      return orb;
    }

    return GestureDetector(onTap: onTap, child: orb);
  }

  Widget _buildGestureZone(
    BuildContext context, {
    required Alignment alignment,
    required double left,
    required double right,
    required double top,
    required double bottom,
    required String title,
    required String rating,
    required IconData icon,
    required Color color,
    required EdgeInsets iconPadding,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: GestureDetector(
        onLongPressStart: (details) => _showOverlay(
          context,
          details.globalPosition,
          title,
          rating,
          icon,
          color,
        ),
        onLongPressEnd: (_) => _removeOverlay(),
        onLongPressCancel: () => _removeOverlay(),
        behavior: HitTestBehavior.translucent,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: iconPadding,
            child: _QuadrantIcon(
              alignment: Alignment.center,
              icon: icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 340,
      width: double.infinity,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.semaforoVerde.withValues(alpha: 0.2),
                  blurRadius: 70,
                  spreadRadius: 15,
                ),
                BoxShadow(
                  color: AppColors.semaforoAmarillo.withValues(alpha: 0.15),
                  blurRadius: 70,
                  spreadRadius: 15,
                  offset: const Offset(30, -30),
                ),
              ],
            ),
          ),

          // Main Quadrant Painter
          CustomPaint(size: const Size(280, 280), painter: _QuadrantsPainter()),

          // Gesture Detectors
          // Top Left: Water
          _buildGestureZone(
            context,
            alignment: Alignment.topLeft,
            left: 0,
            top: 0,
            right: width / 2,
            bottom: 170,
            title: 'Hidratación',
            rating: '8/10',
            icon: Icons.local_drink_outlined,
            color: Colors.blueGrey,
            iconPadding: const EdgeInsets.only(top: 40, left: 40),
          ),

          // Top Right: Sleep
          _buildGestureZone(
            context,
            alignment: Alignment.topRight,
            left: width / 2,
            top: 0,
            right: 0,
            bottom: 170,
            title: 'Sueño',
            rating: '7/10',
            icon: Icons.nights_stay_rounded,
            color: Colors.amber,
            iconPadding: const EdgeInsets.only(top: 40, right: 40),
          ),

          // Bottom Right: Food
          _buildGestureZone(
            context,
            alignment: Alignment.bottomRight,
            left: width / 2,
            top: 170,
            right: 0,
            bottom: 0,
            title: 'Alimentación',
            rating: '9/10',
            icon: Icons.restaurant_rounded,
            color: Colors.green,
            iconPadding: const EdgeInsets.only(bottom: 40, right: 40),
          ),

          // Bottom Left: Activity
          _buildGestureZone(
            context,
            alignment: Alignment.bottomLeft,
            left: 0,
            top: 170,
            right: width / 2,
            bottom: 0,
            title: 'Actividad',
            rating: '6/10',
            icon: Icons.directions_run_rounded,
            color: Colors.grey,
            iconPadding: const EdgeInsets.only(bottom: 40, left: 40),
          ),

          _buildCenterOrb(
            showProgressRing: widget.showProgressRing,
            progress: widget.progress,
          ),
        ],
      ),
    );
  }
}

class _QuadrantIcon extends StatelessWidget {
  final Alignment alignment;
  final IconData icon;
  final Color color;

  const _QuadrantIcon({
    required this.alignment,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Icon(
        icon,
        color: color,
        size: 36,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class _QuadrantsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.saveLayer(rect, Paint());

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 75.0
      ..strokeCap = StrokeCap.butt;

    final double startAngle = -pi / 2;
    final double quadrant = pi / 2;

    // Sleep (Durazno suave - semaforoAmarillo)
    paint.shader = const LinearGradient(
      colors: [Color(0xFFFED7AA), AppColors.semaforoAmarillo],
    ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 37.5),
      startAngle,
      quadrant,
      false,
      paint,
    );

    // Food (Verde esmeralda - semaforoVerde)
    paint.shader = const LinearGradient(
      colors: [Color(0xFFA7F3D0), AppColors.semaforoVerde],
    ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 37.5),
      startAngle + quadrant,
      quadrant,
      false,
      paint,
    );

    // Activity (Coral/Rosa - semaforoRojo)
    paint.shader = const LinearGradient(
      colors: [Color(0xFFFECDD3), AppColors.semaforoRojo],
    ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 37.5),
      startAngle + 2 * quadrant,
      quadrant,
      false,
      paint,
    );

    // Water (Lavanda suave - paleta de la app)
    paint.shader = const LinearGradient(
      colors: [Color(0xFFDDD6FE), AppColors.lavenderLight],
    ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 37.5),
      startAngle + 3 * quadrant,
      quadrant,
      false,
      paint,
    );

    // Gaps
    final gapPaint = Paint()
      ..blendMode = BlendMode.clear
      ..style = PaintingStyle.fill;

    const gapWidth = 6.0;

    canvas.drawRect(
      Rect.fromCenter(center: center, width: gapWidth, height: size.height),
      gapPaint,
    );

    canvas.drawRect(
      Rect.fromCenter(center: center, width: size.width, height: gapWidth),
      gapPaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
