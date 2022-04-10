import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_cart_w_getstorage/controller/cart_controller.dart';
import 'package:simple_cart_w_getstorage/models/airsoft.dart';

class RowCart extends StatelessWidget {
  late CartController controller;
  late int index;

  final Airsoft airsoft;
  RowCart({
    Key? key,
    required this.index,
    required this.airsoft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.find<CartController>();

    return Container(
      height: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(airsoft.image),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${airsoft.name}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(airsoft.price)}",
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Total • Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(airsoft.price * airsoft.qty)}",
                ),
                Expanded(child: _buildQty()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQty() {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: () => controller.removeSelectedItemFromCart(airsoft.id),
          label: Text("Remove"),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () =>
                  controller.decreaseQtyOfSelectedItemInCart(index, airsoft),
              icon: Icon(Icons.remove),
            ),
            Text(airsoft.qty.toString()),
            IconButton(
              onPressed: () =>
                  controller.increaseQtyOfSelectedItemInCart(index),
              icon: Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }
}
