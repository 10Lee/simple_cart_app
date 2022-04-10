import 'package:get/get.dart';
import 'package:simple_cart_w_getstorage/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
