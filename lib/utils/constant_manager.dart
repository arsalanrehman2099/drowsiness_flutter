import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantManager{
  static const PRIMARY_COLOR = Color(0xffd4f2e8);
  static const SECONDARY_COLOR = Color(0xff2d4a90);

  static var ktextStyle = GoogleFonts.openSans;

  static showtoast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.white,
      textColor: Colors.grey.shade900,
    );
  }

}