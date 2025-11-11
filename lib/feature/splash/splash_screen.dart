import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/naviagtion.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var userData = SharedPref.getUserData();
    Future.delayed(const Duration(seconds: 3), () {
      if (userData != null) {
        pushWithReplacement(context, Routes.main);
      } else {
        pushWithReplacement(context, Routes.welcome);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.logoSvg, width: 220),
            Gap(10),
            Text('Order Your Book Now!', style: TextStyles.styleSize18()),
          ],
        ),
      ),
    );
  }
}
