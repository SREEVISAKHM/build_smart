import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/extensions.dart';
import 'package:build_smart/core/utils/loader.dart';
import 'package:build_smart/features/dashboard/model/chat_model.dart';
import 'package:build_smart/features/dashboard/view_model/home_view_model.dart';
import 'package:build_smart/features/dashboard/view_model/home_view_state.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final homeViewState = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: buildBody(homeViewState, theme),
          ),
        ),
        _buildInputArea(viewModel, theme, context),
      ],
    ).giveHPadding(padding: 15.w);
  }

  Widget _buildInputArea(
      HomeViewModel viewModel, ThemeData theme, BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: theme.highlightColor,
            borderRadius: BorderRadius.circular(20.r)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.mic_none),
              onPressed: () {
                viewModel.sentMessage(_controller.text);
                _controller.clear();
              },
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Ask me anything...',
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  viewModel.sentMessage(value);
                  _controller.clear();
                },
              ),
            ),
            IconButton(
              icon: CircleAvatar(
                  backgroundColor: theme.disabledColor,
                  child: Icon(
                    Icons.send_rounded,
                    color: theme.highlightColor,
                    size: 20.sp,
                  ).giveLPadding(padding: 4.w)),
              onPressed: () {
                viewModel.sentMessage(_controller.text);
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
        ),
      ).giveBPadding(padding: 20.h),
    );
  }

  Widget buildBody(HomeViewState homeViewState, ThemeData theme) {
    switch (homeViewState.status) {
      case HomeViewStatus.initial:
        return ListView(
          children: [
            height(60.h),
            Align(
              child: SizedBox(
                  width: 120.w,
                  child: Image.asset(
                    'assets/images/ai.png',
                    fit: BoxFit.fitWidth,
                  )),
            ),
            height(20.sp),
            Text(
              'Your personal home assistant for all\nthings maintenance,troubleshooting,and\nhome management!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.secondaryHeaderColor,
                fontSize: 15.sp,
              ),
            ),
            height(20.h),
            _buildTile(theme, 'How do i check for a gas leak at home ?'),
            _buildTile(
                theme, 'The power outlets in my kitchen aren\'t working.'),
            _buildTile(theme, 'How do i reset my home security alarm?'),
          ],
        );
      case HomeViewStatus.loading:
        return _buildChat(homeViewState, theme, false);

      case HomeViewStatus.success:
        return _buildChat(homeViewState, theme, true);
      // return Column(
      //   children: [
      //     height(10.sp),
      //     const Text('Today'),
      //     Expanded(
      //       child: ListView.builder(
      //           itemCount: homeViewState.data.length,
      //           itemBuilder: (_, index) {
      //             if (homeViewState.data[index]!.isUser) {
      //               return userBubble(homeViewState.data[index]!);
      //             }
      //             return aiBubble(homeViewState.data[index]!, false, theme);
      //           }),
      //     ),
      //   ],
      // );

      case HomeViewStatus.error:
        return SizedBox(
          child: Center(
            child: Text(homeViewState.error ?? 'Something went Wrong'),
          ),
        );
    }
  }

  Widget _buildTile(ThemeData theme, String title) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _controller.text = title;
          });
        },
        child: Container(
          width: 1.sw,
          height: 40.h,
          decoration: BoxDecoration(
              color: theme.indicatorColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: theme.hoverColor),
            ),
          ),
        )).giveBPadding(padding: 15.h);
  }

  Column _buildChat(
      HomeViewState homeViewState, ThemeData theme, bool isSuccess) {
    return Column(
      children: [
        height(10.h),
        Expanded(
          child: ListView.builder(
              controller:
                  ref.read(homeViewModelProvider.notifier).scrollController,
              itemCount: homeViewState.data.length,
              itemBuilder: (_, index) {
                bool isLoading;
                if (isSuccess) {
                  isLoading = false;
                } else {
                  isLoading =
                      homeViewState.data[index] == homeViewState.data.last;
                }
                if (homeViewState.data[index]!.isUser) {
                  return Column(
                    children: [
                      if (index == 0) const Text('Today'),
                      height(10.h),
                      userBubble(homeViewState.data[index]!),
                    ],
                  );
                }
                return aiBubble(homeViewState.data[index]!, isLoading, theme);
              }),
        ),
      ],
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
