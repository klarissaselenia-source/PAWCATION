import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_button.dart';
import '../widgets/pawcation_card.dart';
import '../widgets/pawcation_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController =
      TextEditingController(text: 'sele.clarissa@pawparent.com');
  final _passwordController =
      TextEditingController(text: 'pawcationsecret2025');
  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 28),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 46),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circular Poodle avatar with soft blue halo + paw badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 108,
                        height: 108,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PawcationColors.primary.withValues(alpha: 0.14),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/dodo_avatar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: PawcationColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: PawcationColors.white,
                              width: 2.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.pets_rounded,
                            color: PawcationColors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const PawcationPillBadge(
                    label: 'Pawcation Sanctuary ID',
                    icon: Icons.verified_outlined,
                    backgroundColor: PawcationColors.primarySoft,
                    textColor: PawcationColors.primaryDark,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Selamat Datang! 🐾',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: PawcationColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Masuk untuk memantau, merawat, dan manjakan anabul kesayanganmu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.45,
                        color: PawcationColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Social Logins
                  PawcationWhitePillButton(
                    label: 'Masuk dengan Google',
                    leading: const _GoogleGIcon(),
                    onPressed: _loginToHome,
                  ),
                  const SizedBox(height: 12),
                  PawcationWhitePillButton(
                    label: 'Masuk dengan Apple',
                    leading: const Icon(
                      Icons.apple_rounded,
                      size: 22,
                      color: PawcationColors.textPrimary,
                    ),
                    onPressed: _loginToHome,
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Expanded(child: Divider(color: PawcationColors.divider)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'atau masuk dengan email',
                          style: TextStyle(
                            fontSize: 12,
                            color: PawcationColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: PawcationColors.divider)),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Email field with green Aktif badge
                  PawcationInputField(
                    label: 'Email / Nomor Handphone',
                    hintText: 'nama@email.com',
                    controller: _emailController,
                    prefixIcon: Icons.mail_outline_rounded,
                    showClearButton: true,
                    keyboardType: TextInputType.emailAddress,
                    labelTrailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 14,
                          color: PawcationColors.success,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Aktif',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: PawcationColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  PawcationInputField(
                    label: 'Kata Sandi',
                    hintText: 'Masukkan kata sandi',
                    controller: _passwordController,
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),
                  const SizedBox(height: 12),

                  // Remember me + Forgot password
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: PawcationColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          onChanged: (v) =>
                              setState(() => _rememberMe = v ?? true),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Ingat Saya',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: PawcationColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Tautan reset sandi dikirim ke email terdaftar.',
                              ),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Lupa Kata Sandi?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: PawcationColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Primary CTA
                  PawcationPrimaryButton(
                    label: 'Masuk Sekarang',
                    trailingIcon: Icons.arrow_forward_rounded,
                    onPressed: _loginToHome,
                  ),
                  const SizedBox(height: 12),

                  // Biometric button
                  PawcationSoftButton(
                    label: 'Atau gunakan Face ID / Biometrik',
                    leadingIcon: Icons.fingerprint_rounded,
                    onPressed: _loginToHome,
                  ),
                  const SizedBox(height: 18),

                  // Dodo boarding quick preview card -> Live Cam
                  PawcationCard(
                    padding: const EdgeInsets.all(14),
                    onTap: () => Navigator.pushNamed(context, '/live'),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/images/dodo_avatar.png',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: PawcationColors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Dodo',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: PawcationColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: PawcationPillBadge(
                                      label: 'Sedang Boarding',
                                      backgroundColor:
                                          PawcationColors.successSoft,
                                      textColor: PawcationColors.success,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Suite Room A-12 • Aktivitas jam 14:00 terjadwal',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.35,
                                  color: PawcationColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            color: PawcationColors.primarySoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.videocam_outlined,
                            size: 19,
                            color: PawcationColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register redirect
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun Pawcation? ',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: PawcationColors.textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/register'),
                        child: const Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: PawcationColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified_user_outlined,
                        size: 15,
                        color: PawcationColors.success,
                      ),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Data & privasi anabul terenkripsi 256-bit 🔒',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
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
          );
        },
      ),
    );
  }
}

class _GoogleGIcon extends StatelessWidget {
  const _GoogleGIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: const Text(
        'G',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w900,
          color: Color(0xFF4285F4),
        ),
      ),
    );
  }
}
