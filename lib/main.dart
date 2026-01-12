import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/prevention_screen.dart';
import 'screens/reports_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';
import 'widgets/modern_glass_card.dart';

void main() {
  runApp(const DemoodApp());
}

class DemoodApp extends StatelessWidget {
  const DemoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'demood',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(),
      home: const AuthWrapper(),
    );
  }
}

/// Wrapper widget that handles authentication state
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoggedIn = false;

  void _handleLogin() {
    setState(() => _isLoggedIn = true);
  }

  void _handleLogout() {
    setState(() => _isLoggedIn = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return const AppShell();
    }
    return LoginScreen(onLoginSuccess: _handleLogin);
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fabController;
  late Animation<double> _fabScaleAnimation;

  final List<Widget> _pages = const [
    HomeScreen(),
    PreventionScreen(),
    ReportsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _openQuickAdd() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: AppColors.glowShadow(AppColors.primary),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        'Agregar registro',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _QuickAddTile(
                    icon: Icons.monitor_weight_outlined,
                    color: AppColors.primary,
                    title: 'Registrar peso',
                    subtitle: 'Actualiza tu progreso semanal',
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  _QuickAddTile(
                    icon: Icons.water_drop_outlined,
                    color: AppColors.accentBlue,
                    title: 'Añadir agua',
                    subtitle: 'Suma vasos a tu meta diaria',
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  _QuickAddTile(
                    icon: Icons.nightlight_round,
                    color: AppColors.accentIndigo,
                    title: 'Registrar sueño',
                    subtitle: 'Cuántas horas dormiste hoy',
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  _QuickAddTile(
                    icon: Icons.notifications_active_outlined,
                    color: AppColors.accentGreen,
                    title: 'Nuevo recordatorio',
                    subtitle: 'Pastillas, ejercicios o citas',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      extendBody: true,
      floatingActionButton: GestureDetector(
        onTapDown: (_) => _fabController.forward(),
        onTapUp: (_) {
          _fabController.reverse();
          _openQuickAdd();
        },
        onTapCancel: () => _fabController.reverse(),
        child: AnimatedBuilder(
          animation: _fabScaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _fabScaleAnimation.value,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.mintBright,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mintBright.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: AppColors.mintBright.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 28,
                  color: AppColors.primary,
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: AppColors.mintBright.withValues(alpha: 0.2),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            destinations: [
              _buildNavDestination(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: 'Inicio',
                isSelected: _selectedIndex == 0,
              ),
              _buildNavDestination(
                icon: Icons.shield_outlined,
                selectedIcon: Icons.shield_rounded,
                label: 'Prevención',
                isSelected: _selectedIndex == 1,
              ),
              _buildNavDestination(
                icon: Icons.bar_chart_outlined,
                selectedIcon: Icons.bar_chart,
                label: 'Reportes',
                isSelected: _selectedIndex == 2,
              ),
              _buildNavDestination(
                icon: Icons.person_outline,
                selectedIcon: Icons.person,
                label: 'Perfil',
                isSelected: _selectedIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  NavigationDestination _buildNavDestination({
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return NavigationDestination(
      icon: Icon(icon, color: AppColors.textSecondary),
      selectedIcon: Icon(selectedIcon, color: AppColors.textPrimary),
      label: label,
    );
  }
}

class _QuickAddTile extends StatelessWidget {
  const _QuickAddTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ModernGlassCard(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.all(14),
      color: AppColors.muted,
      elevation: 2,
      enableHoverEffect: true,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.1)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
