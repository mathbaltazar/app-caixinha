import 'package:flutter/material.dart';

class AppColors {

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF236C19),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDAECC6),
    onPrimaryContainer: Color(0xFF002200),
    secondary: Color(0xFF54634D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD7E8CD),
    onSecondaryContainer: Color(0xFF121F0E),
    tertiary: Color(0xFF6A5F00),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFF6E568),
    onTertiaryContainer: Color(0xFF201C00),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFDF6),
    onBackground: Color(0xFF1A1C18),
    surface: Color(0xFFFCFDF6),
    onSurface: Color(0xFF1A1C18),
    surfaceVariant: Color(0xFFDFE4D7),
    onSurfaceVariant: Color(0xFF43483F),
    outline: Color(0xFF73796E),
    onInverseSurface: Color(0xFFF1F1EB),
    inverseSurface: Color(0xFF2F312D),
    inversePrimary: Color(0xFF8CD978),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF236C19),
    outlineVariant: Color(0xFFC3C8BC),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF3CE42A),
    onPrimary: Color(0xFF023A00),
    primaryContainer: Color(0xFF035300),
    onPrimaryContainer: Color(0xFF77FF5F),
    secondary: Color(0xFFBBCBB1),
    onSecondary: Color(0xFF263422),
    secondaryContainer: Color(0xFF3C4B37),
    onSecondaryContainer: Color(0xFFD7E8CD),
    tertiary: Color(0xFFE1C700),
    onTertiary: Color(0xFF383000),
    tertiaryContainer: Color(0xFF514700),
    onTertiaryContainer: Color(0xFFFFE32F),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C18),
    onBackground: Color(0xFFE2E3DC),
    surface: Color(0xFF1A1C18),
    onSurface: Color(0xFFE2E3DC),
    surfaceVariant: Color(0xFF43483F),
    onSurfaceVariant: Color(0xFFC3C8BC),
    outline: Color(0xFF8D9387),
    onInverseSurface: Color(0xFF1A1C18),
    inverseSurface: Color(0xFFE2E3DC),
    inversePrimary: Color(0xFF056E00),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF3CE42A),
    outlineVariant: Color(0xFF43483F),
    scrim: Color(0xFF000000),
  );


  static Color get colorSurface =>
      isDarkMode() ? darkColorScheme.surface : lightColorScheme.surface;

  static Color get outlineColor =>
      isDarkMode() ? darkColorScheme.outline : lightColorScheme.outline;

  static Color get colorPrimary =>
      isDarkMode() ? darkColorScheme.primary : lightColorScheme.primary;

  static Color get primaryContainer =>
      isDarkMode() ? darkColorScheme.primaryContainer : lightColorScheme.primaryContainer;

  static Color get colorTertiary =>
      isDarkMode() ? darkColorScheme.tertiary : lightColorScheme.tertiary;

  static Color get errorColor =>
      isDarkMode() ? darkColorScheme.error : lightColorScheme.error;

  static isDarkMode() {
    var brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }
}
