import 'package:app/controllers/user_controller.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/white_text_field.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../models/user.dart';
import '../widgets/overlay_loader.dart';
import 'main_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _cfmPass = TextEditingController();

  final UserController _controller = Get.find();

  _register() async {
    if (_name.text == "") {
      ConstantManager.showtoast('Name is required');
    } else if (_email.text == "") {
      ConstantManager.showtoast('Email is required');
    } else if (_pass.text == "") {
      ConstantManager.showtoast('Password is required');
    } else if (_pass.text.length < 6) {
      ConstantManager.showtoast('Password must be greater than 6');
    } else if (_cfmPass.text == "") {
      ConstantManager.showtoast('Confirm Password is required');
    } else if (_cfmPass.text != _pass.text) {
      ConstantManager.showtoast('Password Mismatch');
    } else {
      final user = User(
          name: _name.text.trim(),
          email: _email.text.trim(),
          password: _pass.text.trim(),
          createdAt: Timestamp.now());

      final response = await _controller.userSignup(user);

      if (response['error'] == 1) {
        ConstantManager.showtoast('Error: ' + response['message']);
      } else {
        ConstantManager.showtoast('User Registered Successfully');
        Get.offAll(() => MainScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      body: Obx(() => LoadingOverlay(
            color: ConstantManager.SECONDARY_COLOR,
            progressIndicator: OverlayLoader(),
            isLoading: _controller.loading.value,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
                  margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical!),
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
                        WhiteTextField(hint: 'Full Name', controller: _name),
                        const Spacebar('h', space: 2.0),
                        WhiteTextField(
                          hint: 'Email Address',
                          textInputType: TextInputType.emailAddress,
                          controller: _email,
                        ),
                        const Spacebar('h', space: 2.0),
                        WhiteTextField(
                          hint: 'Password',
                          textInputType: TextInputType.text,
                          hideText: true,
                          controller: _pass,
                        ),
                        const Spacebar('h', space: 2.0),
                        WhiteTextField(
                          hint: 'Confirm Password',
                          textInputType: TextInputType.text,
                          hideText: true,
                          controller: _cfmPass,
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
          )),
    );
  }

  Widget _signupButton() {
    return SizedBox(
      child: ElevatedButton(
        onPressed: _register,
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
