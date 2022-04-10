import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/bindings/auth_binding.dart';
import 'controller/bindings/cart_binding.dart';
import 'controller/bindings/product_binding.dart';
import 'controller/bindings/splash_binding.dart';
import 'views/auth_screen.dart';
import 'views/cart_screen.dart';
import 'views/product_screen.dart';
import 'views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      getPages: [
        GetPage(
          name: '/product',
          page: () => ProductScreen(),
          binding: ProductBinding(),
        ),
        GetPage(
          name: '/auth',
          page: () => AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/cart',
          page: () => CartScreen(),
          binding: CartBinding(),
        )
      ],
      initialRoute: '/splash',
    );
  }
}
