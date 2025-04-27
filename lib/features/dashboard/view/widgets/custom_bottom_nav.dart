import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/build_smart_icons.dart';
import 'package:build_smart/features/dashboard/view_model/dashboard_state.dart';

class CustomBottomNav extends ConsumerWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return BottomNavigationBar(
      selectedItemColor: theme.primaryColor,
      unselectedItemColor: theme.disabledColor,
      backgroundColor: theme.highlightColor,
      currentIndex: ref
          .watch(bottomNavProvider.notifier)
          .getIndex(ref.watch(bottomNavProvider)),
      onTap: (index) {
        ref.read(bottomNavProvider.notifier).change(index);
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(BuildSmartIcons.chat),
          label: "AI Chat",
        ),
        const BottomNavigationBarItem(
          icon: Icon(BuildSmartIcons.manual),
          label: "My Manuals",
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            backgroundColor: theme.cardColor,
            child: Text(
              'NA',
              style: TextStyle(
                  color: theme.shadowColor, fontWeight: FontWeight.bold),
            ),
          ),
          label: "Profile",
        ),
      ],
    );
  }
}
