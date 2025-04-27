import 'dart:developer';

import 'package:build_smart/core/db/chat_db.dart';
import 'package:build_smart/features/chat_history/view_model/history_state.dart';
import 'package:build_smart/features/dashboard/model/chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryViewModel extends StateNotifier<HistoryState> {
  final ChatDatabase chatDatabase;

  HistoryViewModel({required this.chatDatabase})
      : super(const HistoryState.initial());

  List<List<ChatModel>> pastSessions = [];

  Future<void> loadChatHistory() async {
    try {
      state = const HistoryState.loading();

      pastSessions = await ChatDatabase.instance.fetchSessions();

      log(pastSessions.length.toString(), name: 'past');
      state = HistoryState.success(pastSessions);
    } catch (e) {
      state = HistoryState.error(e.toString());
    }
  }

  @override
  void dispose() {
    disposeDatabase();
    super.dispose();
  }

  void disposeDatabase() {
    ChatDatabase.instance.close();
  }
}

final chatHistoryProvider =
    StateNotifierProvider<HistoryViewModel, HistoryState>((ref) {
  return HistoryViewModel(chatDatabase: ChatDatabase.instance);
});
