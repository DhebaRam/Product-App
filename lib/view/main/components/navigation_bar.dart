import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../res/constants.dart';
import '../../../view model/getx_controllers/product_controller.dart';
import '../../../view model/responsive.dart';
import 'drawer/side_menu_button.dart';

class TopNavigationBar extends StatefulWidget {
  final String? title;

  const TopNavigationBar({super.key, this.title});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  final controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: 10),
            child: !Responsive.isTablet(context)
                ? const SizedBox.shrink()
                : MenuButton(onTap: () => Scaffold.of(context).openDrawer()),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: 10),
              child: !Responsive.isTablet(context)
                  ? const SizedBox.shrink()
                  : Obx(()=> Text(controller.selectedTitle.value.capitalizeFirst!,
                  style: Theme.of(context).textTheme.titleMedium))),
          // if(Responsive.isLargeMobile(context)) MenuButton(),
          // if (!Responsive.isLargeMobile(context)) const NavigationButtonList(),
          const Spacer(flex: 2),
          Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: defaultPadding, horizontal: 10),
              child: !Responsive.isTablet(context)
                  ? const SizedBox.shrink()
                  : Obx(() => Row(
                        children: [
                          Text('Total Product : ' ?? '',
                              style: Theme.of(context).textTheme.titleMedium),
                          Text(controller.productsList.length.toString() ?? '',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ))),
        ],
      ),
    );
  }
}
