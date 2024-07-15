import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/constants.dart';
import '../../view model/getx_controllers/product_controller.dart';
import 'components/animated_texts_components.dart';
import 'components/animated_loading_text.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final controller = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProductData(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedImageContainer(
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: defaultPadding,
            ),
            AnimatedLoadingText(),
            SizedBox(
              height: defaultPadding,
            ),
            Text('Practical Task',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.pink,
                          blurRadius: 10,
                          offset: Offset(2, 2)),
                      Shadow(
                          color: Colors.blue,
                          blurRadius: 10,
                          offset: Offset(-2, -2)),
                    ]))
          ],
        ),
      ),
    );
  }
}
