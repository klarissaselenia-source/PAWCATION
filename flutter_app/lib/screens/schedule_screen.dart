import 'package:flutter/material.dart';
import '../models/pawcation_models.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    const days = [
      (name: 'Kam', num: 19, dotColor: null),
      (name: 'Jum', num: 20, dotColor: PawcationColors.success),
      (name: 'Sab', num: 21, dotColor: PawcationColors.white),
      (name: 'Min', num: 22, dotColor: null),
      (name: 'Sen', num: 23, dotColor: null),
      (name: 'Sel', num: 24, dotColor: PawcationColors.primary),
      (name: 'Rab', num: 25, dotColor: null),
    ];

    return Scaffold(
      appBar: PawcationAppBar(
        showBack: true,
        trailing: PawcationNotificationAction(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Semua pengingat aktif!')),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal & Agenda Anabul 📆',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          color: PawcationColors.textPrimary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pengingat vaksin, grooming rutin, dan janji temu dokter.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: PawcationColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: PawcationColors.primarySoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Jadwal diperbarui')),
                      );
                    },
                    icon: const Icon(
                      Icons.sync_rounded,
                      color: PawcationColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Summary Pills
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                PawcationPillBadge(
                  label: '${state.agendas.length} Jadwal Bulan Ini',
                  dotColor: PawcationColors.primary,
                  backgroundColor: PawcationColors.white,
                  textColor: PawcationColors.textPrimary,
                ),
                const PawcationPillBadge(
                  label: '1 Menunggu',
                  dotColor: PawcationColors.warning,
                  backgroundColor: PawcationColors.white,
                  textColor: PawcationColors.textPrimary,
                ),
                const PawcationPillBadge(
                  label: '1 Selesai',
                  dotColor: PawcationColors.success,
                  backgroundColor: PawcationColors.white,
                  textColor: PawcationColors.textPrimary,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Calendar Strip Card
            PawcationCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Oktober 2024',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const PawcationPillBadge(
                        label: 'Bulan Ini',
                        backgroundColor: PawcationColors.primarySoft,
                        textColor: PawcationColors.primaryDark,
                      ),
                      const Spacer(),
                      _CalendarArrow(
                        icon: Icons.chevron_left_rounded,
                        onTap: () => state.selectCalendarDay(20),
                      ),
                      const SizedBox(width: 6),
                      InkWell(
                        onTap: () => state.selectCalendarDay(21),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: PawcationColors.primarySoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            'Hari Ini',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: PawcationColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _CalendarArrow(
                        icon: Icons.chevron_right_rounded,
                        onTap: () => state.selectCalendarDay(24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: days.map((d) {
                      final isSelected = state.selectedCalendarDay == d.num;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => state.selectCalendarDay(d.num),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? PawcationColors.primary
                                  : PawcationColors.inputFill
                                      .withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  d.name,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? PawcationColors.white
                                        : PawcationColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${d.num}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isSelected
                                        ? PawcationColors.white
                                        : PawcationColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? PawcationColors.white
                                        : (d.dotColor ?? Colors.transparent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: PawcationColors.primaryTint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 15,
                          color: PawcationColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.selectedCalendarDay == 24
                                ? 'Selasa, 24 Okt • Vaksinasi Tahunan'
                                : 'Sabtu, ${state.selectedCalendarDay} Okt • 1 Sesi Grooming',
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: PawcationColors.textPrimary,
                            ),
                          ),
                        ),
                        const Text(
                          'Hari Ini',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: PawcationColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Agenda Terjadwal section header
            Row(
              children: [
                const Text(
                  'Agenda Terjadwal',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: PawcationColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: const BoxDecoration(
                    color: PawcationColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${state.agendas.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: PawcationColors.primaryDark,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Lihat Kalender Penuh',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: PawcationColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            ...state.agendas.map((agenda) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _AgendaCard(agenda: agenda),
                )),

            const SizedBox(height: 6),
            // Rekam Medis & E-Card section
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Rekam Medis & E-Card',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: PawcationColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/medical'),
                  child: const Text(
                    'Riwayat Lengkap',
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

            PawcationCard(
              color: PawcationColors.primaryTint,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: PawcationColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: PawcationColors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Buku Vaksin Digital Dodo',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: PawcationColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'ID Anabul: #PC-MC-2022-8819',
                              style: TextStyle(
                                fontSize: 12,
                                color: PawcationColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.qr_code_2_rounded,
                        size: 30,
                        color: PawcationColors.primaryDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: PawcationColors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vaksin Terakhir:',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: PawcationColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Agustus 2025\n(Rabies)',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                  color: PawcationColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Lengkap & Sah',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: PawcationColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: PawcationColors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Booster Mendatang:',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: PawcationColors.textSecondary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '24 Des 2026',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w800,
                                  color: PawcationColors.primaryDark,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'DHPPi Booster #2',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: PawcationColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  PawcationWhitePillButton(
                    label: 'Buka E-Card & Paspor Vaksin',
                    leading: const Icon(
                      Icons.badge_outlined,
                      size: 18,
                      color: PawcationColors.primaryDark,
                    ),
                    height: 42,
                    onPressed: () => Navigator.pushNamed(context, '/medical'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Bottom CTA
            PawcationPrimaryButton(
              label: '+ Tambah Jadwal Baru (Jadwalkan Layanan)',
              leadingIcon: Icons.add_circle_outline_rounded,
              onPressed: () => _showAddAgendaSheet(context, state),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAgendaSheet(BuildContext context, PawcationAppState state) {
    final titleCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: PawcationColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Jadwal Baru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: PawcationColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleCtrl,
                decoration: InputDecoration(
                  hintText: 'Contoh: Vitamin Bulanan / Nail Trim',
                  filled: true,
                  fillColor: PawcationColors.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PawcationPrimaryButton(
                label: 'Simpan ke Agenda',
                onPressed: () {
                  final text = titleCtrl.text.trim().isEmpty
                      ? 'Perawatan Spa & Nail Trim'
                      : titleCtrl.text.trim();
                  state.addAgenda(
                    AgendaItem(
                      id: 'a${state.agendas.length + 1}',
                      timeBadge: 'Baru',
                      petLabel: 'Dodo • Poodle',
                      statusLabel: 'Terjadwal',
                      status: AgendaStatus.scheduled,
                      title: text,
                      dateTimeLabel: 'Min, 22 Okt • 09:30 WIB',
                      location: 'Pawcation Salon & Care',
                      personLabel: 'Tim Perawat Pawcation',
                      noteLabel: 'Pengingat otomatis aktif.',
                      primaryActionLabel: 'Detail Jadwal',
                      secondaryActionLabel: 'Ingatkan',
                      dayOfMonth: 22,
                    ),
                  );
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CalendarArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CalendarArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: PawcationColors.inputFill,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: PawcationColors.textSecondary),
      ),
    );
  }
}

class _AgendaCard extends StatelessWidget {
  final AgendaItem agenda;

  const _AgendaCard({required this.agenda});

  @override
  Widget build(BuildContext context) {
    final isConfirmed = agenda.status == AgendaStatus.confirmed;
    final badgeBg = isConfirmed
        ? PawcationColors.primarySoft
        : PawcationColors.inputFill;
    final badgeFg = isConfirmed
        ? PawcationColors.primaryDark
        : PawcationColors.textSecondary;

    return PawcationCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: PawcationColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isConfirmed
                      ? Icons.bathtub_outlined
                      : (agenda.status == AgendaStatus.scheduled
                          ? Icons.vaccines_outlined
                          : Icons.medical_information_outlined),
                  color: PawcationColors.primary,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        PawcationPillBadge(
                          label: agenda.timeBadge,
                          backgroundColor: PawcationColors.primarySoft,
                          textColor: PawcationColors.primaryDark,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            agenda.petLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: PawcationColors.textPrimary,
                            ),
                          ),
                        ),
                        PawcationPillBadge(
                          label: agenda.statusLabel,
                          backgroundColor: badgeBg,
                          textColor: badgeFg,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      agenda.title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: PawcationColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      agenda.dateTimeLabel,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: isConfirmed
                            ? PawcationColors.primaryDark
                            : PawcationColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PawcationColors.primaryTint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoLine(icon: Icons.storefront_outlined, text: agenda.location),
                const SizedBox(height: 5),
                _InfoLine(
                    icon: Icons.person_outline_rounded, text: agenda.personLabel),
                const SizedBox(height: 5),
                _InfoLine(
                  icon: isConfirmed
                      ? Icons.local_taxi_outlined
                      : Icons.info_outline_rounded,
                  text: agenda.noteLabel,
                  highlight: isConfirmed,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('${agenda.secondaryActionLabel} diaktifkan'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.notifications_active_outlined, size: 16),
                  label: Text(
                    agenda.secondaryActionLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PawcationColors.textPrimary,
                    side: const BorderSide(color: PawcationColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (isConfirmed) {
                      Navigator.pushNamed(context, '/pet-taxi');
                    } else {
                      Navigator.pushNamed(context, '/medical');
                    }
                  },
                  icon: Icon(
                    isConfirmed ? Icons.near_me_outlined : Icons.checklist_rounded,
                    size: 16,
                  ),
                  label: Text(
                    agenda.primaryActionLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isConfirmed
                        ? PawcationColors.primary
                        : PawcationColors.white,
                    foregroundColor: isConfirmed
                        ? PawcationColors.white
                        : PawcationColors.primaryDark,
                    elevation: 0,
                    side: isConfirmed
                        ? BorderSide.none
                        : const BorderSide(color: PawcationColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool highlight;

  const _InfoLine({
    required this.icon,
    required this.text,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: highlight
              ? PawcationColors.primaryDark
              : PawcationColors.textSecondary,
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
              color: highlight
                  ? PawcationColors.primaryDark
                  : PawcationColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
