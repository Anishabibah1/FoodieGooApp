import 'package:flutter/material.dart';

class FoodieColors {
  FoodieColors._();

  static const Color primary        = Color(0xFFEE4D2D);
  static const Color primaryLight   = Color(0xFFF26B4E);
  static const Color primaryDark    = Color(0xFFD43B1E);
  static const Color primarySurface = Color(0xFFFFF0ED); // bg ringan untuk badge, chip

  static const Color secondary      = Color(0xFFFFB020);
  static const Color secondarySurface = Color(0xFFFFF8E7);

  static const Color background     = Color(0xFFF9F9F9);
  static const Color surface        = Color(0xFFFFFFFF);
  static const Color divider        = Color(0xFFEEEEEE);

  static const Color textPrimary    = Color(0xFF1A1A1A);
  static const Color textSecondary  = Color(0xFF6B6B6B);
  static const Color textHint       = Color(0xFFAAAAAA);

  static const Color success        = Color(0xFF27AE60);
  static const Color error          = Color(0xFFE74C3C);
  static const Color rating         = Color(0xFFFFB020); 
}

class FoodieTextStyles {
  FoodieTextStyles._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: FoodieColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: FoodieColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: FoodieColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: FoodieColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: FoodieColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: FoodieColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: FoodieColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // Tombol
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.0,
  );
}

ThemeData foodieTheme() {
  return ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary:          FoodieColors.primary,
      onPrimary:        Colors.white,
      primaryContainer: FoodieColors.primarySurface,
      onPrimaryContainer: FoodieColors.primaryDark,
      secondary:        FoodieColors.secondary,
      onSecondary:      Colors.white,
      secondaryContainer: FoodieColors.secondarySurface,
      onSecondaryContainer: Color(0xFF7A4800),
      surface:          FoodieColors.surface,
      onSurface:        FoodieColors.textPrimary,
      surfaceContainerHighest: FoodieColors.background,
      onSurfaceVariant: FoodieColors.textSecondary,
      error:            FoodieColors.error,
      onError:          Colors.white,
      outline:          FoodieColors.divider,
      outlineVariant:   FoodieColors.divider,
      shadow:           Colors.black12,
      scrim:            Colors.black54,
      inverseSurface:   FoodieColors.textPrimary,
      onInverseSurface: Colors.white,
      inversePrimary:   FoodieColors.primaryLight,
    ),

    scaffoldBackgroundColor: FoodieColors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: FoodieColors.surface,
      foregroundColor: FoodieColors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Colors.black12,
      centerTitle: false,
      titleTextStyle: FoodieTextStyles.headlineMedium,
      iconTheme: IconThemeData(color: FoodieColors.textPrimary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: FoodieColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: FoodieColors.divider,
        disabledForegroundColor: FoodieColors.textHint,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: FoodieTextStyles.button,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: FoodieColors.primary,
        side: const BorderSide(color: FoodieColors.primary, width: 1.5),
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: FoodieTextStyles.button,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: FoodieColors.primary,
        textStyle: FoodieTextStyles.button.copyWith(fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: FoodieColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: FoodieColors.divider, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: FoodieColors.divider, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: FoodieColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: FoodieColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: FoodieColors.error, width: 1.5),
      ),
      hintStyle: FoodieTextStyles.bodyMedium.copyWith(
        color: FoodieColors.textHint,
      ),
      labelStyle: FoodieTextStyles.bodyMedium,
      floatingLabelStyle: const TextStyle(
        color: FoodieColors.primary,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: FoodieTextStyles.labelSmall.copyWith(
        color: FoodieColors.error,
      ),
      prefixIconColor: FoodieColors.textHint,
      suffixIconColor: FoodieColors.textHint,
    ),

    cardTheme: CardThemeData(
        color: FoodieColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: FoodieColors.divider, width: 0.8),
        ),
        margin: EdgeInsets.zero,
      ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: FoodieColors.surface,
      selectedItemColor: FoodieColors.primary,
      unselectedItemColor: FoodieColors.textHint,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: FoodieColors.surface,
      selectedColor: FoodieColors.primarySurface,
      disabledColor: FoodieColors.divider,
      labelStyle: FoodieTextStyles.labelSmall.copyWith(
        color: FoodieColors.textSecondary,
      ),
      secondaryLabelStyle: FoodieTextStyles.labelSmall.copyWith(
        color: FoodieColors.primary,
      ),
      side: const BorderSide(color: FoodieColors.divider, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      showCheckmark: false,
    ),

    dividerTheme: const DividerThemeData(
      color: FoodieColors.divider,
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: FoodieColors.textPrimary,
      contentTextStyle: FoodieTextStyles.bodyMedium.copyWith(
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),

    textTheme: const TextTheme(
      displayLarge:    FoodieTextStyles.displayLarge,
      headlineMedium:  FoodieTextStyles.headlineMedium,
      titleMedium:     FoodieTextStyles.titleMedium,
      titleSmall:      FoodieTextStyles.titleSmall,
      bodyLarge:       FoodieTextStyles.bodyLarge,
      bodyMedium:      FoodieTextStyles.bodyMedium,
      labelSmall:      FoodieTextStyles.labelSmall,
    ),
  );
}