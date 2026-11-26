import 'package:flutter/material.dart';
import '../theme/pawcation_theme.dart';

class PawcationCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double borderRadius;
  final Border? border;
  final VoidCallback? onTap;

  const PawcationCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = PawcationColors.white,
    this.borderRadius = 22,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border ?? Border.all(color: PawcationColors.border, width: 1),
      boxShadow: PawcationTheme.cardShadow,
    );

    if (onTap == null) {
      return Container(
        padding: padding,
        decoration: decoration,
        child: child,
      );
    }

    return Container(
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
