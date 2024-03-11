import 'package:app/utils/size_config.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:flutter/material.dart';

import '../utils/constant_manager.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final TextInputType textInputType;
  final bool hideText;
  final bool isEnabled;

  const MyTextField(
      {super.key,
      this.controller,
      this.hint,
      this.textInputType = TextInputType.text,
      this.hideText = false,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            hint ?? "",
            style: ConstantManager.ktextStyle().copyWith(
              color: Colors.black.withOpacity(0.9),
            ),
          ),
        ),
        const Spacebar('h', space: 1),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeVertical! * 2.0),
          child: TextField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: hideText,
            cursorColor: Colors.black54,
            enabled: isEnabled,
            style: ConstantManager.ktextStyle().copyWith(color: Colors.black),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
