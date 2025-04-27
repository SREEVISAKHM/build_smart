import 'dart:developer';

import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/pref.dart';
import 'package:build_smart/features/auth/view/login_view.dart';
import 'package:build_smart/features/dashboard/view/dashboard_view.dart';
import 'package:build_smart/features/splash/view_model/navigator_provider.dart';

final splashViewModelProvider = Provider((ref) {
  return SplashViewModel(ref);
});

class SplashViewModel {
  final Ref ref;
  SplashViewModel(this.ref);

  Future<void> checkLoginStatus() async {
    final navKey = ref.read(navigatorKeyProvider);

    final isLoggedIn = smartPref.getBool(SPKey.IS_LOGGED) ?? false;

    if (isLoggedIn) {
      log('to home', name: 'Nav');
      navKey.currentState?.pushReplacementNamed(DashboardView.route);
    } else {
      log('to login', name: 'Nav');

      navKey.currentState?.pushReplacementNamed(LoginView.route);
    }
  }
}
