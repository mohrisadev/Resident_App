import 'package:get/get.dart';
import 'package:mykommunity/app/modules/helpdesk/controllers/helpdesk_controller.dart';

import '../controllers/my_camera_controller.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCameraController>(() => MyCameraController());
    Get.lazyPut<HelpdeskController>(() => HelpdeskController());
  }
}
