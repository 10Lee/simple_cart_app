import 'package:get/instance_manager.dart';
import 'package:simple_cart_w_getstorage/controller/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}
