import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/theme/theme.dart';
import 'package:build_smart/core/utils/pref.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState(appTheme: AppTheme.light)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = smartPref;
    final storedTheme = prefs.getBool(SPKey.IS_Light_Mode) ?? false;
    state = ThemeState(
      appTheme: storedTheme ? AppTheme.light : AppTheme.dark,
    );
  }

  void setTheme(AppTheme theme) async {
    final prefs = smartPref;
    await prefs.setBool(
        SPKey.IS_Light_Mode, theme == AppTheme.light ? true : false);
    state = ThemeState(appTheme: theme);
  }
}
