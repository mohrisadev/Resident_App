import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';
import 'package:mykommunity/app/routes/app_pages.dart';
import 'package:path_provider/path_provider.dart';

class MyCameraController extends GetxController {
  //TODO: Implement CameraController

  var firstCamera;
  CameraController? camcontroller;
  List<CameraDescription>? cameras;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isRecordingMode = false;
  bool isRecording = false;
  bool mounted = false;
  //controllers
  HelpdeskController? hlpdeskController;

  @override
  void onInit() {
    super.onInit();
    //initCamera();
  }

  @override
  void onReady() {
    super.onReady();
    //initCamera();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    camcontroller!.dispose();
    super.dispose();
  }

  void initCamera() async {
    cameras = await availableCameras();
    camcontroller = CameraController(cameras![0], ResolutionPreset.high);

    camcontroller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      update();
    });
  }

  Future<void> onCameraSwitch() async {
    final CameraDescription cameraDescription =
        (camcontroller!.description == cameras![0]) ? cameras![1] : cameras![0];
    if (camcontroller! != null) {
      await camcontroller!.dispose();
    }
    camcontroller = CameraController(cameraDescription, ResolutionPreset.high);
    camcontroller!.addListener(() {
      if (camcontroller!.value.hasError) {
        // showInSnackBar('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await camcontroller!.initialize();
    } on CameraException catch (e) {
      //_showCameraException(e);
    }
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void captureImage() async {
    //print('_captureImage');
    if (camcontroller!.value.isInitialized) {
      SystemSound.play(SystemSoundType.click);
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/media';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${_timestamp()}.jpeg';
      //print('path: $filePath');
      await camcontroller!.takePicture();
      update();

      //Get.toNamed(Routes.GALLERY);
    }
  }

  Future<void> camRefresh() async {
    //this is to refresh teh camera.
    final CameraDescription cameraDescription =
        (camcontroller!.description == cameras![0]) ? cameras![0] : cameras![1];
    if (camcontroller != null) {
      await camcontroller!.dispose();
    }
    camcontroller = CameraController(cameraDescription, ResolutionPreset.high);
    camcontroller!.addListener(() {
      if (camcontroller!.value.hasError) {
        //  showInSnackBar('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await camcontroller!.initialize();
    } on CameraException catch (e) {
      // _showCameraException(e);
    }

    update();
  }
}
