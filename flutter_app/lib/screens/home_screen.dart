import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_bottom_nav.dart';
import '../widgets/pawcation_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final quickServices = [
      (
        label: 'Pet Hotel',
        icon: Icons.hotel_rounded,
        route: '/pet-hotel',
        tint: const Color(0xFFE0F2FE),
        fg: PawcationColors.primaryDark,
      ),
      (
        label: 'Konsultasi',
        icon: Icons.medical_services_rounded,
        route: '/vet-consult',
        tint: const Color(0xFFE6F7F4),
        fg: PawcationColors.success,
      ),
      (
        label: 'Live Cam',
        icon: Icons.videocam_rounded,
        route: '/live',
        tint: const Color(0xFFFEF3C7),
        fg: PawcationColors.warning,
      ),
      (
        label: 'Pet Taxi',
        icon: Icons.local_taxi_rounded,
        route: '/pet-taxi',
        tint: const Color(0xFFEDE9FE),
        fg: const Color(0xFF6D28D9),
      ),
      (
        label: 'Jadwal',
        icon: Icons.calendar_month_rounded,
        route: '/schedule',
        tint: const Color(0xFFE0F2FE),
        fg: PawcationColors.primary,
      ),
      (
        label: 'Pet Medical',
        icon: Icons.favorite_rounded,
        route: '/medical',
        tint: const Color(0xFFFEE2E2),
        fg: PawcationColors.danger,
      ),
    ];

    return Scaffold(
      appBar: PawcationAppBar(
        showBack: false,
        trailing: PawcationNotificationAction(
          onTap: () => Navigator.pushNamed(context, '/schedule'),
        ),
      ),
      bottomNavigationBar: PawcationBottomNav(
        currentIndex: 0,
        onTap: (idx) {
          switch (idx) {
            case 1:
              Navigator.pushNamed(context, '/marketplace');
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
              break;
            case 3:
              Navigator.pushNamed(context, '/vet-consult');
              break;
            case 4:
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Row
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/account'),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/dodo_avatar.png',
                      width: 46,
                      height: 46,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, ${state.ownerName.split(' ').first} & Dodo! 👋',
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.w900,
                          color: PawcationColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Suite Room A-12 • Aktivitas jam 14:00',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: PawcationColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: PawcationColors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: PawcationColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          size: 18,
                          color: PawcationColors.primaryDark,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${state.cartCount}',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: PawcationColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hero Blue Promo Banner (matches Flow 1 top banner in overview)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    PawcationColors.primary,
                    PawcationColors.primaryDark,
                  ],
                ),
                boxShadow: PawcationTheme.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const PawcationPillBadge(
                        label: 'LIVE BOARDING • SUITE A-12',
                        backgroundColor: Color(0x33FFFFFF),
                        textColor: PawcationColors.white,
                        dotColor: Color(0xFF4ADE80),
                      ),
                      const Spacer(),
                      Text(
                        '${state.pawPoints} Pts',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dodo sedang nyaman\ndi Pawcation Sanctuary 🐾',
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.25,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Pantau kamera 24 jam, jadwalkan grooming, atau konsultasi dokter kapan saja.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.4,
                      color: Color(0xFFE0F2FE),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/live'),
                        icon: const Icon(Icons.videocam_rounded, size: 17),
                        label: const Text('Pantau Live'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PawcationColors.white,
                          foregroundColor: PawcationColors.primaryDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/pet-hotel'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: PawcationColors.white,
                          side: const BorderSide(color: Color(0x88FFFFFF)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                        ),
                        child: const Text('Pesan Hotel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Layanan Pawcation 2x3 Grid
            const Text(
              'Layanan Pawcation',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w800,
                color: PawcationColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 20) / 3;
                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: quickServices.map((svc) {
                    return SizedBox(
                      width: itemWidth,
                      child: PawcationCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 14,
                        ),
                        borderRadius: 18,
                        onTap: () => Navigator.pushNamed(context, svc.route),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: svc.tint,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(svc.icon, color: svc.fg, size: 22),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              svc.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: PawcationColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 20),

            // Rekomendasi Produk
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Belanja Kebutuhan Anabul',
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      color: PawcationColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/marketplace'),
                  child: const Text(
                    'Lihat Semua →',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: PawcationColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: DummyData.products.take(2).map((product) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: product.id == 'p1' ? 6 : 0,
                      left: product.id == 'p2' ? 6 : 0,
                    ),
                    child: PawcationCard(
                      padding: const EdgeInsets.all(12),
                      borderRadius: 20,
                      onTap: () => Navigator.pushNamed(context, '/marketplace'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 82,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: PawcationColors.primaryTint,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              product.emoji,
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                          const SizedBox(height: 10),
                          PawcationPillBadge(
                            label: product.badge,
                            backgroundColor: PawcationColors.primarySoft,
                            textColor: PawcationColors.primaryDark,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: PawcationColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DummyData.formatRupiah(product.price),
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w900,
                              color: PawcationColors.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                state.addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${product.name} ditambahkan ke keranjang',
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: PawcationColors.primary,
                                foregroundColor: PawcationColors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ),
                              child: const Text(
                                '+ Keranjang',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
