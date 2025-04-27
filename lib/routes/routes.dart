import 'dart:developer';

import 'package:build_smart/features/auth/view/login_view.dart';
import 'package:build_smart/features/chat_history/view/chat_history_view.dart';
import 'package:build_smart/features/dashboard/view/dashboard_view.dart';
import 'package:build_smart/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext context)> appRoutes() => {
      SplashView.route: (_) => const SplashView(),
      LoginView.route: (_) => const LoginView(),
      DashboardView.route: (_) => const DashboardView(),
      ChatHistoryView.route: (_) => const ChatHistoryView(),
    };

Widget? _getScreen(RouteSettings settings) {
  switch (settings.name) {
    // case ClientHomePage.route:
    //   final params = settings.arguments as ClientHomePage;
    //   return ClientHomePage(userId: params.userId);

    default:
      return null;
  }
}

RouteFactory onAppGenerateRoute() => (settings) {
      log("####### ${settings.name}", name: 'Settings route');
      Widget? screen = _getScreen(settings);
      if (screen != null) {
        return MaterialPageRoute(
            builder: (context) {
              return screen;
            },
            settings: settings);
      }

      return null;
    };
