import 'package:get/get.dart';

import '../controllers/notice_board_controller.dart';

class NoticeBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticeBoardController>(
      () => NoticeBoardController(),
    );
  }
}
