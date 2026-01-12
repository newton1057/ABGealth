import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'device_detail_screen.dart';
import 'add_device_screen.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final devices = const [
      _DeviceItem(
        name: 'Apple Watch',
        status: 'Sincronizado',
        lastSync: 'Hace 5 min',
        icon: Icons.watch,
        color: AppColors.accentGreen,
      ),
      _DeviceItem(
        name: 'Balanza inteligente',
        status: 'Conectada',
        lastSync: 'Hace 2 horas',
        icon: Icons.monitor_weight_outlined,
        color: AppColors.primary,
      ),
      _DeviceItem(
        name: 'Banda de actividad',
        status: 'Pendiente',
        lastSync: 'Sin datos recientes',
        icon: Icons.directions_run,
        color: AppColors.warning,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SyncCard(),
            const SizedBox(height: 18),
            Text(
              'Dispositivos conectados',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...devices.map((device) => _DeviceTile(device: device)),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddDeviceScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Agregar dispositivo',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SyncCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.sync, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sincronizacion activa',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Ultima actualizacion hace 5 minutos',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Online',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accentGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceItem {
  const _DeviceItem({
    required this.name,
    required this.status,
    required this.lastSync,
    required this.icon,
    required this.color,
  });

  final String name;
  final String status;
  final String lastSync;
  final IconData icon;
  final Color color;
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({required this.device});

  final _DeviceItem device;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeviceDetailScreen(
                  deviceName: device.name,
                  status: device.status,
                  lastSync: device.lastSync,
                  icon: device.icon,
                  color: device.color,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: device.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(device.icon, color: device.color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        device.status,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: device.color,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        device.lastSync,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
