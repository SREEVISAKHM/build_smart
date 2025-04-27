import 'package:build_smart/core/network/network_services.dart';
import 'package:build_smart/features/dashboard/model/manual_model.dart';
import 'package:build_smart/features/dashboard/view_model/manual_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManualViewModel extends StateNotifier<ManualState> {
  final NetworkServices network;
  ManualViewModel({required this.network}) : super(const ManualState.initial());

  Future<void> getManual() async {
    try {
      state = const ManualState.loading();
      ManualModel manualModel = await network.getManual();
      state = ManualState.success(manualModel);
    } catch (e) {
      state = ManualState.error(e.toString());
    }
  }
}

final manualViewModelProvider =
    StateNotifierProvider<ManualViewModel, ManualState>((ref) {
  final networkServices = ref.read(networkProvider);
  return ManualViewModel(network: networkServices);
});
