import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simple_cart_w_getstorage/controller/product_controller.dart';
import 'package:simple_cart_w_getstorage/widgets/row_product.dart';

class ProductScreen extends StatelessWidget {
  late ProductController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'EVIKE.COM',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(
            () => controller.cart.isNotEmpty
                ? InkWell(
                    onTap: () => Get.toNamed('/cart'),
                    child: Badge(
                      child: const Icon(Icons.shopping_cart),
                      badgeColor: Colors.red,
                      badgeContent: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          '${controller.cart.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                : const Icon(Icons.shopping_cart),
          ),
          const SizedBox(width: 20.0),
          InkWell(
            onTap: () => controller.logout(),
            child: const Icon(Icons.power_settings_new),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        separatorBuilder: (_, __) => const Divider(color: Colors.white),
        itemCount: controller.list.length,
        itemBuilder: (context, index) {
          return RowProduct(
            airsoft: controller.list[index],
            controller: controller,
          );
        },
      ),
    );
  }
}
