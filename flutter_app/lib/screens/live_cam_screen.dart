import 'package:flutter/material.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class LiveCamScreen extends StatefulWidget {
  const LiveCamScreen({super.key});

  @override
  State<LiveCamScreen> createState() => _LiveCamScreenState();
}

class _LiveCamScreenState extends State<LiveCamScreen> {
  String _selectedCam = 'Kamera Suite A-12';
  bool _micEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'Live Monitoring Dodo 📹',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.textPrimary,
                    ),
                  ),
                ),
                PawcationPillBadge(
                  label: 'LIVE',
                  dotColor: PawcationColors.danger,
                  backgroundColor: PawcationColors.dangerSoft,
                  textColor: PawcationColors.danger,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Simulated live camera frame
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFF0F2B3C),
                boxShadow: PawcationTheme.cardShadow,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Opacity(
                      opacity: 0.9,
                      child: Image.asset(
                        'assets/images/dodo_avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x55000000), Color(0x99000000)],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            PawcationPillBadge(
                              label: _selectedCam,
                              backgroundColor: const Color(0x66000000),
                              textColor: PawcationColors.white,
                            ),
                            const Spacer(),
                            const PawcationPillBadge(
                              label: 'HD 1080p',
                              backgroundColor: Color(0x66000000),
                              textColor: PawcationColors.white,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Dodo sedang istirahat tenang',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: PawcationColors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  setState(() => _micEnabled = !_micEnabled),
                              style: IconButton.styleFrom(
                                backgroundColor: _micEnabled
                                    ? PawcationColors.primary
                                    : const Color(0x66000000),
                              ),
                              icon: Icon(
                                _micEnabled ? Icons.mic : Icons.mic_off,
                                color: PawcationColors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Camera angle switcher
            Wrap(
              spacing: 8,
              children: ['Kamera Suite A-12', 'Taman Bermain'].map((cam) {
                final selected = _selectedCam == cam;
                return ChoiceChip(
                  label: Text(cam),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCam = cam),
                  selectedColor: PawcationColors.primarySoft,
                  backgroundColor: PawcationColors.white,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? PawcationColors.primaryDark
                        : PawcationColors.textSecondary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Metrics Row
            Row(
              children: const [
                Expanded(
                  child: _LiveMetricCard(
                    icon: Icons.thermostat_rounded,
                    label: 'Suhu Kamar',
                    value: '23°C',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _LiveMetricCard(
                    icon: Icons.directions_run_rounded,
                    label: 'Aktivitas',
                    value: 'Aktif',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _LiveMetricCard(
                    icon: Icons.restaurant_rounded,
                    label: 'Makan',
                    value: 'Habis',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            PawcationCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Log Aktivitas Hari Ini',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  _TimelineItem('13:30 WIB', 'Jalan sore di taman indoor 20 menit'),
                  SizedBox(height: 8),
                  _TimelineItem('12:00 WIB', 'Makan siang Royal Canin + air segar'),
                  SizedBox(height: 8),
                  _TimelineItem('09:30 WIB', 'Pengecekan suhu & kebersihan suite'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            PawcationPrimaryButton(
              label: 'Chat Pengasuh / Dokter Jaga',
              leadingIcon: Icons.chat_bubble_outline_rounded,
              onPressed: () => Navigator.pushNamed(context, '/consult-chat'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveMetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _LiveMetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return PawcationCard(
      padding: const EdgeInsets.all(12),
      borderRadius: 18,
      child: Column(
        children: [
          Icon(icon, color: PawcationColors.primary, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: PawcationColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: PawcationColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String time;
  final String desc;

  const _TimelineItem(this.time, this.desc);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: PawcationColors.primaryDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(
              fontSize: 12.5,
              color: PawcationColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
