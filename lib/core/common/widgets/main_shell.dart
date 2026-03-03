import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        color: AppPalette.navBar,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: CupertinoIcons.house_fill,
              isActive: location == '/',
              onTap: () => context.go('/'),
            ),
            _NavItem(
              icon: CupertinoIcons.briefcase_fill,
              isActive: location == '/orders',
              onTap: () => context.go('/orders'),
            ),
            _NavItem(
              icon: CupertinoIcons.plus_circle_fill,
              isActive: location == '/add-job',
              onTap: () => context.go('/add-job'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppPalette.primary : AppPalette.iconOnDark,
            size: 24,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppPalette.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
