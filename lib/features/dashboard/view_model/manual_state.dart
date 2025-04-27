import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/features/dashboard/model/manual_model.dart';

@immutable
class ManualState {
  final ManualStatus status;
  final ManualModel? data;
  final String? error;

  const ManualState._({
    required this.status,
    this.data,
    this.error,
  });

  const ManualState.initial() : this._(status: ManualStatus.initial);
  const ManualState.loading() : this._(status: ManualStatus.loading);
  const ManualState.success(ManualModel data)
      : this._(status: ManualStatus.success, data: data);
  const ManualState.error(String error)
      : this._(status: ManualStatus.error, error: error);
}

enum ManualStatus { initial, loading, success, error }
