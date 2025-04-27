import 'dart:developer';

import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/theme/colors.dart';
import 'package:build_smart/core/utils/extensions.dart';
import 'package:build_smart/core/utils/pref.dart';
import 'package:build_smart/features/auth/view_model/login_state.dart';
import 'package:build_smart/features/auth/view_model/login_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  static const String route = '/login_view';
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    final obscureState = ref.watch(obscureProvider.notifier);
    final theme = Theme.of(context);
    final loginState = ref.watch(loginViewModelProvider);
    // Show snackbar on error
    if (loginState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginState.error!),
            backgroundColor: Colors.red,
          ),
        );
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.highlightColor,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height - kToolbarHeight - 5.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  height: 80.h,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          color: theme.secondaryHeaderColor,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  height(10.h),
                  Text(
                    'Enter Your existing username and password \nto login',
                    style: TextStyle(
                      color: theme.secondaryHeaderColor,
                      fontSize: 17.5.sp,
                    ),
                  ),
                  height(20.h),
                  buildTextField(
                    title: 'Username',
                    theme: theme,
                    controller: _usernameController,
                    hintText: 'Enter name',
                  ),
                  height(20.h),
                  buildTextField(
                    title: 'Password',
                    theme: theme,
                    controller: _passwordController,
                    hintText: 'Enter password',
                    isObscure: ref.watch(obscureProvider),
                    suffixIcon: IconButton(
                      icon: Icon(
                        ref.watch(obscureProvider)
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: theme.disabledColor,
                      ),
                      onPressed: () {
                        smartPref.clear();
                        // obscureState.toggle();
                      },
                    ),
                  ),
                  height(25.h),
                  SizedBox(
                    width: 1.sw,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(loginViewModelProvider.notifier).login(
                            email: _usernameController.text,
                            password: _passwordController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: theme.highlightColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Builder(builder: (context) {
                        switch (loginState.status) {
                          case LoginStatus.loading:
                            log('loading', name: 'status');
                            return SizedBox(
                              height: 12.sp,
                              width: 12.sp,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: theme.cardColor,
                                ),
                              ),
                            );

                          default:
                            log('default', name: 'status');

                            return Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: theme.shadowColor,
                                  fontWeight: FontWeight.bold),
                            );
                        }
                      }),
                    ),
                  ),
                  height(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24.sp,
                            width: 24.sp,
                            child: Checkbox(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          width(8),
                          Text(
                            'Keep me logged in',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to forgot password
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: theme.secondaryHeaderColor,
                                    offset: const Offset(0, -5))
                              ],
                              decoration: TextDecoration.underline,
                              fontSize: 13.sp,
                              color: Colors.transparent),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bottomButton('Contact', () {}),
                    bottomButton('Privacy Policy', () {}),
                    bottomButton('About', () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).giveHPadding(padding: 15.sp).giveVPadding(padding: 30.h),
    );
  }

  Widget buildTextField(
      {required String title,
      required ThemeData theme,
      TextEditingController? controller,
      bool isObscure = false,
      Widget? suffixIcon,
      String? hintText}) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: TextStyle(
              color: theme.secondaryHeaderColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        height(10.h),
        TextField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.canvasColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.canvasColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.canvasColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.canvasColor),
            ),
            filled: true,
            fillColor: theme.highlightColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  TextButton bottomButton(String name, void Function()? onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        name,
        style: TextStyle(
          color: colorBlue,
          fontWeight: FontWeight.bold,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}
