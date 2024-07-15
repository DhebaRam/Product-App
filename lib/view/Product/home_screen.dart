import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pracatical_demo/view/Product/all_product_screen.dart';
import 'package:pracatical_demo/view/main/main_view.dart';

import '../../view model/getx_controllers/product_controller.dart';

class CategoryScreen extends StatefulWidget {
  final int crossAxisCount;
  final double ratio;
  const CategoryScreen({super.key, this.crossAxisCount = 3,  this.ratio=1.3});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<CategoryScreen> {
  final controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => GridView.count(
            crossAxisCount: widget.crossAxisCount,
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: widget.ratio,
            children: controller.categoryCounts.keys.map((category) {
              return CategoryCard(
                  category, controller.categoryCounts[category]!);
            }).toList(),
          )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final int productCount;

  const CategoryCard(this.category, this.productCount, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          if ('beauty' == category) {
            controller.filterProduct('beauty');
          } else if ('fragrances' == category) {
            controller.filterProduct('fragrances');
          } else if ('groceries' == category) {
            controller.filterProduct('groceries');
          } else if ('furniture' == category) {
            controller.filterProduct('furniture');
          } else {
            controller.filterProduct('All Product');
          }
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 600),
                  child: const AllProductsScreen()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              category.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Products: $productCount',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
