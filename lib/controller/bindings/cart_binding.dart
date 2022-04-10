import 'package:get/instance_manager.dart';
import 'package:simple_cart_w_getstorage/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
