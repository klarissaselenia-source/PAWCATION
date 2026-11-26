import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class PetHotelScreen extends StatefulWidget {
  const PetHotelScreen({super.key});

  @override
  State<PetHotelScreen> createState() => _PetHotelScreenState();
}

class _PetHotelScreenState extends State<PetHotelScreen> {
  String _selectedRoomId = DummyData.hotelRooms[0].id;
  int _nights = 2;
  final Map<String, int> _extras = {
    'Grooming Harian': 75000,
    'Live CCTV 24 Jam': 35000,
    'Extra Playtime Sore': 40000,
    'Menu Makanan Khusus': 50000,
  };
  final Set<String> _selectedExtras = {'Live CCTV 24 Jam'};

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final room = DummyData.hotelRooms.firstWhere((r) => r.id == _selectedRoomId);
    final extraTotal = _selectedExtras.fold(
      0,
      (sum, key) => sum + (_extras[key] ?? 0),
    );
    final total = (room.pricePerNight * _nights) + extraTotal;

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PawcationPillBadge(
              label: 'PET HOTEL SANCTUARY',
              icon: Icons.hotel_rounded,
            ),
            const SizedBox(height: 8),
            const Text(
              'Pesan Kamar Pet Hotel 🏨',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            // Check-in / Duration Card
            PawcationCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Check-in',
                              style: TextStyle(
                                fontSize: 12,
                                color: PawcationColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Sab, 21 Okt • 13:00',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _nights > 1
                                ? () => setState(() => _nights--)
                                : null,
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '$_nights Malam',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: PawcationColors.primaryDark,
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() => _nights++),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Pilih Tipe Kamar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),

            ...DummyData.hotelRooms.map((item) {
              final selected = item.id == _selectedRoomId;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PawcationCard(
                  padding: const EdgeInsets.all(16),
                  border: Border.all(
                    color: selected
                        ? PawcationColors.primary
                        : PawcationColors.border,
                    width: selected ? 2 : 1,
                  ),
                  onTap: () => setState(() => _selectedRoomId = item.id),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          PawcationPillBadge(
                            label: item.badge,
                            backgroundColor: selected
                                ? PawcationColors.primarySoft
                                : PawcationColors.inputFill,
                            textColor: selected
                                ? PawcationColors.primaryDark
                                : PawcationColors.textSecondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: PawcationColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: item.facilities
                            .map((f) => PawcationPillBadge(
                                  label: f,
                                  backgroundColor: PawcationColors.primaryTint,
                                  textColor: PawcationColors.primaryDark,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${DummyData.formatRupiah(item.pricePerNight)} / malam',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: PawcationColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 6),
            const Text(
              'Layanan Tambahan (Add-on)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),

            PawcationCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Column(
                children: _extras.entries.map((entry) {
                  final checked = _selectedExtras.contains(entry.key);
                  return CheckboxListTile(
                    value: checked,
                    activeColor: PawcationColors.primary,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      entry.key,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '+ ${DummyData.formatRupiah(entry.value)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: PawcationColors.primaryDark,
                      ),
                    ),
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          _selectedExtras.add(entry.key);
                        } else {
                          _selectedExtras.remove(entry.key);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            PawcationCard(
              padding: const EdgeInsets.all(16),
              color: PawcationColors.primaryTint,
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimasi Total',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                        Text(
                          'Termasuk laporan harian',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: PawcationColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DummyData.formatRupiah(total),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.navyAccent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            PawcationPrimaryButton(
              label: 'Konfirmasi & Bayar Kamar',
              trailingIcon: Icons.arrow_forward_rounded,
              onPressed: () {
                state.completePayment(
                  totalAmount: total,
                  summaryText: '${room.name} ($_nights Malam)',
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
