import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/theme/colors.dart';
import 'package:build_smart/core/theme/theme.dart';
import 'package:build_smart/core/theme/theme_notifier.dart';
import 'package:build_smart/core/utils/pref.dart';
import 'package:build_smart/features/chat_history/view/chat_history_view.dart';
import 'package:build_smart/features/dashboard/model/chat_model.dart';
import 'package:build_smart/features/dashboard/view/home_view.dart';
import 'package:build_smart/features/dashboard/view/manual_view.dart';
import 'package:build_smart/features/dashboard/view/profile_view.dart';
import 'package:build_smart/features/dashboard/view/widgets/custom_bottom_nav.dart';
import 'package:build_smart/features/dashboard/view_model/dashboard_state.dart';
import 'package:build_smart/features/dashboard/view_model/home_view_model.dart';

class DashboardView extends ConsumerStatefulWidget {
  static const String route = '/dashboard_view';
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    final bottonState = ref.watch(bottomNavProvider);
    final homeViewModel = ref.watch(homeViewModelProvider.notifier);
    final homeViewState = ref.watch(homeViewModelProvider);
    final bottonmNavState = ref.watch(bottomNavProvider.notifier);
    final themeState = ref.watch(themeProvider);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.highlightColor,
        surfaceTintColor: theme.highlightColor,
        title: SizedBox(
          child: Text(
            'Build.Smart',
            style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, ChatHistoryView.route);
            },
            icon: Icon(
              Icons.history,
              color: theme.disabledColor,
            ),
          ),
          width(10.w),
          GestureDetector(
            onTap: () {
              if (homeViewState.data.isNotEmpty) {
                List<ChatModel?> chatList = homeViewState.data;
                homeViewModel.saveChatSession(chatList);
              }
              // homeViewModel.newChat();
              bottonmNavState.change(0);
            },
            child: Container(
              height: 24.sp,
              width: 24.sp,
              decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))),
              child: Icon(
                Icons.add,
                size: 15.sp,
                color: theme.highlightColor,
              ),
            ),
          ),
          width(10.w),
          IconButton(
            onPressed: () {
              final newTheme = themeState.appTheme == AppTheme.light
                  ? AppTheme.dark
                  : AppTheme.light;
              ref.read(themeProvider.notifier).setTheme(newTheme);
            },
            icon: Icon(
              themeState.appTheme != AppTheme.light
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
              color: theme.disabledColor,
            ),
          ),
        ],
      ),
      body: Builder(builder: (_) {
        switch (bottonState) {
          case BottomNav.home:
            return const HomeView();

          case BottomNav.manual:
            return const ManualView();

          case BottomNav.profile:
            return const ProfileView();
        }
      }),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
