import 'package:app/controllers/user_controller.dart';
import 'package:app/screens/camera_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final UserController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
          child: Stack(
            children: [
              _logoutButton(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => CameraScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(
                            SizeConfig.blockSizeHorizontal! * 20),
                        backgroundColor: ConstantManager.SECONDARY_COLOR,
                      ),
                      child: Text(
                        'Start'.toUpperCase(),
                        style: ConstantManager.ktextStyle().copyWith(
                          fontSize: SizeConfig.blockSizeHorizontal! * 10,
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacebar('h', space: 3.5),
                    Text(
                      'Tap the button to start video recording while you drive!',
                      style: ConstantManager.ktextStyle().copyWith(
                        fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: _controller.userLogout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text('LOGOUT', style: ConstantManager.ktextStyle()),
      ),
    );
  }
}
