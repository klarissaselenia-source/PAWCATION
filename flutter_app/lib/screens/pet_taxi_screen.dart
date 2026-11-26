import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class PetTaxiScreen extends StatefulWidget {
  const PetTaxiScreen({super.key});

  @override
  State<PetTaxiScreen> createState() => _PetTaxiScreenState();
}

class _PetTaxiScreenState extends State<PetTaxiScreen> {
  String _selectedFleet = 'PawCar Standard';

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final fare = _selectedFleet == 'PawCar Standard' ? 45000 : 75000;

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pemesanan Pet Taxi 🚕',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Map/Route preview card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PawcationColors.primarySoft,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: PawcationColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      PawcationPillBadge(
                        label: 'ETA 8 Menit',
                        icon: Icons.near_me_rounded,
                        backgroundColor: PawcationColors.white,
                        textColor: PawcationColors.primaryDark,
                      ),
                      Spacer(),
                      Text(
                        '4.2 km',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.navyAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  _RouteStop(
                    color: PawcationColors.primary,
                    label: 'Jemput',
                    address: 'Rumah Sele • Jl. Kemang Raya No. 18',
                  ),
                  SizedBox(height: 10),
                  _RouteStop(
                    color: PawcationColors.success,
                    label: 'Tujuan',
                    address: 'Pawcation Salon & Spa (Cabang Malang)',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Fleet Options
            const Text(
              'Pilih Armada Pet-Safe',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            ...['PawCar Standard', 'PawVan AC + Crate'].map((fleet) {
              final selected = _selectedFleet == fleet;
              final price = fleet == 'PawCar Standard' ? 45000 : 75000;
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
                  onTap: () => setState(() => _selectedFleet = fleet),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: PawcationColors.primarySoft,
                        child: Icon(
                          Icons.local_taxi_rounded,
                          color: PawcationColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fleet,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Text(
                              'Disinfeksi UV • Driver tersertifikasi',
                              style: TextStyle(
                                fontSize: 12,
                                color: PawcationColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        DummyData.formatRupiah(price),
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          color: PawcationColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Driver Card
            PawcationCard(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: PawcationColors.primarySoft,
                    child: Icon(
                      Icons.person_rounded,
                      color: PawcationColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mas Budi • B 1824 PAW',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '★ 4.9 • 320+ perjalanan anabul',
                          style: TextStyle(
                            fontSize: 12,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/consult-chat'),
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: PawcationColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            PawcationPrimaryButton(
              label: 'Pesan Pet Taxi (${DummyData.formatRupiah(fare)})',
              trailingIcon: Icons.arrow_forward_rounded,
              onPressed: () {
                state.completePayment(
                  totalAmount: fare,
                  summaryText: 'Pet Taxi ($_selectedFleet) • Antar Dodo',
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

class _RouteStop extends StatelessWidget {
  final Color color;
  final String label;
  final String address;

  const _RouteStop({
    required this.color,
    required this.label,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: PawcationColors.textSecondary,
                ),
              ),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w800,
                  color: PawcationColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
