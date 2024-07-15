import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view model/getx_controllers/product_controller.dart';
import '../../view model/responsive.dart';
import '../Product/home_screen.dart';
import 'components/drawer/drawer.dart';
import 'components/navigation_bar.dart';

final controller = Get.find<ProductController>();

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             !Responsive.isTablet(context)
                ? const SizedBox.shrink()
                : const SizedBox(
                    height: 80,
                    child: TopNavigationBar(),
                  ).marginOnly(top: 30),
            // const Expanded(child: CategoryScreen()),
            const Expanded(
                child: Responsive(
                    desktop: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomDrawer(),
                        Expanded(child: CategoryScreen(
                          crossAxisCount: 3,
                        ))
                      ],
                    ),
                    extraLargeScreen: Row(children: [
                      CustomDrawer(),
                      Expanded(child: CategoryScreen(crossAxisCount: 3))
                    ]),
                    largeMobile: CategoryScreen(crossAxisCount: 2, ratio: 1.8),
                    mobile: CategoryScreen(crossAxisCount: 2, ratio: 1.1),
                    tablet: CategoryScreen(
                      ratio: 1.4,
                      crossAxisCount: 2,
                    )
                ))
          ],
        ),
      ),
    );
  }
}
