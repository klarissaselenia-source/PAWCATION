import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';
import '../widgets/pawcation_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agreeTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submitRegister(PawcationAppState state) {
    if (_nameController.text.trim().isNotEmpty) {
      state.ownerName = _nameController.text.trim();
    }
    if (_emailController.text.trim().isNotEmpty) {
      state.ownerEmail = _emailController.text.trim();
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);
    final petOptions = [
      (key: 'Anjing', label: '🐶 Anjing'),
      (key: 'Kucing', label: '🐱 Kucing'),
      (key: 'Keduanya', label: '🐰 Keduanya'),
    ];

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
        child: Column(
          children: [
            // Promo Selamat Datang banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFEEF3FA),
                    Color(0xFFE0F0FC),
                  ],
                ),
                border: Border.all(color: PawcationColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PawcationPillBadge(
                    label: 'PROMO SELAMAT DATANG',
                    icon: Icons.stars_rounded,
                    backgroundColor: PawcationColors.white,
                    textColor: PawcationColors.primaryDark,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mulai Bersama\nPAWCATION 🐶🐱',
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.15,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.45,
                        color: PawcationColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: 'Daftar akun gratis dan nikmati diskon ',
                        ),
                        TextSpan(
                          text: '20%',
                          style: TextStyle(
                            color: PawcationColors.primaryDark,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' untuk perawatan & penitipan pertama anabulmu!',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/register_pets_cluster.png',
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          '12.8k+ anabul terdaftar',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: PawcationColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Progress stepper card
            PawcationCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: PawcationColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: PawcationColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Data Pemilik & Akun',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: PawcationColors.textPrimary,
                          ),
                        ),
                      ),
                      const Text(
                        '50% Selesai',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: PawcationColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: const LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 6,
                      backgroundColor: PawcationColors.primarySoft,
                      valueColor: AlwaysStoppedAnimation(PawcationColors.primary),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Langkah 1 dari 2',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: PawcationColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => _submitRegister(state),
                        child: const Text(
                          'Berikutnya: Profil Anabul →',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: PawcationColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Form card
            PawcationCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PawcationInputField(
                    label: 'Nama Lengkap Pemilik',
                    requiredMark: true,
                    hintText: 'contoh: Sarah Kartika',
                    controller: _nameController,
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: 16),
                  PawcationInputField(
                    label: 'Alamat Email Aktif',
                    requiredMark: true,
                    hintText: 'sarah@example.com',
                    controller: _emailController,
                    prefixIcon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Phone row with +62 badge
                  RichText(
                    text: const TextSpan(
                      text: 'Nomor WhatsApp / HP',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: PawcationColors.textPrimary,
                      ),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: PawcationColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: PawcationColors.inputFill,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('🇮🇩', style: TextStyle(fontSize: 16)),
                            SizedBox(width: 6),
                            Text(
                              '+62',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: PawcationColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: PawcationColors.inputFill,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                size: 18,
                                color: PawcationColors.textSecondary,
                              ),
                              hintText: '812-3456-7890',
                              hintStyle: TextStyle(
                                fontSize: 13.5,
                                color: PawcationColors.textMuted,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        size: 14,
                        color: PawcationColors.success,
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Untuk notifikasi darurat & rekam medis anabul',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: PawcationColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  PawcationInputField(
                    label: 'Kata Sandi',
                    requiredMark: true,
                    hintText: 'Minimal 8 karakter & 1 angka',
                    controller: _passController,
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),
                  const SizedBox(height: 16),

                  PawcationInputField(
                    label: 'Konfirmasi Kata Sandi',
                    requiredMark: true,
                    hintText: 'Ketik ulang kata sandi',
                    controller: _confirmController,
                    prefixIcon: Icons.check_circle_outline_rounded,
                    isPassword: true,
                  ),
                  const SizedBox(height: 18),

                  // Peliharaan Utama Kamu
                  const Row(
                    children: [
                      Icon(
                        Icons.pets_rounded,
                        size: 16,
                        color: PawcationColors.primary,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Peliharaan Utama Kamu:',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: petOptions.map((opt) {
                      final selected = state.selectedPetType == opt.key;
                      return ChoiceChip(
                        label: Text(opt.label),
                        selected: selected,
                        onSelected: (_) => state.setPetType(opt.key),
                        selectedColor: PawcationColors.primarySoft,
                        backgroundColor: PawcationColors.inputFill,
                        side: BorderSide(
                          color: selected
                              ? PawcationColors.primary
                              : Colors.transparent,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? PawcationColors.primaryDark
                              : PawcationColors.textSecondary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bisa ditambahkan & disesuaikan kembali nanti di profil.',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: PawcationColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Terms checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreeTerms,
                          activeColor: PawcationColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          onChanged: (v) =>
                              setState(() => _agreeTerms = v ?? false),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.4,
                              color: PawcationColors.textSecondary,
                            ),
                            children: [
                              TextSpan(text: 'Saya menyetujui '),
                              TextSpan(
                                text: 'Syarat & Ketentuan',
                                style: TextStyle(
                                  color: PawcationColors.primaryDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: ' serta '),
                              TextSpan(
                                text: 'Kebijakan Privasi',
                                style: TextStyle(
                                  color: PawcationColors.primaryDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: ' Pawcation Care.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  PawcationPrimaryButton(
                    label: 'Lanjut & Buat Profil Anabul',
                    trailingIcon: Icons.pets_rounded,
                    onPressed: () => _submitRegister(state),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: const [
                Expanded(child: Divider(color: PawcationColors.divider)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'ATAU DAFTAR CEPAT DENGAN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: PawcationColors.textSecondary,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: PawcationColors.divider)),
              ],
            ),
            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: PawcationWhitePillButton(
                    label: 'Google',
                    leading: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                    onPressed: () => _submitRegister(state),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PawcationWhitePillButton(
                    label: 'Apple',
                    leading: const Icon(Icons.apple_rounded, size: 22),
                    onPressed: () => _submitRegister(state),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const PawcationPillBadge(
              label: 'Bebas biaya langganan • Batal kapan saja',
              icon: Icons.check_circle_rounded,
              backgroundColor: PawcationColors.white,
              textColor: PawcationColors.textSecondary,
            ),
            const SizedBox(height: 14),

            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Sudah punya akun? ',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: PawcationColors.textSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Masuk di sini',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: PawcationColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
