import 'package:build_smart/features/splash/view_model/splash_view_model.dart';

import '../../../config/common_imports.dart';

class SplashView extends ConsumerStatefulWidget {
  static const String route = '/splash_view';
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(splashViewModelProvider).checkLoginStatus());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Image.asset(
        'assets/images/splash_screen.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
