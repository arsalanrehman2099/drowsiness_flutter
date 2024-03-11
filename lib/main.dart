import 'package:app/screens/initial_screen.dart';
import 'package:app/utils/constant_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Drowsiness Detector',
      theme: ThemeData(primaryColor: ConstantManager.PRIMARY_COLOR
      ),
      home: InitialScreen(),
    );
  }
}
