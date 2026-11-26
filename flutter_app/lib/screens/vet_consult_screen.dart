import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class VetConsultScreen extends StatefulWidget {
  const VetConsultScreen({super.key});

  @override
  State<VetConsultScreen> createState() => _VetConsultScreenState();
}

class _VetConsultScreenState extends State<VetConsultScreen> {
  String _selectedVetId = DummyData.vets[0].id;
  String _selectedMode = 'Chat Online';
  String _selectedSlot = '14:30';
  final _complaintController = TextEditingController();

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final vet = DummyData.vets.firstWhere((v) => v.id == _selectedVetId);

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Konsultasi Dokter Hewan 🩺',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pilih dokter hewan berlisensi & waktu konsultasi untuk Dodo.',
              style: TextStyle(
                fontSize: 13,
                color: PawcationColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),

            ...DummyData.vets.map((item) {
              final selected = item.id == _selectedVetId;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PawcationCard(
                  padding: const EdgeInsets.all(14),
                  border: Border.all(
                    color: selected
                        ? PawcationColors.primary
                        : PawcationColors.border,
                    width: selected ? 2 : 1,
                  ),
                  onTap: () => setState(() => _selectedVetId = item.id),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: PawcationColors.primarySoft,
                        child: const Icon(
                          Icons.medical_services_rounded,
                          color: PawcationColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                const PawcationPillBadge(
                                  label: 'Online',
                                  dotColor: PawcationColors.success,
                                  backgroundColor: PawcationColors.successSoft,
                                  textColor: PawcationColors.success,
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${item.specialty} • ★ ${item.rating}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: PawcationColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 10),
            const Text(
              'Metode & Jadwal',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Chat Online', 'Video Call', 'Kunjungan Klinik']
                  .map((m) {
                final selected = _selectedMode == m;
                return ChoiceChip(
                  label: Text(m),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedMode = m),
                  selectedColor: PawcationColors.primary,
                  backgroundColor: PawcationColors.white,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? PawcationColors.white
                        : PawcationColors.textPrimary,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['14:30', '15:00', '16:15', '19:00'].map((slot) {
                final selected = _selectedSlot == slot;
                return ChoiceChip(
                  label: Text('$slot WIB'),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedSlot = slot),
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

            const Text(
              'Keluhan / Catatan Singkat',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _complaintController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Ceritakan kondisi Dodo saat ini...',
                filled: true,
                fillColor: PawcationColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: PawcationColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(color: PawcationColors.border),
                ),
              ),
            ),
            const SizedBox(height: 18),

            PawcationCard(
              padding: const EdgeInsets.all(16),
              color: PawcationColors.primaryTint,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Biaya Konsultasi',
                          style: TextStyle(
                            fontSize: 12,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                        Text(
                          DummyData.formatRupiah(vet.fee),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: PawcationColors.navyAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      state.completePayment(
                        totalAmount: vet.fee,
                        summaryText:
                            'Konsultasi $_selectedMode ($_selectedSlot) - ${vet.name}',
                      );
                      Navigator.pushNamed(context, '/consult-chat');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PawcationColors.primary,
                      foregroundColor: PawcationColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      'Mulai Chat',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            PawcationSoftButton(
              label: 'Bayar & Jadwalkan Sesi',
              onPressed: () {
                state.completePayment(
                  totalAmount: vet.fee,
                  summaryText:
                      'Konsultasi $_selectedMode ($_selectedSlot) - ${vet.name}',
                );
                Navigator.pushNamed(context, '/payment-status');
              },
            ),
          ],
        ),
      ),
    );
  }
}
