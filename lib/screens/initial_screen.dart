import 'package:app/screens/login_screen.dart';
import 'package:app/screens/signup_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/size_config.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 5.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _introText(),
            const Spacebar('h', space: 7.0),
            _loginButton(),
            const Spacebar('h', space: 1.5),
            _signupButton()
          ],
        ),
      ),
    );
  }

  Widget _introText() {
    return Column(
      children: [
        Image.asset(
          'assets/icon.jpeg',
          // height: SizeConfig.blockSizeHorizontal! * 80,
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
        SizedBox(
          height: SizeConfig.blockSizeVertical!,
        ),
        Text(
          'Our application detects drowsiness during driving.',
          textAlign: TextAlign.center,
          style: ConstantManager.ktextStyle(),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => LoginScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ConstantManager.SECONDARY_COLOR,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: Text(
          'Log In',
          style: ConstantManager.ktextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _signupButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          Get.to(() => SignupScreen());
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: ConstantManager.SECONDARY_COLOR),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: Text(
          'Sign Up',
          style: ConstantManager.ktextStyle(
            color: ConstantManager.SECONDARY_COLOR,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
