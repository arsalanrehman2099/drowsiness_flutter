import 'package:app/utils/constant_manager.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:flutter/material.dart';

class ScreenInstructionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding:  EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Instructions',
              style: ConstantManager.ktextStyle(
                fontSize: SizeConfig.blockSizeHorizontal! * 6.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacebar('h', space: 1.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text(
                      'Your phone must be aligned horizontally (landscape).',
                      style: ConstantManager.ktextStyle()),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text(
                      'The face must be facing the center of the screen and it has to be clear (not too far).',
                      style: ConstantManager.ktextStyle()),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text(
                      'Make sure there is enough lighting available to detect the face.',
                      style: ConstantManager.ktextStyle()),
                ),
              ],
            ),
            const Spacebar('h', space: 1.5),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK',
                  style: ConstantManager.ktextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      color: ConstantManager.SECONDARY_COLOR)),
            ),
          ],
        ),
      ),
    );
  }
}
