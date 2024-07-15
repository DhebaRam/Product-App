import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pracatical_demo/model/product_model.dart';

import '../../model/api_model.dart';
import '../../res/api_manager.dart';
import '../../view/home.dart';

class ProductController extends GetxController {
  final APIManager _apiManager = APIManager.apiManagerInstanace;
  final productsListItems = <Products>[].obs;
  final productsList = <Products>[].obs;
  RxString selectedTitle = 'All Product'.obs;
  final cartProducts = <Products>[].obs;
  String currentTheme = 'light';

  RxInt expandedIndex = 0.obs; // Index of the currently expanded panel

  void setExpandedIndex(int index) {
      if (expandedIndex.value == index) {
        expandedIndex.value = -1; // Collapse the currently expanded panel
      } else {
        expandedIndex.value = index; // Expand the selected panel
      }
  }


  Map<String, int> categoryCounts = {
    'all': 0,
    'beauty': 0,
    'fragrances': 0,
    'groceries': 0,
    'furniture': 0,
  }.obs; // Map to store product counts by category

  /// Get Product Data List
  Future<void> getProductData(BuildContext context) async {
    try{
      ApiResponseModel apiResponse = await _apiManager.request(
        'https://dummyjson.com/products',
        Method.get,
        {},
      );
      print('API Responce ---> ${apiResponse.data}');
      if (apiResponse.status) {
        productsListItems
            .addAll(ProductModel.fromJson(apiResponse.data).products ?? []);
        productsList.addAll(productsListItems);
        countCategories();
        Future.delayed(
            const Duration(seconds: 2), () => Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 600),
                child: const HomePage())));
      } else {
        log("Favorite Error Message.. ${apiResponse.error?.statusCode}");
        throw HttpException(apiResponse.error!.description);
      }
    }catch(e){
      print('Catch--- >${e.toString()}');
      log('Catch--- >${e.toString()}');
    }
  }

  filterProduct(String filter) {
    if (filter == 'All Product') {
      selectedTitle.value = 'All Product';
      productsList.clear();
      productsList.addAll(productsListItems);
    } else {
      selectedTitle.value = filter;
      productsList.clear();
      productsListItems.map((element) {
        if (element.category?.toLowerCase() == filter) {
          productsList.add(element);
        }
      }).toList();
      update();
    }
  }

  void countCategories() {
    categoryCounts['all'] = productsListItems.length;
    categoryCounts['beauty'] = productsListItems
        .where((product) => product.category == 'beauty')
        .length;
    categoryCounts['fragrances'] = productsListItems
        .where((product) => product.category == 'fragrances')
        .length;
    categoryCounts['groceries'] = productsListItems
        .where((product) => product.category == 'groceries')
        .length;
    categoryCounts['furniture'] = productsListItems
        .where((product) => product.category == 'furniture')
        .length;
  }

  void filterProducts(String query, filter) {
    if (query.isNotEmpty) {
      productsList.clear();
      for (var product in productsListItems) {
        // Check if the product title contains the query (case insensitive)
        if (product.title!.toLowerCase().contains(query.toLowerCase())/* && product.category!.toLowerCase().contains(filter.toLowerCase())*/) {
          productsList.add(product);
        }
      }
    }else{
      filterProduct(filter);
    }
  }
}
