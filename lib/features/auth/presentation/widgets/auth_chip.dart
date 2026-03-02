import 'package:flutter/material.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class AuthChip extends StatefulWidget {
  final ValueChanged<int> onTabChanged;
  final int initialIndex;
  const AuthChip({
    super.key,
    required this.onTabChanged,
    this.initialIndex = 0,
  });

  @override
  State<AuthChip> createState() => _AuthChipState();
}

class _AuthChipState extends State<AuthChip> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  Widget _buildTabChip(String label, int tabIndex) {
    return GestureDetector(
      onTap: () {
        setState(() => index = tabIndex);
        widget.onTabChanged(tabIndex);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: index == tabIndex ? AppPalette.navBar : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: index == tabIndex ? Colors.white : AppPalette.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppPalette.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabChip('Sign Up', 0)),
          Expanded(child: _buildTabChip('Login', 1)),
        ],
      ),
    );
  }
}
