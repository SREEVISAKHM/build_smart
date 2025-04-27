// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/features/dashboard/model/chat_model.dart';

@immutable
class HistoryState {
  final HistoryStatus historyStatus;

  final List<List<ChatModel>> historyList;
  final String? error;
  const HistoryState._(
      {required this.historyStatus, this.historyList = const [], this.error});

  const HistoryState.initial() : this._(historyStatus: HistoryStatus.initial);

  const HistoryState.loading() : this._(historyStatus: HistoryStatus.loading);

  const HistoryState.success(List<List<ChatModel>> historyList)
      : this._(historyStatus: HistoryStatus.success, historyList: historyList);

  const HistoryState.error(String? error)
      : this._(historyStatus: HistoryStatus.error, error: error);
}

enum HistoryStatus { initial, loading, success, error }
