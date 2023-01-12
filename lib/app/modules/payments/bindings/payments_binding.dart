import 'package:get/get.dart';

import '../controllers/payments_controller.dart';

class PaymentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentsController>(
      () => PaymentsController(),
    );
  }
}
