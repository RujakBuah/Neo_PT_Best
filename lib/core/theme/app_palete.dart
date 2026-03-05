import 'package:flutter/material.dart';

/// AppPalette — single source of truth for all raw colors.
/// Use these in AppTheme; avoid referencing them directly in widgets.
abstract final class AppPalette {
  // ── Brand / Primary ──────────────────────────────────────────────────────
  /// Teal used on primary action buttons (e.g. "Apply →")
  static const Color primary = Color(0xFF00BFA5);
  static const Color primaryLight = Color(0xFF5DF2D6);
  static const Color primaryDark = Color(0xFF008E76);

  // ── Status badges ─────────────────────────────────────────────────────────
  /// Yellow  — Pending
  static const Color pending = Color(0xFFFFC107);
  static const Color onPending = Color(0xFF1E1E1E);

  /// Green   — Accepted
  static const Color accepted = Color(0xFF4CAF50);
  static const Color onAccepted = Color(0xFFFFFFFF);

  /// Purple  — Completed
  static const Color completed = Color(0xFF7C3AED);
  static const Color onCompleted = Color(0xFFFFFFFF);

  // ── Surface / Background ──────────────────────────────────────────────────
  /// Page scaffold background (light grey)
  static const Color background = Color(0xFFF0F0F0);

  /// Card / list-item surface
  static const Color surface = Color(0xFFFFFFFF);

  /// Dark header card (Search Orders hero)
  static const Color surfaceDark = Color(0xFF1E1E1E);

  /// Bottom navigation bar background (matches surfaceDark in designs)
  static const Color navBar = Color(0xFF1E1E1E);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  /// Text / icons on dark surfaces
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textSecondaryOnDark = Color(0xFFB0B0B0);

  // ── Tab bar ───────────────────────────────────────────────────────────────
  /// Active tab pill background
  static const Color tabSelected = Color(0xFF1E1E1E);
  static const Color tabUnselected = Color(0xFFE0E0E0);
  static const Color tabSelectedLabel = Color(0xFFFFFFFF);
  static const Color tabUnselectedLabel = Color(0xFF757575);

  // ── Input / Search bar ────────────────────────────────────────────────────
  static const Color inputFill = Color(0xFF2C2C2C);
  static const Color inputFillLight = Color(0xFFEEEEEE);
  static const Color inputBorder = Color(0xFF3A3A3A);

  // ── Divider & Border ──────────────────────────────────────────────────────
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);

  // ── Misc ──────────────────────────────────────────────────────────────────
  static const Color iconDefault = Color(0xFF757575);
  static const Color iconOnDark = Color(0xFFFFFFFF);
  static const Color notificationBadge = Color(0xFFE53935);

  // ── Neutral greys (utility) ───────────────────────────────────────────────
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  static const Color deliveryBg = Color(0xFFE3F2FD);
  static const Color deliveryIcon = Color(0xFF0288D1);

  static const Color cleaningBg = Color(0xFFE0F2F1);
  static const Color cleaningIcon = Color(0xFF00897B);

  static const Color repairBg = Color(0xFFFFF3E0);
  static const Color repairIcon = Color(0xFFF57C00);
}
