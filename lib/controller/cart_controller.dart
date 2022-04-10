import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_cart_w_getstorage/models/airsoft.dart';

class CartController extends GetxController {
  RxList<Airsoft> cart = <Airsoft>[].obs;
  GetStorage box = GetStorage();
  RxInt grandTotal = 0.obs;
  Map<String, dynamic> userSession = GetStorage().read('auth');

  // Removing selected item from the list of cart
  void removeSelectedItemFromCart(int index) {
    cart.removeAt(index);

    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Increasing qty of the selected item
  void increaseQtyOfSelectedItemInCart(int index) {
    cart[index].qty++;

    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Decrease qty of the selected item
  void decreaseQtyOfSelectedItemInCart(int index, Airsoft airsoft) {
    if (airsoft.qty == 1) {
      cart.removeAt(index);
    } else {
      cart[index].qty--;
    }
    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Calculate the grand total value
  void calculateGrandTotal() {
    grandTotal.value = 0;
    for (int i = 0; i < cart.length; i++) {
      grandTotal = grandTotal + (cart[i].qty * cart[i].price);
    }
  }

  // listen for updates the list of cart from session
  void updatingSession() {
    box.listenKey('items_cart', (updatedValue) {
      if (updatedValue is List) {
        cart.clear();
        cart.addAll(updatedValue.map((e) => Airsoft.fromMap(e)).toList());
        calculateGrandTotal();
      }
    });
  }

  // Updating list of cart with the session data
  void getUpdatedSessionCartData() {
    if (box.hasData('items_cart')) {
      List<dynamic> value = GetStorage().read('items_cart');
      if (value is List) {
        cart.clear();
        cart.addAll(value.map((e) => Airsoft.fromMap(e)).toList());
        calculateGrandTotal();
      }
    }
    updatingSession();
  }

  @override
  void onReady() {
    getUpdatedSessionCartData();
    super.onReady();
  }

  // When transaction has been made,
  // clear the session, set grandTotal to zero
  // remove the dialog and show the snackbar
  void transactionCompleted() {
    box.write("items_cart", []).then((value) {
      grandTotal.value = 0;
      cart.clear();
      Get.back();
      Get.snackbar("Message", "Transaction succeed ! ",
          colorText: Colors.white,
          backgroundColor: Color(0xff4D4D4D),
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
