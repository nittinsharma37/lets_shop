import 'package:get/get.dart';

import 'package:lets_shop/controller/product_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
