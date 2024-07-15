import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pracatical_demo/view/Product/all_product_screen.dart';
import 'package:pracatical_demo/view/home.dart';
import '../../../../res/constants.dart';
import '../../../../view model/getx_controllers/product_controller.dart';
import '../../../../view model/responsive.dart';
import '../../../Product/cart_screen.dart';
import 'about.dart';

final controller = Get.find<ProductController>();

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const About(),
            Container(
              color: Theme.of(context).drawerTheme.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding / 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Responsive.isLargeMobile(context)
                        ? const SizedBox.shrink()
                        : ListTile(
                            onTap: () {
                              Get.back();
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      child: const HomePage()));
                            },
                            leading: const Icon(Icons.home_outlined),
                            title: Text('Home',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            trailing: Icon(Icons.navigate_next,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color),
                          ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 600),
                                child: const CartScreen()));
                      },
                      leading: const Icon(Icons.add_shopping_cart),
                      title: Text('Cart',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).textTheme.titleSmall!.color),
                    ),
                    ListTile(
                      onTap: () {
                        // Get.back();
                        if (Get.isDarkMode) {
                          Get.changeTheme(ThemeData.light());
                        } else {
                          Get.changeTheme(ThemeData.dark());
                        }
                      },
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: Text('Theme',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).textTheme.titleSmall!.color),
                    ),
                    ListTile(
                      onTap: () {
                        Get.back();
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.fade,
                        //         duration: const Duration(milliseconds: 600),
                        //         child: const CartScreen()));
                      },
                      leading: const Icon(Icons.category_outlined),
                      title: Text('Categories',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600)),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).textTheme.titleSmall!.color),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 30),
                      children: <Widget>[
                        ListTile(
                          title: const Text('Beauty'),
                          onTap: () {
                            Navigator.pop(context);
                            controller.filterProduct('beauty');
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 600),
                                    child: const AllProductsScreen()));
                          },
                        ),
                        ListTile(
                          title: const Text('Fragrances'),
                          onTap: () {
                            // Implement navigation or filtering for fragrances products
                            Navigator.pop(context);
                            controller.filterProduct('fragrances');
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 600),
                                    child: const AllProductsScreen()));
                          },
                        ),
                        ListTile(
                          title: const Text('Groceries'),
                          onTap: () {
                            // Implement navigation or filtering for groceries products
                            Navigator.pop(context);
                            controller.filterProduct('groceries');
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 600),
                                    child: const AllProductsScreen()));
                          },
                        ),
                        ListTile(
                          title: const Text('Furniture'),
                          onTap: () {
                            // Implement navigation or filtering for furniture products
                            Navigator.pop(context);
                            controller.filterProduct('furniture');
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: const Duration(milliseconds: 600),
                                    child: const AllProductsScreen()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
