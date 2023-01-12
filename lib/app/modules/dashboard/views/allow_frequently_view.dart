import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class AllowFrequentlyView extends GetView<DashboardController> {
  const AllowFrequentlyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AllowFrequentlyView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          controller.selectedVisitorTypeFrequent!.label!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
