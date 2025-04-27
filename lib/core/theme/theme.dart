import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/theme/colors.dart';

class ThemePicker {
  static final lightTheme = ThemeData(
    fontFamily: 'noah-regular',
    scaffoldBackgroundColor: colorBg,
    brightness: Brightness.light,
    textTheme: const TextTheme().copyWith(
      titleMedium: TextStyle(
          color: colorBlue, fontSize: 18.sp, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
        color: colorBlack,
        fontSize: 15.sp,
      ),
      bodySmall: TextStyle(
        color: colorBlue,
        fontSize: 12.sp,
      ),
    ),
    primaryColor: colorBlue,
    secondaryHeaderColor: colorBlack,
    disabledColor: colorGrey,
    cardColor: colorOrange,
    canvasColor: colorLightPink,
    indicatorColor: colorLightBlue,
    highlightColor: colorWhite,
    hoverColor: colorDeepBlue,
    shadowColor: colorWhite,
  );

  static final darkTheme = ThemeData(
    fontFamily: 'noah-regular',
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    textTheme: const TextTheme().copyWith(
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: Colors.white70,
        fontSize: 15.sp,
      ),
      bodySmall: TextStyle(
        color: Colors.white60,
        fontSize: 12.sp,
      ),
    ),
    primaryColor: Colors.amber,
    secondaryHeaderColor: Colors.white70,
    disabledColor: Colors.grey.shade600,
    cardColor: colorOrange,
    canvasColor: colorLightPink.withOpacity(0.1),
    indicatorColor: colorLightBlue,
    highlightColor: Colors.white12,
    hoverColor: colorDeepBlue.withOpacity(0.7),
    shadowColor: colorBlack,
  );
}

enum AppTheme { light, dark }

class ThemeState {
  final AppTheme appTheme;

  ThemeState({required this.appTheme});

  ThemeData get themeData {
    switch (appTheme) {
      case AppTheme.dark:
        return ThemePicker.darkTheme;
      case AppTheme.light:
        return ThemePicker.lightTheme;
    }
  }
}
