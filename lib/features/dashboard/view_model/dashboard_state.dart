import 'package:build_smart/config/common_imports.dart';

class BottomNavState extends StateNotifier<BottomNav> {
  BottomNavState() : super(BottomNav.home);

  int getIndex(BottomNav b) {
    switch (b) {
      case BottomNav.home:
        return 0;

      case BottomNav.manual:
        return 1;

      case BottomNav.profile:
        state = BottomNav.profile;

        return 2;
    }
  }

  void change(int index) {
    switch (index) {
      case 0:
        state = BottomNav.home;

        break;
      case 1:
        state = BottomNav.manual;

        break;
      case 2:
        state = BottomNav.profile;

        break;

      default:
        state = BottomNav.home;
    }
  }
}

final bottomNavProvider =
    StateNotifierProvider<BottomNavState, BottomNav>((ref) {
  return BottomNavState();
});

enum BottomNav { home, manual, profile }
