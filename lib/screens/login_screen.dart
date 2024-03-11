import 'package:app/screens/main_screen.dart';
import 'package:app/screens/signup_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/size_config.dart';
import '../widgets/space_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
            margin: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical! * 2.0),
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
                    'Log in to access our app!',
                    style: ConstantManager.ktextStyle(),
                  ),
                  const Spacebar('h', space: 4.5),
                  const MyTextField(
                    hint: 'Email Address',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const Spacebar('h', space: 2.0),
                  const MyTextField(
                    hint: 'Password',
                    textInputType: TextInputType.text,
                    hideText: true,
                  ),
                  const Spacebar('h', space: 4.5),
                  _loginButton(),
                  const Spacebar('h', space: 2.5),
                  _navigateSignup(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          Get.to(()=>MainScreen());
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
          'Log In',
          style: ConstantManager.ktextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget _navigateSignup() {
    return GestureDetector(
      onTap: () {
        Get.to(() => SignupScreen());
      },
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
        child: RichText(
          text: TextSpan(
            text: 'Don\'t have an account? ',
            style: ConstantManager.ktextStyle().copyWith(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(
                text: 'Sign up',
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
