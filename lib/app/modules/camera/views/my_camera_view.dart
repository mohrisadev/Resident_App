import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/appconstants.dart';
import '../controllers/my_camera_controller.dart';

class MyCameraView extends GetView<MyCameraController> {
  const MyCameraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appcolors.primaryColor,
        title: Text(
          'Capture Photo',
          style: TextStyle(
              letterSpacing: 0.5, fontWeight: FontWeight.w400, fontSize: 15.0),
        ),
      ),
      backgroundColor: Colors.black,
      key: controller.scaffoldKey,
      extendBody: false,
      body: Stack(
        children: <Widget>[
          _buildCameraPreview(),
          Positioned(
            top: 24.0,
            left: 12.0,
            child: IconButton(
              icon: Icon(
                Icons.switch_camera,
                color: Colors.white,
              ),
              onPressed: () {
                controller.onCameraSwitch();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCameraPreview() {
    if (controller.mounted) {
      return Container(width: 0, height: 0);
    } else {
      final size = MediaQuery.of(Get.context!).size;
      return ClipRect(
        child: Container(
          child: Transform.scale(
            scale:
                controller.camcontroller!.value.aspectRatio / size.aspectRatio,
            child: Center(
              child: AspectRatio(
                aspectRatio: controller.camcontroller!.value.aspectRatio,
                child: CameraPreview(controller.camcontroller!),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: AppConstants.appcolors.primaryColor,
      height: 100.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              onPressed: () {}),

          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28.0,
            child: IconButton(
              icon: Icon(
                (controller.isRecordingMode)
                    ? (controller.isRecording)
                        ? Icons.stop
                        : Icons.videocam
                    : Icons.camera_alt,
                size: 28.0,
                color: (controller.isRecording) ? Colors.red : Colors.black,
              ),
              onPressed: () {
                controller.captureImage();
              },
            ),
          ),

          IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                controller.camRefresh();
              }),

          // IconButton(
          //   icon: Icon(
          //     (_isRecordingMode) ? Icons.camera_alt : Icons.videocam,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       _isRecordingMode = !_isRecordingMode;
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
