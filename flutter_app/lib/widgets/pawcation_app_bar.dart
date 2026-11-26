import 'package:flutter/material.dart';
import '../theme/pawcation_theme.dart';

class PawcationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;

  const PawcationAppBar({
    super.key,
    this.showBack = true,
    this.onBack,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PawcationColors.white,
        border: Border(
          bottom: BorderSide(color: PawcationColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 58,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: showBack
                      ? IconButton(
                          onPressed: onBack ?? () => Navigator.maybePop(context),
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            size: 28,
                            color: PawcationColors.textPrimary,
                          ),
                          padding: EdgeInsets.zero,
                          tooltip: 'Kembali',
                        )
                      : const SizedBox.shrink(),
                ),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.pets_rounded,
                        color: PawcationColors.primary,
                        size: 20,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Pawcation',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: PawcationColors.textPrimary,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 44,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: trailing ?? const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PawcationNotificationAction extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasUnread;

  const PawcationNotificationAction({
    super.key,
    required this.onTap,
    this.hasUnread = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.notifications_none_rounded,
              size: 24,
              color: PawcationColors.textPrimary,
            ),
            if (hasUnread)
              Positioned(
                right: 1,
                top: 1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: PawcationColors.danger,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PawcationProfileCircleAction extends StatelessWidget {
  final VoidCallback onTap;

  const PawcationProfileCircleAction({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          color: PawcationColors.navyAccent,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.person_outline_rounded,
          size: 18,
          color: PawcationColors.white,
        ),
      ),
    );
  }
}
