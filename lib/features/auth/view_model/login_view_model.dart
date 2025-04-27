import 'package:build_smart/core/network/network_services.dart';
import 'package:build_smart/core/utils/pref.dart';
import 'package:build_smart/features/auth/model/login_model.dart';
import 'package:build_smart/features/auth/view_model/login_state.dart';
import 'package:build_smart/features/dashboard/view/dashboard_view.dart';
import 'package:build_smart/features/splash/view_model/navigator_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final NetworkServices networkServices;
  final Ref ref;
  LoginViewModel(this.networkServices, this.ref)
      : super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    final navKey = ref.read(navigatorKeyProvider);
    try {
      state = const LoginState.loading();
      await Future.delayed(const Duration(seconds: 1));
      smartPref.setBool(SPKey.IS_LOGGED, true);

      state = LoginState.success(LoginModel());
      navKey.currentState?.pushReplacementNamed(DashboardView.route);
    } catch (e) {
      state = LoginState.error(e.toString());
    }
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final network = ref.read(networkProvider);
  return LoginViewModel(network, ref);
});
