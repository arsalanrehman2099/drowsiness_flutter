import 'package:app/screens/camera_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant_manager.dart';
import '../utils/size_config.dart';
import '../widgets/space_bar.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {

  late AudioPlayer player = AudioPlayer();
  String filePath = 'alarm.mp3';

  @override
  void initState() {
    super.initState();

    initPlayer();
  }

  initPlayer() async {
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.loop);
    player.play(AssetSource(filePath));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

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
                Icon(Icons.notifications_active,
                    size: SizeConfig.blockSizeHorizontal! * 30.0),
                const Spacebar('h', space: 3.5),
                Text(
                  'Please wake up\nYou are Driving'.toUpperCase(),
                  style: ConstantManager.ktextStyle().copyWith(
                    fontSize: SizeConfig.blockSizeHorizontal! * 6.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacebar('h', space: 3.5),
                InkWell(
                  onTap: () {
                    Get.off(() => CameraScreen());
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 4.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      'Continue to Drive',
                      style: ConstantManager.ktextStyle().copyWith(
                        fontSize: 16.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
