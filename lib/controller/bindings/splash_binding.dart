import 'package:get/get.dart';
import 'package:simple_cart_w_getstorage/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
