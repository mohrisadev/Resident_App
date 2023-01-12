import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FlatDetailsView extends GetView {
  const FlatDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlatDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'FlatDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
