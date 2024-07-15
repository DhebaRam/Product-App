import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


import '../view model/getx_controllers/product_controller.dart';
import 'main/main_view.dart';

var currentBackPressTime;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    log('Width----> ${MediaQuery.sizeOf(context).width}');
    return WillPopScope(
        onWillPop: onWillPop, child: const SafeArea(top: false,child: MainView()));
  }

  Future<bool> onWillPop() {
    print('currentBackPressTime $currentBackPressTime');
    DateTime now = DateTime.now();

      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: 'Press back again to exit');
        return Future.value(false);
      }
      currentBackPressTime = null;
      return Future.value(true);
    }
}
