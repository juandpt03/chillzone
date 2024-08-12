import "package:flutter/material.dart";

class AppTheme {
  final Color colorSchemeSeed;
  final bool isDark;

  AppTheme({
    this.colorSchemeSeed = const Color(0XFF7354EF),
    this.isDark = true,
  });

  ThemeData getAppTheme() => isDark
      ? ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.transparent,
          primaryColorDark: colorSchemeSeed,
          colorScheme: ColorScheme.fromSeed(
            primary: colorSchemeSeed,
            seedColor: colorSchemeSeed,
            brightness: Brightness.dark,
          ),
        )
      : ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          cardColor: Colors.white,
          canvasColor: Colors.white,
          cardTheme: const CardTheme(elevation: 0, color: Colors.white),
          colorScheme: ColorScheme.fromSeed(
            primary: colorSchemeSeed,
            seedColor: colorSchemeSeed,
            surface: Colors.white,
          ),
        );

  AppTheme copyWith({
    Color? colorSchemeSeed,
    bool? isDark,
  }) =>
      AppTheme(
        colorSchemeSeed: colorSchemeSeed ?? this.colorSchemeSeed,
        isDark: isDark ?? this.isDark,
      );
}
