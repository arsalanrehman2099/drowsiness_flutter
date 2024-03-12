import 'dart:async';

import 'package:app/screens/main_screen.dart';
import 'package:app/widgets/overlay_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constant_manager.dart';
import '../../utils/size_config.dart';
import '../controllers/user_controller.dart';
import '../widgets/space_bar.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (_controller.isLoggedIn()) {
        Get.off(() => MainScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon-no-bg.png',
              height: SizeConfig.blockSizeHorizontal! * 75,
            ),
            const Spacebar('h', space: 2.5),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: ConstantManager.ktextStyle()
                    .copyWith(fontSize: SizeConfig.blockSizeHorizontal! * 5.0),
                children: const [
                  TextSpan(
                    text: 'Sleep',
                    style: TextStyle(
                      color: ConstantManager.SECONDARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' during ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Driving',
                    style: TextStyle(
                      color: ConstantManager.SECONDARY_COLOR,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' can be very ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Dangerous',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacebar('h', space: 2.5),
            const CircularProgressIndicator(
                color: ConstantManager.SECONDARY_COLOR)
          ],
        ),
      ),
    );
  }
}
