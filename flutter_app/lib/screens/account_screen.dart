import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_bottom_nav.dart';
import '../widgets/pawcation_card.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      bottomNavigationBar: PawcationBottomNav(
        currentIndex: 4,
        onTap: (idx) {
          switch (idx) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/marketplace');
              break;
            case 2:
              Navigator.pushNamed(context, '/schedule');
              break;
            case 3:
              Navigator.pushNamed(context, '/vet-consult');
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Owner Profile Card
            PawcationCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: PawcationColors.primarySoft,
                    child: Icon(
                      Icons.person_rounded,
                      size: 30,
                      color: PawcationColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.ownerName,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.ownerEmail,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        PawcationPillBadge(
                          label: '${state.pawPoints} PawPoints • Sanctuary Member',
                          icon: Icons.stars_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Pet Profile Card -> Pet Medical
            PawcationCard(
              padding: const EdgeInsets.all(16),
              color: PawcationColors.primaryTint,
              onTap: () => Navigator.pushNamed(context, '/medical'),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/dodo_avatar.png',
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Dodo',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(width: 8),
                            PawcationPillBadge(
                              label: 'Sedang Boarding',
                              backgroundColor: PawcationColors.successSoft,
                              textColor: PawcationColors.success,
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Toy Poodle • 2 Tahun • 5.2 kg',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: PawcationColors.primaryDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Pengaturan Akun & Layanan',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),

            PawcationCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.medical_information_outlined,
                      color: PawcationColors.primary,
                    ),
                    title: const Text(
                      'Rekam Medis & Buku Vaksin',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => Navigator.pushNamed(context, '/medical'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.receipt_long_outlined,
                      color: PawcationColors.primary,
                    ),
                    title: const Text(
                      'Riwayat Pembayaran',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => Navigator.pushNamed(context, '/payment-status'),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    secondary: const Icon(
                      Icons.notifications_active_outlined,
                      color: PawcationColors.primary,
                    ),
                    title: const Text(
                      'Notifikasi Jadwal & Vaksin',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    value: state.reminderNotificationsEnabled,
                    activeColor: PawcationColors.primary,
                    onChanged: state.toggleReminderNotifications,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                ),
                icon: const Icon(Icons.logout_rounded, color: PawcationColors.danger),
                label: const Text(
                  'Keluar Akun',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: PawcationColors.danger,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: PawcationColors.dangerSoft),
                  backgroundColor: PawcationColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
