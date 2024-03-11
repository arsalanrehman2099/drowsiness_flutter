import 'package:app/screens/alarm_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => AlarmScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 20),
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
        ),
      ),
    );
  }
}
