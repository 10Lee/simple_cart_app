import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_cart_w_getstorage/controller/product_controller.dart';
import 'package:simple_cart_w_getstorage/models/airsoft.dart';

class RowProduct extends StatelessWidget {
  Airsoft airsoft;
  ProductController controller;

  RowProduct({
    Key? key,
    required this.airsoft,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110.0,
          height: 90.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                airsoft.image,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${airsoft.name}",
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),
              Text(
                "Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(airsoft.price)}",
              ),
              Obx(() {
                Airsoft? selectedModel = controller.cart.firstWhereOrNull(
                    (Airsoft selectedItem) => selectedItem.id == airsoft.id);

                if (selectedModel == null) {
                  return ElevatedButton(
                    onPressed: () => controller.addItemToCart(airsoft),
                    child: Text("Add To Cart"),
                  );
                } else {
                  return _buildQty(selectedModel);
                }
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQty(Airsoft selectedModel) {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: () =>
              controller.removeSelectedItemFromCart(selectedModel.id),
          label: Text("Remove"),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => controller.decreaseQtyOfItemInCart(airsoft),
              icon: Icon(Icons.remove),
            ),
            Text(selectedModel.qty.toString()),
            IconButton(
              onPressed: () => controller.increaseQtyOfItemInCart(airsoft),
              icon: Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }
}
