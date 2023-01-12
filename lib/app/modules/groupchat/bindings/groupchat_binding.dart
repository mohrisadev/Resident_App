import 'package:get/get.dart';

import '../controllers/groupchat_controller.dart';

class GroupchatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupchatController>(
      () => GroupchatController(),
    );
  }
}
