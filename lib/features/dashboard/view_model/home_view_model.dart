import 'dart:developer';

import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/db/chat_db.dart';
import 'package:build_smart/core/network/api_exceptions.dart';
import 'package:build_smart/core/network/network_services.dart';
import 'package:build_smart/features/chat_history/view_model/history_view_model.dart';
import 'package:build_smart/features/dashboard/model/chat_model.dart';
import 'package:build_smart/features/dashboard/view_model/home_view_state.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends StateNotifier<HomeViewState> {
  final NetworkServices networkServices;
  final ChatDatabase chatDatabase;
  HistoryViewModel historyViewModel;
  HomeViewModel(
      {required this.networkServices,
      required this.chatDatabase,
      required this.historyViewModel})
      : super(const HomeViewState.initial()) {
    _listenToWebSocket();
  }

  List<ChatModel?> chatSessionMessages = [];

  final ScrollController scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 40), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _listenToWebSocket() {
    networkServices.messageStream.listen((response) {
      try {
        DateTime time = DateTime.now();
        String formattedTime = DateFormat.jm().format(time);

        ChatModel updatedData = ChatModel(
            text: response!, id: '', isUser: false, timestamp: formattedTime);

        chatSessionMessages.last = updatedData;
        state = HomeViewState.success(chatSessionMessages);
        _scrollToBottom();
      } catch (e) {
        if (e is ApiException) {
          state = HomeViewState.error(e.message);
        }
      }
    });
  }

  void sentMessage(String message) {
    state = HomeViewState.loading(chatSessionMessages);
    DateTime time = DateTime.now();
    String formattedTime = DateFormat.jm().format(time);

    ChatModel userMessageData = ChatModel(
        text: message, id: '', isUser: true, timestamp: formattedTime);
    chatSessionMessages.add(userMessageData);

    ChatModel aiMessageData =
        ChatModel(text: '', id: '', isUser: false, timestamp: formattedTime);

    chatSessionMessages.add(aiMessageData);

    networkServices.sendUserMessage(message);
  }

  void newChat() {
    chatSessionMessages.clear();
    state = const HomeViewState.initial();
  }

  Future<void> saveChatSession(List<ChatModel?> chatSessionMessages) async {
    if (chatSessionMessages.isNotEmpty) {
      log(chatSessionMessages.length.toString(), name: 'chatmessage leghth');
      await ChatDatabase.instance.saveSession(chatSessionMessages);
      historyViewModel.loadChatHistory();
    }
    newChat();
  }

  @override
  void dispose() {
    networkServices.dispose();

    super.dispose();
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeViewState>((ref) {
  final network = ref.read(networkProvider);
  final historyViewModel = ref.read(chatHistoryProvider.notifier);
  return HomeViewModel(
      networkServices: network,
      chatDatabase: ChatDatabase.instance,
      historyViewModel: historyViewModel);
});
