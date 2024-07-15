import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pracatical_demo/view%20model/getx_controllers/product_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/product_model.dart';
import '../../res/constants.dart';

import '../../view model/responsive.dart';
import '../main/components/drawer/drawer.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final controller = Get.find<ProductController>();
  static TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController
      .addListener(() {
        controller.filterProducts(
            searchController.text, controller.selectedTitle.value);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          !Responsive.isTablet(context)
              ? const CustomDrawer()
              : const SizedBox.shrink(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Responsive.isTablet(context)
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: Responsive.isLargeMobile(context)
                              ? defaultPadding * 2
                              : defaultPadding,
                          left: 10,
                          right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding, horizontal: 10),
                            child: !Responsive.isTablet(context)
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
                                                    color: Colors.blue
                                                        .withOpacity(.5),
                                                    offset:
                                                        const Offset(-1, -1)),
                                              ]),
                                          child: Center(
                                            child: ShaderMask(
                                                shaderCallback: (bounds) {
                                                  return LinearGradient(
                                                      colors: [
                                                        Colors.white,
                                                        Colors.blue.shade900
                                                      ]).createShader(bounds);
                                                },
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                  size: defaultPadding *
                                                      1.2 *
                                                      value,
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
                              child: !Responsive.isTablet(context)
                                  ? const SizedBox.shrink()
                                  : Obx(() => Text(
                                      controller
                                          .selectedTitle.value.capitalizeFirst!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium))),
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          Text(
                                              controller.productsList.length
                                                      .toString() ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium),
                                          IconButton(
                                              icon: const Icon(Icons.settings),
                                              onPressed: () {
                                                if (Get.isDarkMode) {
                                                  Get.changeTheme(
                                                      ThemeData.light());
                                                } else {
                                                  Get.changeTheme(
                                                      ThemeData.dark());
                                                }
                                              }),
                                        ],
                                      ))),
                        ],
                      ))
                  : const SizedBox.shrink(),
              !Responsive.isTablet(context)
                  ? Container(
                      padding: const EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          fillColor: Colors.white70,
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                        ),
                        controller: searchController,
                        onChanged: (value) {},
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          filled: true,
                          // hintStyle: TextStyle(color: Colors.grey[800]),
                          // fillColor: Colors.white70,
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                        ),
                        controller: searchController,
                        onChanged: (value) {
                        },
                      ),
                    ),
              Obx(() => Expanded(
                  child: controller.productsList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.productsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: Obx(() => ExpansionPanelList(
                                    elevation: 1,
                                    expandedHeaderPadding:
                                        const EdgeInsets.all(0),
                                    expansionCallback:
                                        (int panelIndex, bool isExpanded) {
                                      controller.setExpandedIndex(!isExpanded
                                          ? -1
                                          : index); // Toggle expansion
                                    },
                                    children: [
                                      ExpansionPanel(
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return ListTile(
                                            leading: CachedNetworkImage(
                                              imageUrl: controller
                                                      .productsList[index]
                                                      .images
                                                      ?.first ??
                                                  '',
                                              height: defaultPadding * 6.0,
                                              width: defaultPadding * 4.0,
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            title: Text(controller
                                                    .productsList[index]
                                                    .title ??
                                                ''),
                                            subtitle: Text(
                                                '${controller.productsList[index].category?.toUpperCase()} - \$${controller.productsList[index].price.toString()}'),
                                          );
                                        },
                                        body: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Text(
                                                  'Brand: ${controller.productsList[index].brand}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(fontSize: 15)),
                                              const SizedBox(height: 8),
                                              Text(
                                                  'Discount: ${controller.productsList[index].discountPercentage}%',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(fontSize: 15)),
                                              const SizedBox(height: 8),
                                              Text(
                                                  'Warranty: ${controller.productsList[index].warrantyInformation}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall!
                                                      .copyWith(fontSize: 15)),
                                              const SizedBox(height: 8),
                                              // Text('Reviews: ${products[index]['reviews']}'),
                                              const SizedBox(height: 16),
                                              ElevatedButton(
                                                style: Theme.of(context)
                                                    .elevatedButtonTheme
                                                    .style,
                                                onPressed: () {
                                                  _showProductDetails(
                                                      context,
                                                      controller.productsList[
                                                          index]); // Show product details
                                                },
                                                child: const Text(
                                                  'Details',
                                                )
                                                    .marginSymmetric(
                                                        vertical: 10)
                                                    .paddingSymmetric(
                                                        vertical: 5),
                                              ),
                                            ],
                                          ),
                                        ),
                                        isExpanded:
                                            controller.expandedIndex.value ==
                                                index,
                                      ),
                                    ],
                                  )),
                            );
                          },
                        )
                      : Center(
                          child: Text("Not Product Found",
                              style: Theme.of(context).textTheme.titleLarge))

                  //     GridView.builder(
                  //   padding: EdgeInsets.zero,
                  //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 10,
                  //     mainAxisSpacing: 10,
                  //     childAspectRatio: 0.75, // Adjust as needed
                  //   ),
                  //   itemCount: controller.productsList.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return GestureDetector(
                  //       onTap: () {
                  //         _showProductDetails(
                  //             context, controller.productsList[index]);
                  //       },
                  //       child: Card(
                  //         elevation: 5,
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Stack(
                  //               alignment: AlignmentDirectional.topEnd,
                  //               children: [
                  //                 CachedNetworkImage(
                  //                   imageUrl: controller
                  //                           .productsList[index].images?.first ??
                  //                       '',
                  //                   // Replace with actual image URL field from API
                  //                   placeholder: (context, url) =>
                  //                       Shimmer.fromColors(
                  //                     baseColor: Colors.grey,
                  //                     highlightColor: Colors.grey,
                  //                     child: const SizedBox(
                  //                       height: 150,
                  //                       width: double.infinity,
                  //                     ),
                  //                   ),
                  //                   errorWidget: (context, url, error) =>
                  //                       const Icon(Icons.error),
                  //                   fit: BoxFit.cover,
                  //                   height: 150,
                  //                   width: double.infinity,
                  //                 ),
                  //                 AnimatedContainer(
                  //                     decoration: BoxDecoration(
                  //                         color: bgColor.withOpacity(0.4),
                  //                         borderRadius: BorderRadius.circular(10)),
                  //                     padding: const EdgeInsets.all(8),
                  //                     duration: const Duration(microseconds: 600),
                  //                     child: Column(
                  //                       children: [
                  //                         Text(
                  //                           '${controller.productsList[index].discountPercentage.toString() ?? ''}%',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .titleSmall!
                  //                               .copyWith(
                  //                                   fontWeight: FontWeight.w600),
                  //                           maxLines: 1,
                  //                           overflow: TextOverflow.ellipsis,
                  //                         ),
                  //                         Text(
                  //                           'Discount',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .titleSmall!
                  //                               .copyWith(fontSize: 12),
                  //                           maxLines: 1,
                  //                           overflow: TextOverflow.ellipsis,
                  //                         ),
                  //                       ],
                  //                     ))
                  //               ],
                  //             ),
                  //             const Spacer(),
                  //             AnimatedContainer(
                  //                 width: double.infinity,
                  //                 padding: const EdgeInsets.all(8),
                  //                 margin: const EdgeInsets.all(1),
                  //                 decoration: const BoxDecoration(
                  //                     color: bgColor,
                  //                     borderRadius: BorderRadius.only(
                  //                         bottomLeft: Radius.circular(10),
                  //                         bottomRight: Radius.circular(10))),
                  //                 duration: const Duration(microseconds: 600),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       controller.productsList[index].title ?? '',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .titleSmall!
                  //                           .copyWith(),
                  //                       maxLines: 1,
                  //                       overflow: TextOverflow.ellipsis,
                  //                     ),
                  //                     Padding(
                  //                       padding:
                  //                           const EdgeInsetsDirectional.fromSTEB(
                  //                               0, 2, 0, 0),
                  //                       child: Row(
                  //                         mainAxisSize: MainAxisSize.max,
                  //                         children: [
                  //                           Text(
                  //                             '\$${controller.productsList[index].price}',
                  //                             style: Theme.of(context)
                  //                                 .textTheme
                  //                                 .titleSmall!,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       'Brand: ${controller.productsList[index].title ?? ''}',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .titleSmall!
                  //                           .copyWith(),
                  //                       maxLines: 1,
                  //                       overflow: TextOverflow.ellipsis,
                  //                     ),
                  //                   ],
                  //                 )),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // )
                  ))
            ],
          ))
        ],
      ),
    );
  }

  void _showProductDetails(BuildContext context, Products product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.title ?? '',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                CachedNetworkImage(
                  imageUrl: product.images?.first ?? '',
                  height: defaultPadding * 5,
                  width: defaultPadding * 5,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey,
                    child: const SizedBox(
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 16),
                Text('Category: ${product.category?.toUpperCase()}'),
                const SizedBox(height: 8),
                Text('Price: \$${product.price.toString()}'),
                const SizedBox(height: 8),
                Text('Brand: ${product.brand}'),
                const SizedBox(height: 8),
                Text('Discount: ${product.discountPercentage}%'),
                const SizedBox(height: 8),
                Text('Warranty: ${product.warrantyInformation}'),
                const SizedBox(height: 8),
                const Text('Reviews:'),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: product.reviews?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Name: ${product.reviews?[index].reviewerName.toString()}'),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                  'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(product.reviews![index].date.toString()))}')
                            ],
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Comment: ${product.reviews?[index].comment.toString()}',
                                  maxLines: 2,
                                ),
                              ])
                        ],
                      ).marginOnly(top: 10);
                    }),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.cartProducts.add(product);
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text('Add To Cart'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
