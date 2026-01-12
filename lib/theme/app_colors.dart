import 'package:flutter/material.dart';

class AppColors {
  // Primary palette
  static const primary = Color(0xFF382A5F);
  static const primaryDark = Color(0xFF2D214C);
  static const primaryLight = Color(0xFF60557F);

  // Accent colors
  static const accentOrange = Color(0xFFFF7A00);
  static const accentBlue = Color(0xFF3B82F6);
  static const accentGreen = Color(0xFF22C55E);
  static const accentTeal = Color(0xFF14B8A6);
  static const accentIndigo = Color(0xFF6366F1);
  static const mintBright = Color(0xFF55FFA9);
  static const lavenderLight = Color(0xFFB2B0D6);

  // Background & Surface
  static const background = Color(0xFFF8F5F2); // Bone white
  static const card = Color(0xFFFFFFFF);

  // Text colors
  static const textPrimary = Color(0xFF1F1B2E);
  static const textSecondary = Color(0xFF7D7290);

  // Utility colors
  static const border = Color(0xFFE9E3F3);
  static const muted = Color(0xFFF1ECF7);
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF97316);
  static const info = Color(0xFF0EA5E9);

  // Semáforo colors (tonos suaves que combinan con la paleta)
  static const semaforoVerde = Color(0xFF6EE7B7);    // Verde esmeralda suave
  static const semaforoAmarillo = Color(0xFFFDBA74); // Durazno suave
  static const semaforoRojo = Color(0xFFFDA4AF);     // Coral/rosa suave

  // Modern shadow & glass colors
  static const shadowColor = Color(0xFF1F1B2E);
  static const surfaceBlur = Color(0xD9FFFFFF);
  static const glassWhite = Color(0x80FFFFFF);
  static const glassBorder = Color(0x40FFFFFF);
  static const overlayDark = Color(0x1A1F1B2E);
  static const shimmerBase = Color(0xFFE8E4EF);
  static const shimmerHighlight = Color(0xFFF5F3F8);

  // Primary gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, Color(0xFF5B4B8A)],
  );

  // Accent gradients
  static const LinearGradient accentBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF60A5FA), accentBlue],
  );

  static const LinearGradient accentGreenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4ADE80), accentGreen],
  );

  static const LinearGradient accentIndigoGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF818CF8), accentIndigo],
  );

  static const LinearGradient accentTealGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2DD4BF), accentTeal],
  );

  static const LinearGradient accentOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFBBF24), accentOrange],
  );

  // Glass overlay gradient (for glassmorphism highlights)
  static const LinearGradient glassHighlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x30FFFFFF), Color(0x10FFFFFF)],
  );

  // Premium dark gradient (for hero cards)
  static const LinearGradient premiumDarkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2B0B48), Color(0xFF7C2AE8)],
  );

  // Soft shadows preset
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: shadowColor.withOpacity(0.06),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: shadowColor.withOpacity(0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  // Elevated shadow preset
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: shadowColor.withOpacity(0.08),
      blurRadius: 24,
      offset: const Offset(0, 12),
      spreadRadius: -6,
    ),
    BoxShadow(
      color: shadowColor.withOpacity(0.05),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  // Glow shadow for FAB/highlighted elements
  static List<BoxShadow> glowShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.35),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: color.withOpacity(0.2),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
}
