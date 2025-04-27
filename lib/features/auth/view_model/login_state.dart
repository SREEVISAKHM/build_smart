import 'package:build_smart/features/auth/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class LoginState {
  final LoginStatus status;
  final LoginModel? data;
  final String? error;

  const LoginState._({
    required this.status,
    this.data,
    this.error,
  });

  const LoginState.initial() : this._(status: LoginStatus.initial);
  const LoginState.loading() : this._(status: LoginStatus.loading);
  const LoginState.success(LoginModel data)
      : this._(status: LoginStatus.success, data: data);
  const LoginState.error(String error)
      : this._(status: LoginStatus.error, error: error);
}

enum LoginStatus { initial, loading, success, error }

class ObscureState extends StateNotifier<bool> {
  ObscureState() : super(true);

  void toggle() {
    state = !state;
  }
}

final obscureProvider = StateNotifierProvider<ObscureState, bool>((ref) {
  return ObscureState();
});
