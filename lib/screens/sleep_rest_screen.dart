import 'package:flutter/material.dart';

class SleepRestScreen extends StatefulWidget {
  const SleepRestScreen({super.key});

  @override
  State<SleepRestScreen> createState() => _SleepRestScreenState();
}

class _SleepRestScreenState extends State<SleepRestScreen> {
  int selectedTime = 0;
  int selectedMood = 2;

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFF0F172A);
    const surface = Color(0xFF1E293B);
    const accent = Color(0xFF2563EB);
    const muted = Color(0xFF334155);
    const textSecondary = Color(0xFF94A3B8);

    final times = ['10:30 pm', '11:00 pm', '11:30 pm', 'Otro horario'];
    final moods = const [
      _MoodOption(label: 'Mal', icon: Icons.sentiment_very_dissatisfied),
      _MoodOption(label: 'Regular', icon: Icons.sentiment_neutral),
      _MoodOption(label: 'Bien', icon: Icons.sentiment_satisfied),
    ];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Sueño & descanso',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dormir un poco mejor baja antojos y mejora tu ánimo.',
              style: TextStyle(color: textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Plan para dormir hoy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '¿A qué hora te quieres dormir hoy?',
                    style: TextStyle(color: textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.4,
                    children: List.generate(times.length, (index) {
                      final isSelected = selectedTime == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedTime = index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? accent : muted,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            times[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Guardar mi hora para dormir',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No buscamos perfección, solo que poco a poco duermas un poco mejor.',
                    style: TextStyle(color: textSecondary, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: muted),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '¿Cómo dormiste anoche?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(moods.length, (index) {
                      final mood = moods[index];
                      final isSelected = selectedMood == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedMood = index),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: index == 0 ? 0 : 6,
                              right: index == moods.length - 1 ? 0 : 6,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? accent : muted,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  mood.icon,
                                  color: isSelected ? Colors.white : textSecondary,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  mood.label,
                                  style: TextStyle(
                                    color:
                                        isSelected ? Colors.white : textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodOption {
  const _MoodOption({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
