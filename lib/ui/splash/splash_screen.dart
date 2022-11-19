import 'package:flutter/material.dart';
import 'package:vendorapp/core/icons/app_icon_keys.g.dart';

import '../../core/core.dart';
import '../ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCoreCubit, AppCoreState>(
      bloc: context.read<AppCoreCubit>()..checkUser(),
      listener: (context, state) {
        if (state is AppCoreNavigateToLoginPage) {
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          //   builder: (context) {
          //     return const LoginScreen();
          //   },
          // ), (e) => false);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) {
                return const HomeContainer();
              },
            ), (e) => false);
        }
        // if (state is AppCoreNavigateToHomeScreen) {
        //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        //     builder: (context) {
        //       return const HomeContainer();
        //     },
        //   ), (e) => false);
        // }
      },
      child: Scaffold(
        backgroundColor: AppTheme.appRed,
        body: Center(
            child: Image.asset(
          AppIconKeys.dwarikaMain,
          height: 256,
          width: 256,
        )),
      ),
    );
  }
}
