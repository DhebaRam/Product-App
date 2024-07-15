import 'package:get/get.dart';
import 'package:pracatical_demo/view%20model/getx_controllers/product_controller.dart';

Future<void> init() async{
  Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
}