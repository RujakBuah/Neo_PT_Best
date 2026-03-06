import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_palete.dart';

/// AppTheme — builds the [ThemeData] consumed by [MaterialApp].
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light,
/// );
/// ```
abstract final class AppTheme {
  // ── Text styles ───────────────────────────────────────────────────────────
  static const TextTheme _textTheme = TextTheme(
    // Hero / page titles  (e.g. "Search Orders")
    displayLarge: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w700,
      color: AppPalette.textOnDark,
      letterSpacing: -0.5,
      shadows: [
        Shadow(blurRadius: 2.5, color: Colors.white, offset: Offset(0, 0)),
      ],
    ),
    // Section headings
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppPalette.textPrimary,
      letterSpacing: -0.3,
    ),
    // Card title / order number
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w600,
      color: AppPalette.textPrimary,
    ),
    // Price label
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppPalette.textPrimary,
    ),
    // Secondary card info (Posted by, Expected on …)
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppPalette.textSecondary,
    ),
    bodySmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppPalette.textSecondary,
    ),
    // Tab labels, button labels
    labelLarge: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppPalette.textSecondary,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppPalette.textPrimary,
      letterSpacing: 0.3,
    ),
  );

  // ── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Poppins', // swap to any font you add to pubspec
    );

    return base.copyWith(
      // ── Color scheme ──────────────────────────────────────────────────────
      colorScheme: const ColorScheme.light(
        primary: AppPalette.primary,
        onPrimary: Colors.white,
        primaryContainer: AppPalette.primaryLight,
        onPrimaryContainer: AppPalette.primaryDark,
        secondary: AppPalette.completed,
        onSecondary: Colors.white,
        surface: AppPalette.surface,
        onSurface: AppPalette.textPrimary,
        surfaceContainerHighest: AppPalette.background,
        onSurfaceVariant: AppPalette.textSecondary,
        outline: AppPalette.border,
        error: Color(0xFFE53935),
        onError: Colors.white,
      ),

      // ── Scaffold ──────────────────────────────────────────────────────────
      scaffoldBackgroundColor: AppPalette.background,

      // ── App Bar ───────────────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.surface,
        foregroundColor: AppPalette.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppPalette.textPrimary,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),

      // ── Card ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppPalette.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppPalette.border, width: 0.8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),

      // ── Input / Search bar ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppPalette.surface,
        hintStyle: const TextStyle(
          color: AppPalette.textHint,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppPalette.border, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppPalette.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppPalette.primary, width: 1.5),
        ),
      ),

      // ── Elevated button (primary CTA — "Apply →") ─────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      // ── Outlined / secondary button ───────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppPalette.primary,
          side: const BorderSide(color: AppPalette.primary),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // ── Tab bar ───────────────────────────────────────────────────────────
      tabBarTheme: const TabBarThemeData(
        indicator: BoxDecoration(), // use custom pill indicator in widget
        labelColor: AppPalette.tabSelectedLabel,
        unselectedLabelColor: AppPalette.tabUnselectedLabel,
        labelStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ── Bottom Navigation Bar ─────────────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppPalette.navBar,
        selectedItemColor: AppPalette.primary,
        unselectedItemColor: AppPalette.iconOnDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),

      // ── Navigation bar (Material 3) ───────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppPalette.navBar,
        indicatorColor: AppPalette.primary.withOpacity(0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppPalette.primary, size: 24);
          }
          return const IconThemeData(color: AppPalette.iconOnDark, size: 24);
        }),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),

      // ── Chip (status badges — Pending / Accepted / Completed) ─────────────
      chipTheme: ChipThemeData(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide.none,
      ),

      // ── Divider ───────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppPalette.divider,
        thickness: 0.8,
        space: 0,
      ),

      // ── Icon ──────────────────────────────────────────────────────────────
      iconTheme: const IconThemeData(color: AppPalette.iconDefault, size: 22),

      // ── Text ──────────────────────────────────────────────────────────────
      textTheme: _textTheme,
    );
  }
}

// ── Convenience extensions ────────────────────────────────────────────────────
/// Quick access to status-badge colors without a BuildContext.
abstract final class StatusBadge {
  static const pending = (
    background: AppPalette.pending,
    foreground: AppPalette.onPending,
    label: 'Pending',
  );

  static const accepted = (
    background: AppPalette.accepted,
    foreground: AppPalette.onAccepted,
    label: 'Accepted',
  );

  static const completed = (
    background: AppPalette.completed,
    foreground: AppPalette.onCompleted,
    label: 'Completed',
  );
}
