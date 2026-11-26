import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final earnedPoints = state.lastPaidAmount ~/ 10000;

    return Scaffold(
      appBar: PawcationAppBar(
        showBack: true,
        trailing: PawcationProfileCircleAction(
          onTap: () => Navigator.pushNamed(context, '/account'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 28),
        child: Column(
          children: [
            // Sub-header row
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: PawcationColors.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.receipt_long_rounded,
                    size: 17,
                    color: PawcationColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Status Pembayaran',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      color: PawcationColors.textPrimary,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: PawcationColors.inputFill,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: PawcationColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hero Success Card
            PawcationCard(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
              borderRadius: 26,
              child: Column(
                children: [
                  const PawcationPillBadge(
                    label: 'Pembayaran Berhasil!',
                    icon: Icons.check_circle_rounded,
                    backgroundColor: PawcationColors.successSoft,
                    textColor: PawcationColors.success,
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          'assets/images/payment_success_hero.png',
                          width: 240,
                          height: 225,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: PawcationColors.white,
                            borderRadius: BorderRadius.circular(999),
                            boxShadow: PawcationTheme.cardShadow,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🎉 ', style: TextStyle(fontSize: 13)),
                              Text(
                                'Hore! Pesanan Diproses',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                  color: PawcationColors.navyAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Total Terbayar',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: PawcationColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DummyData.formatRupiah(state.lastPaidAmount),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.navyAccent,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: PawcationColors.primaryTint,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.stars_rounded,
                          size: 18,
                          color: PawcationColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: PawcationColors.textPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: '+$earnedPoints PawPoints',
                                  style: const TextStyle(
                                    color: PawcationColors.navyAccent,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' berhasil ditambahkan!',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Rincian Transaksi Card
            PawcationCard(
              padding: const EdgeInsets.all(18),
              borderRadius: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Rincian Transaksi',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: PawcationColors.textPrimary,
                          ),
                        ),
                      ),
                      const PawcationPillBadge(
                        label: 'Terverifikasi Otomatis',
                        backgroundColor: PawcationColors.primarySoft,
                        textColor: PawcationColors.navyAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.tag_rounded,
                        size: 16,
                        color: PawcationColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'ID Transaksi',
                          style: TextStyle(
                            fontSize: 13,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                      ),
                      const Text(
                        '#PAW-202505-8910',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                            const ClipboardData(text: '#PAW-202505-8910'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('ID Transaksi disalin'),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.copy_rounded,
                          size: 16,
                          color: PawcationColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ReceiptRow(
                    icon: Icons.account_balance_outlined,
                    label: 'Metode Pembayaran',
                    value: state.lastPaymentMethod,
                  ),
                  const SizedBox(height: 12),
                  const _ReceiptRow(
                    icon: Icons.access_time_rounded,
                    label: 'Waktu Transaksi',
                    value: 'Hari ini, 14:32 WIB',
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: PawcationColors.primaryTint,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.pets_rounded,
                              size: 15,
                              color: PawcationColors.primary,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Untuk Anabul: ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: PawcationColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Dodo 🐶',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: PawcationColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          state.lastTransactionItems,
                          style: const TextStyle(
                            fontSize: 12.5,
                            height: 1.4,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // CTA Buttons
            PawcationPrimaryButton(
              label: 'Kembali ke Beranda',
              leadingIcon: Icons.home_outlined,
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              ),
            ),
            const SizedBox(height: 10),
            PawcationSoftButton(
              label: 'Lacak Status Pesanan',
              leadingIcon: Icons.local_shipping_outlined,
              foregroundColor: PawcationColors.navyAccent,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: PawcationColors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (_) => const Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pelacakan Pesanan #PAW-202505-8910',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 12),
                        ListTile(
                          leading: Icon(
                            Icons.check_circle_rounded,
                            color: PawcationColors.success,
                          ),
                          title: Text('Pembayaran Terverifikasi'),
                          subtitle: Text('Hari ini, 14:32 WIB'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.inventory_2_outlined,
                            color: PawcationColors.primary,
                          ),
                          title: Text('Pesanan Sedang Dikemas'),
                          subtitle: Text('Pawcation Hub Kemang'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invoice digital #PAW-202505-8910 siap'),
                  ),
                );
              },
              icon: const Icon(
                Icons.description_outlined,
                size: 16,
                color: PawcationColors.textSecondary,
              ),
              label: const Text(
                'Lihat Invoice / Bukti Pembayaran',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: PawcationColors.textPrimary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '🐾 Terima kasih telah mempercayakan kebutuhan anabulmu!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: PawcationColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ReceiptRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: PawcationColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: PawcationColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: PawcationColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
