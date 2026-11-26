import 'package:flutter/material.dart';
import '../theme/pawcation_theme.dart';

class PawcationInputField extends StatefulWidget {
  final String label;
  final bool requiredMark;
  final String hintText;
  final TextEditingController? controller;
  final IconData prefixIcon;
  final bool isPassword;
  final bool showClearButton;
  final Widget? labelTrailing;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const PawcationInputField({
    super.key,
    required this.label,
    this.requiredMark = false,
    required this.hintText,
    this.controller,
    required this.prefixIcon,
    this.isPassword = false,
    this.showClearButton = false,
    this.labelTrailing,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<PawcationInputField> createState() => _PawcationInputFieldState();
}

class _PawcationInputFieldState extends State<PawcationInputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: widget.label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: PawcationColors.textPrimary,
                  ),
                  children: widget.requiredMark
                      ? const [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: PawcationColors.primary),
                          ),
                        ]
                      : const [],
                ),
              ),
            ),
            if (widget.labelTrailing != null) widget.labelTrailing!,
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: PawcationColors.inputFill,
            borderRadius: BorderRadius.circular(26),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscure,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: PawcationColors.textPrimary,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontSize: 13.5,
                color: PawcationColors.textMuted,
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                size: 19,
                color: PawcationColors.textSecondary,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 19,
                        color: PawcationColors.textSecondary,
                      ),
                    )
                  : (widget.showClearButton && widget.controller != null)
                      ? IconButton(
                          onPressed: () {
                            widget.controller!.clear();
                            widget.onChanged?.call('');
                          },
                          icon: Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE2E8F0),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 14,
                              color: PawcationColors.textSecondary,
                            ),
                          ),
                        )
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
