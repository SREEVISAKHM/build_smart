import 'dart:async';
import 'dart:developer';
import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/db/chat_db.dart';
import 'package:build_smart/core/theme/theme_notifier.dart';
import 'package:build_smart/core/utils/pref.dart';
import 'package:build_smart/features/splash/view/splash_view.dart';
import 'package:build_smart/features/splash/view_model/navigator_provider.dart';
import 'package:build_smart/routes/routes.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await smartPref.init();
    await ChatDatabase.instance.database;
    runApp(const ProviderScope(child: MyApp()));
  }, (error, stack) {
    log('error ::: $error');
    log('stack ::: $stack');
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navKey = ref.watch(navigatorKeyProvider);
    final themeState = ref.watch(themeProvider);

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            title: 'BUILD_SMART',
            theme: themeState.themeData,
            routes: appRoutes(),
            onGenerateRoute: onAppGenerateRoute(),
            initialRoute: SplashView.route,
          );
        });
  }
}
