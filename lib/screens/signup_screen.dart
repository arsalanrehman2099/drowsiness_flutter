import 'package:app/screens/login_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/white_text_field.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
            margin:
                EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Welcome!',
                    style: ConstantManager.ktextStyle().copyWith(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                      fontWeight: FontWeight.bold,
                      color: ConstantManager.SECONDARY_COLOR,
                    ),
                  ),
                  const Spacebar('h', space: 1),
                  Text(
                    'Sign up to access our app!',
                    style: ConstantManager.ktextStyle(),
                  ),
                  const Spacebar('h', space: 4.5),
                  const WhiteTextField(hint: 'Full Name'),
                  const Spacebar('h', space: 2.0),
                  const WhiteTextField(
                    hint: 'Email Address',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const Spacebar('h', space: 2.0),
                  const WhiteTextField(
                    hint: 'Password',
                    textInputType: TextInputType.text,
                    hideText: true,
                  ),
                  const Spacebar('h', space: 2.0),
                  const WhiteTextField(
                    hint: 'Confirm Password',
                    textInputType: TextInputType.text,
                    hideText: true,
                  ),
                  const Spacebar('h', space: 4.5),
                  _signupButton(),
                  const Spacebar('h', space: 2.5),
                  _navigateLogin()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signupButton() {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => MainScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ConstantManager.SECONDARY_COLOR,
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical! * 1.5,
            horizontal: SizeConfig.blockSizeHorizontal! * 12.0,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: Text(
          'Sign Up',
          style: ConstantManager.ktextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _navigateLogin() {
    return GestureDetector(
      onTap: () {
        Get.to(() => LoginScreen());
      },
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
        child: RichText(
          text: TextSpan(
            text: 'Already have an account? ',
            style: ConstantManager.ktextStyle().copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(
                text: 'Sign in',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ConstantManager
                      .SECONDARY_COLOR, // Change the color to your desired color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
