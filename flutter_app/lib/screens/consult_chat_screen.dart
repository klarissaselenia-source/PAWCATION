import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../theme/pawcation_theme.dart';
import '../widgets/pawcation_app_bar.dart';
import '../widgets/pawcation_badge.dart';
import '../widgets/pawcation_card.dart';

class ConsultChatScreen extends StatefulWidget {
  const ConsultChatScreen({super.key});

  @override
  State<ConsultChatScreen> createState() => _ConsultChatScreenState();
}

class _ConsultChatScreenState extends State<ConsultChatScreen> {
  final _msgController = TextEditingController();

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppStateScope.of(context);

    return Scaffold(
      appBar: const PawcationAppBar(showBack: true),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: PawcationColors.white,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 21,
                  backgroundColor: PawcationColors.primarySoft,
                  child: Icon(
                    Icons.medical_services_rounded,
                    color: PawcationColors.primaryDark,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'drh. Amanda Saraswati, M.Si',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Online • Konsultasi Aktif',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: PawcationColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Menghubungkan panggilan suara...'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.call_outlined,
                    color: PawcationColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.messages.length,
              itemBuilder: (_, idx) {
                final msg = state.messages[idx];
                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.78,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? PawcationColors.primary
                          : PawcationColors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: msg.isUser
                          ? null
                          : Border.all(color: PawcationColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.text,
                          style: TextStyle(
                            fontSize: 13.5,
                            height: 1.4,
                            color: msg.isUser
                                ? PawcationColors.white
                                : PawcationColors.textPrimary,
                          ),
                        ),
                        if (msg.recommendedProduct != null) ...[
                          const SizedBox(height: 10),
                          PawcationCard(
                            color: PawcationColors.primaryTint,
                            padding: const EdgeInsets.all(12),
                            borderRadius: 14,
                            onTap: () =>
                                Navigator.pushNamed(context, '/marketplace'),
                            child: Row(
                              children: [
                                const Text('🦴', style: TextStyle(fontSize: 22)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        msg.recommendedProduct!,
                                        style: const TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const Text(
                                        'Rp 115.000 • Lihat Produk →',
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
                        ],
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: PawcationPillBadge(
                            label: msg.time,
                            backgroundColor: msg.isUser
                                ? const Color(0x28FFFFFF)
                                : PawcationColors.inputFill,
                            textColor: msg.isUser
                                ? PawcationColors.white
                                : PawcationColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              color: PawcationColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan untuk dokter...',
                        filled: true,
                        fillColor: PawcationColors.inputFill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: PawcationColors.primary,
                    child: IconButton(
                      onPressed: () {
                        state.sendChatMessage(_msgController.text);
                        _msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: PawcationColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
