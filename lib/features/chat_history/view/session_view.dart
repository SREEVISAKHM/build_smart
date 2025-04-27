// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/extensions.dart';
import 'package:build_smart/core/utils/loader.dart';

import 'package:build_smart/features/dashboard/model/chat_model.dart';

class SessionView extends StatefulWidget {
  final String sessionName;
  final List<ChatModel?> chatModelList;
  const SessionView({
    super.key,
    required this.sessionName,
    required this.chatModelList,
  });

  @override
  State<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.sessionName),
        backgroundColor: theme.highlightColor,
        surfaceTintColor: theme.highlightColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: widget.chatModelList.length,
                itemBuilder: (_, index) {
                  log(widget.chatModelList[index]!.isUser.toString());
                  if (widget.chatModelList[index]!.isUser) {
                    return userBubble(widget.chatModelList[index]!);
                  }
                  return aiBubble(widget.chatModelList[index]!, false, theme);
                }),
          ),
        ],
      ).giveHPadding(padding: 15.h).giveTPadding(padding: 30.h),
    );
  }

  Widget userBubble(ChatModel chatModel) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(0), // No radius here
              ),
            ),
            child: Text(
              chatModel.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          height(4.h),
          Text(
            chatModel.timestamp,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget aiBubble(ChatModel chatModel, bool isLoading, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle Avatar
        const CircleAvatar(
          radius: 16,
          backgroundColor: Colors.blue,
          child: Text(
            'A',
            style: TextStyle(color: Colors.white),
          ),
        ),
        width(8),
        if (isLoading) spinKitFadingCircle,
        if (!isLoading)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Text(
                chatModel.text,
                style: TextStyle(
                  color: theme.secondaryHeaderColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
