import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _deliveryMethod = 'Antar via Pet Taxi';
  bool _usePawPoints = false;

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final subtotal = state.cartSubtotal;
    final shipping = subtotal == 0 ? 0 : 15000;
    final discount = _usePawPoints ? 15000 : 0;
    final total = (subtotal + shipping - discount).clamp(0, 999999999);

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Keranjang Saya 🛒',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.textPrimary,
                    ),
                  ),
                ),
                PawcationPillBadge(
                  label: '${state.cartCount} Item',
                  backgroundColor: PawcationColors.primarySoft,
                  textColor: PawcationColors.primaryDark,
                ),
              ],
            ),
            const SizedBox(height: 14),

            if (state.cart.isEmpty)
              PawcationCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text('🐾', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: 8),
                    const Text(
                      'Keranjang masih kosong',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    PawcationPrimaryButton(
                      label: 'Belanja Sekarang',
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/marketplace'),
                    ),
                  ],
                ),
              )
            else ...[
              ...state.cart.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PawcationCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Checkbox(
                            value: entry.selected,
                            activeColor: PawcationColors.primary,
                            onChanged: (_) =>
                                state.toggleCartSelection(entry.product.id),
                          ),
                          Container(
                            width: 54,
                            height: 54,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: PawcationColors.primaryTint,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              entry.product.emoji,
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.product.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: PawcationColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  entry.product.weightLabel,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: PawcationColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  DummyData.formatRupiah(entry.product.price),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: PawcationColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _QtyButton(
                                icon: Icons.remove_rounded,
                                onTap: () =>
                                    state.updateQuantity(entry.product.id, -1),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '${entry.quantity}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              _QtyButton(
                                icon: Icons.add_rounded,
                                onTap: () =>
                                    state.updateQuantity(entry.product.id, 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),

              const SizedBox(height: 8),
              PawcationCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Opsi Pengiriman',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...[
                      'Antar via Pet Taxi',
                      'Kurir Instant Pawcation',
                      'Ambil di Cabang Kemang',
                    ].map((opt) {
                      final selected = _deliveryMethod == opt;
                      return RadioListTile<String>(
                        value: opt,
                        groupValue: _deliveryMethod,
                        onChanged: (v) =>
                            setState(() => _deliveryMethod = v ?? opt),
                        activeColor: PawcationColors.primary,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          opt,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // PawPoints switch
              PawcationCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SwitchListTile(
                  value: _usePawPoints,
                  onChanged: (v) => setState(() => _usePawPoints = v),
                  activeColor: PawcationColors.primary,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Tukar ${state.pawPoints} PawPoints (-Rp 15.000)',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Payment Summary
              PawcationCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _SummaryRow('Subtotal Produk', subtotal),
                    const SizedBox(height: 8),
                    _SummaryRow('Ongkos Kirim', shipping),
                    if (_usePawPoints) ...[
                      const SizedBox(height: 8),
                      const _SummaryRow('Diskon PawPoints', -15000),
                    ],
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: PawcationColors.divider),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          DummyData.formatRupiah(total),
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            color: PawcationColors.navyAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              PawcationPrimaryButton(
                label: 'Bayar Sekarang (${DummyData.formatRupiah(total)})',
                trailingIcon: Icons.arrow_forward_rounded,
                onPressed: total <= 0
                    ? null
                    : () {
                        final summary = state.cart
                            .where((e) => e.selected)
                            .map((e) => '${e.product.name} (${e.quantity}x)')
                            .join(', ');
                        state.completePayment(
                          totalAmount: total,
                          summaryText: summary,
                        );
                        Navigator.pushNamed(context, '/payment-status');
                      },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: PawcationColors.inputFill,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 16, color: PawcationColors.textPrimary),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final int amount;

  const _SummaryRow(this.label, this.amount);

  @override
  Widget build(BuildContext context) {
    final formatted = amount < 0
        ? '-${DummyData.formatRupiah(-amount)}'
        : DummyData.formatRupiah(amount);
    return Row(
      children: [
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
          formatted,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: amount < 0
                ? PawcationColors.success
                : PawcationColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
