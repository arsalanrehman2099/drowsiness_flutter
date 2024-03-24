import 'dart:io';
import 'dart:typed_data';

import 'package:app/utils/constant_manager.dart';
import 'package:app/utils/size_config.dart';
import 'package:app/widgets/instruction_dialog.dart';
import 'package:app/widgets/space_bar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:get/get.dart';

import 'alarm_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late FlutterVision vision;

  CameraImage? cameraImage;
  late CameraController controller;
  late List<CameraDescription> cameras;

  late Future<void> _initializeControllerFuture;

  bool isLoaded = false;
  bool isDetecting = false;

  late List<Map<String, dynamic>> yoloResults;
  var detections = [];

  int imageHeight = 1;
  int imageWidth = 1;
  DateTime lastFrameTime = DateTime.now();

  int count = 0;

  init() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[1], ResolutionPreset.max);

    _initializeControllerFuture = controller.initialize().then((value) {
      loadYoloModel().then((value) {
        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ScreenInstructionDialog();
            },
          );
        });
      });
    });
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/model.tflite',
        modelVersion: "yolov8",
        numThreads: 2,
        useGpu: true);

    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return ScreenInstructionDialog();
    //     },
    //   );
    // });

    vision = FlutterVision();
    init();
  }

  @override
  void dispose() async {
    super.dispose();
    controller.dispose();
    await vision.closeYoloModel();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    if (!isLoaded) {
      return _loadingModel();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraPreview(controller),
          ...displayBoxesAroundRecognizedObjects(MediaQuery.of(context).size),
          _startButton(),
          // _captureButton(),
        ],
      ),
    );
  }

  Widget _startButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 2.75),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 5, color: Colors.white, style: BorderStyle.solid),
        ),
        child: isDetecting
            ? Transform.rotate(
                angle: 1.5708,
                child: IconButton(
                  onPressed: () async {
                    // setState(() => isDetecting = false);
                    _stopDetection();
                  },
                  icon: const Icon(
                    Icons.stop,
                    color: Colors.red,
                  ),
                  iconSize: SizeConfig.blockSizeHorizontal! * 14,
                ),
              )
            : Transform.rotate(
                angle: 1.5708,
                child: IconButton(
                  onPressed: () async {
                    setState(() => isDetecting = true);
                    await _startDetection();
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  iconSize: SizeConfig.blockSizeHorizontal! * 14,
                ),
              ),
      ),
    );
  }

  Widget _loadingModel() {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: ConstantManager.SECONDARY_COLOR),
            const Spacebar('h', space: 2.0),
            Text("Loading Model...", style: ConstantManager.ktextStyle().copyWith(fontSize: SizeConfig.blockSizeHorizontal! * 4.0)),
          ],
        ),
      ),
    );
  }

  _performCaptureDetection() async {
    try {
      print('Capture Clicked!');

      await _initializeControllerFuture;
      yoloResults.clear();

      XFile photo = await controller.takePicture();
      print('Image saved to: ${photo.path}');
      File imageFile = File(photo.path);
      Uint8List byte = await imageFile.readAsBytes();
      final image = await decodeImageFromList(byte);
      imageHeight = image.height;
      imageWidth = image.width;

      final result = await vision.yoloOnImage(
        bytesList: byte,
        imageHeight: image.height,
        imageWidth: image.width,
        confThreshold: 0.75,
      );

      try {
        imageFile.deleteSync();
        print('Image deleted successfully.');
      } catch (e) {
        print('Failed to delete image: $e');
      }

      if (result.isNotEmpty) {
        print('DETECTED: ${result}');

        setState(() {
          yoloResults = result;
          detections.add(result[0]['tag'].toString().toLowerCase());
          // print(detections);
        });

        if (detections.length >= 3) {
          var lastElements = detections.sublist(detections.length - 3);

          bool allDrowsy = lastElements.every((element) => element == 'drowsy');

          if (allDrowsy) {
            Get.off(() => AlarmScreen());
          }
        }
      } else {
        print("EMPTY RESULTS: $result");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _startDetection() async {
    setState(() => isDetecting = true);
    if (controller.value.isStreamingImages) {
      return;
    }
    await controller.startImageStream((image) async {
      if (isDetecting) {
        var timeSinceLastFrame = DateTime.now().difference(lastFrameTime);

        if (timeSinceLastFrame.inSeconds >= 0.1) {
          count++;
          print(count);

          _performCaptureDetection();

          lastFrameTime = DateTime.now();
        }
      }
    });
  }

  Future<void> _stopDetection() async {
    setState(() {
      isDetecting = false;
      yoloResults.clear();
    });
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    // "box": [x1:left, y1:top, x2:right, y2:bottom]
    // "box": [0:left,  1:top,  2:right,  3:bottom]

    if (yoloResults.isEmpty) return [];

    double factorX = screen.width / (imageWidth);
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (imageHeight);

    double pady = (screen.height - newHeight) / 1.2;

    return yoloResults.map((result) {
      double height = (result["box"][3] - result["box"][1]) * factorY;
      double width = (result["box"][2] - result["box"][0]) * factorX;

      return isDetecting
          ? Positioned(
              top: result['box'][0] * factorY + pady,
              right: result["box"][1] * factorX,
              child: Row(
                children: [
                  Container(
                    height: width,
                    width: height,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(
                        color:
                            result['tag'].toString().toLowerCase() == 'drowsy'
                                ? Colors.red
                                : Colors.green,
                        width: 5.0,
                      ),
                    ),
                  ),
                  RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              result['tag'].toString().toLowerCase() == 'drowsy'
                                  ? Colors.red
                                  : Colors.green,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0)),
                          border: Border.all(
                            color: result['tag'].toString().toLowerCase() ==
                                    'drowsy'
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                        child: Text(
                          " ${result['tag']} - ${(result['box'][4] * 100).toStringAsFixed(0)}% ",
                          style: ConstantManager.ktextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ],
              ),
            )
          : Container();
    }).toList();
  }
}
