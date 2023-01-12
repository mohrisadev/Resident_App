import 'package:get/get.dart';

import '../controllers/localservice_controller.dart';

class LocalserviceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalserviceController>(
      () => LocalserviceController(),
    );
  }
}
