import 'dart:developer';

import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/extensions.dart';
import 'package:build_smart/features/chat_history/view/session_view.dart';
import 'package:build_smart/features/chat_history/view_model/history_state.dart';
import 'package:build_smart/features/chat_history/view_model/history_view_model.dart';

class ChatHistoryView extends ConsumerStatefulWidget {
  static const String route = '/chat_history';
  const ChatHistoryView({super.key});

  @override
  ConsumerState<ChatHistoryView> createState() => _ChatHistoryViewState();
}

class _ChatHistoryViewState extends ConsumerState<ChatHistoryView> {
  @override
  Widget build(BuildContext context) {
    // final HomeViewModel = ref.watch(homeViewModelProvider.notifier);
    final historyViewstate = ref.watch(chatHistoryProvider);
    final historyViewModel = ref.watch(chatHistoryProvider.notifier);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Chat History'),
        backgroundColor: theme.highlightColor,
        surfaceTintColor: theme.highlightColor,
      ),
      body: historyViewstate.historyStatus == HistoryStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : historyViewstate.historyList.isEmpty
              ? const Center(child: Text('No Chat History Found'))
              : ListView.builder(
                  itemCount: historyViewstate.historyList.length,
                  itemBuilder: (context, sessionIndex) {
                    return GestureDetector(
                      onTap: () {
                        historyViewModel.loadChatHistory();
                        log(historyViewstate.historyList[sessionIndex]
                            .toString());

                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SessionView(
                              sessionName: 'Session ${sessionIndex + 1}',
                              chatModelList:
                                  historyViewstate.historyList[sessionIndex]);
                        }));
                      },
                      child: Card(
                        color: theme.indicatorColor,
                        child: ListTile(
                          title: Text(
                            'Session ${sessionIndex + 1}',
                            style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ).giveHPadding(padding: 15.h).giveTPadding(padding: 10.h),
    );
  }
}
