import 'package:flutter/material.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class PetMedicalScreen extends StatelessWidget {
  const PetMedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/dodo_avatar.png',
                width: 86,
                height: 86,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Dodo 🐶',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Toy Poodle • ID: #PC-MC-2022-8819',
              style: TextStyle(
                fontSize: 12.5,
                color: PawcationColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            // 2x2 Vitals Grid
            Row(
              children: const [
                Expanded(child: _VitalCard('Berat Badan', '5.2 kg', 'Ideal')),
                SizedBox(width: 10),
                Expanded(child: _VitalCard('Suhu Tubuh', '38.4°C', 'Normal')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Expanded(child: _VitalCard('Status Vaksin', 'Lengkap', 'Aktif')),
                SizedBox(width: 10),
                Expanded(child: _VitalCard('Alergi', 'Ayam', 'Catatan')),
              ],
            ),
            const SizedBox(height: 16),

            // Navy Digital Medical Card (matches dark card in overview)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: PawcationColors.navyAccent,
                borderRadius: BorderRadius.circular(22),
                boxShadow: PawcationTheme.cardShadow,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_user_rounded,
                          color: PawcationColors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'PASPOR VAKSIN DIGITAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFBAE6FD),
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Rabies & DHPPi Terverifikasi',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Vaksin Terakhir: Agustus 2025 • Booster Berikutnya: 24 Des 2026',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFFE0F2FE),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            PawcationCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Riwayat Pemeriksaan Medis',
                    style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 12),
                  _MedicalEntry(
                    title: 'Pemeriksaan Umum & Kebersihan Telinga',
                    date: '12 Okt 2024 • drh. Amanda Saraswati, M.Si',
                    status: 'Sehat',
                  ),
                  Divider(height: 20),
                  _MedicalEntry(
                    title: 'Vaksinasi Rabies Tahunan',
                    date: '18 Agu 2025 • Klinik Pawcation Kemang',
                    status: 'Sah',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            PawcationPrimaryButton(
              label: 'Kembali ke Jadwal & Agenda',
              leadingIcon: Icons.calendar_month_rounded,
              onPressed: () => Navigator.pushNamed(context, '/schedule'),
            ),
          ],
        ),
      ),
    );
  }
}

class _VitalCard extends StatelessWidget {
  final String label;
  final String value;
  final String tag;

  const _VitalCard(this.label, this.value, this.tag);

  @override
  Widget build(BuildContext context) {
    return PawcationCard(
      padding: const EdgeInsets.all(14),
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: PawcationColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w900,
                    color: PawcationColors.textPrimary,
                  ),
                ),
              ),
              PawcationPillBadge(
                label: tag,
                backgroundColor: PawcationColors.primarySoft,
                textColor: PawcationColors.primaryDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MedicalEntry extends StatelessWidget {
  final String title;
  final String date;
  final String status;

  const _MedicalEntry({
    required this.title,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: PawcationColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        PawcationPillBadge(
          label: status,
          backgroundColor: PawcationColors.successSoft,
          textColor: PawcationColors.success,
        ),
      ],
    );
  }
}
