import 'package:get/get.dart';

import '../controllers/amenities_controller.dart';

class AmenitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmenitiesController>(
          () => AmenitiesController(),
    );
  }
}
