import 'package:app/utils/size_config.dart';
import 'package:flutter/material.dart';

class Spacebar extends StatelessWidget {
  final String d;
  final double space;

  const Spacebar(this.d, {super.key, required this.space});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (d == 'h') {
      return  SizedBox(height: SizeConfig.blockSizeVertical! * space);
    } else {
      return  SizedBox(width: SizeConfig.blockSizeHorizontal! * space);
    }
  }
}
