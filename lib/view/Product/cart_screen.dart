import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../res/constants.dart';
import '../../view model/getx_controllers/product_controller.dart';
import '../../view model/responsive.dart';
import '../main/components/drawer/drawer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final productController = Get.find<ProductController>();

  void _removeProduct(int index) {
    setState(() {
      productController.cartProducts
          .removeAt(index); // Remove product from cart
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          !Responsive.isMobile(context) || !Responsive.isLargeMobile(context)
              ? const CustomDrawer()
              : const SizedBox.shrink(),
          Expanded(
              child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      top: defaultPadding * 2, left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding, horizontal: 10),
                        child: !Responsive.isLargeMobile(context)
                            ? const SizedBox.shrink()
                            : TweenAnimationBuilder(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(milliseconds: 500),
                                builder: (context, value, child) {
                                  return InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height: defaultPadding * 2.0 * value,
                                      width: defaultPadding * 2.0 * value,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .secondaryHeaderColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(.5),
                                                offset: const Offset(1, 1)),
                                            BoxShadow(
                                                color:
                                                    Colors.blue.withOpacity(.5),
                                                offset: const Offset(-1, -1)),
                                          ]),
                                      child: Center(
                                        child: ShaderMask(
                                            shaderCallback: (bounds) {
                                              return LinearGradient(colors: [
                                                Colors.white,
                                                Colors.blue.shade900
                                              ]).createShader(bounds);
                                            },
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                              size:
                                                  defaultPadding * 1.2 * value,
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding, horizontal: 10),
                          child: !Responsive.isLargeMobile(context)
                              ? const SizedBox.shrink()
                              : Text('Cart'.capitalizeFirst!,
                                  style:
                                      Theme.of(context).textTheme.titleLarge)),
                      const Spacer(flex: 2),
                    ],
                  )),
              Obx(() => productController.cartProducts.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: productController.cartProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: const EdgeInsets.all(8),
                            child: ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: productController
                                        .cartProducts[index].images?.first ??
                                    '',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.grey,
                                  child: const SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(
                                  productController.cartProducts[index].title ??
                                      ''),
                              // Product title
                              subtitle: Text(
                                  '${productController.cartProducts[index].category?.toUpperCase()} - \$${productController.cartProducts[index].price.toString()}'),
                              // Product category and price
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () {
                                  _removeProduct(
                                      index); // Remove product from cart
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                          child: Text('Not Cart Item'.capitalizeFirst!,
                              style: Theme.of(context).textTheme.titleLarge)))),
              Obx(() => productController.cartProducts.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total Products: ${productController.cartProducts.length}',
                            // Display total number of products
                            style: const TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Implement checkout functionality or navigate to checkout screen
                            },
                            child: const Text('Checkout'),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ))
        ],
      ),
    );
  }
}
