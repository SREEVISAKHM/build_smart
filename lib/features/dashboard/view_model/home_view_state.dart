import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/features/dashboard/model/chat_model.dart';

@immutable
class HomeViewState {
  final HomeViewStatus status;
  final List<ChatModel?> data;
  final String? error;

  const HomeViewState._({
    required this.status,
    this.data = const [],
    this.error,
  });

  const HomeViewState.initial() : this._(status: HomeViewStatus.initial);
  const HomeViewState.loading(List<ChatModel?> data)
      : this._(status: HomeViewStatus.loading, data: data);
  const HomeViewState.success(List<ChatModel?> data)
      : this._(status: HomeViewStatus.success, data: data);
  const HomeViewState.error(String error)
      : this._(status: HomeViewStatus.error, error: error);
}

enum HomeViewStatus { initial, loading, success, error }
