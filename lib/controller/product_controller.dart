import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_cart_w_getstorage/models/airsoft.dart';

class ProductController extends GetxController {
  RxList<Airsoft> cart = <Airsoft>[].obs;
  RxList<Airsoft> list = <Airsoft>[
    Airsoft(
        id: 1,
        name: "Airsoft M14 AEG",
        price: 1000000,
        image: "assets/images/m14.jpg",
        qty: 0),
    Airsoft(
        id: 2,
        name: "Airsoft M1 Garrand GBB",
        price: 2000000,
        image: "assets/images/m1_garand.jpg",
        qty: 0),
    Airsoft(
        id: 3,
        name: "Airsoft Mosin Nagant Spring",
        price: 2800000,
        image: "assets/images/mosin_nagant.jpg",
        qty: 0),
    Airsoft(
        id: 4,
        name: "Airsoft AK47 AEG",
        price: 2700000,
        image: "assets/images/ak47.jpg",
        qty: 0),
    Airsoft(
        id: 5,
        name: "Airsoft M4 AEG",
        price: 3500000,
        qty: 0,
        image: "assets/images/m4.jpg"),
    Airsoft(
        id: 6,
        qty: 0,
        name: "Airsoft Dragunov GBB",
        price: 6000000,
        image: "assets/images/dragunov.jpg"),
  ].obs;

  GetStorage box = GetStorage();

  // Adding item into the cart,
  // Automaticaly set qty of this item into 1 in the cart
  void addItemToCart(Airsoft airsoft) {
    airsoft.qty = 1;
    cart.add(airsoft);

    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Listen to the changes when user hit 'add to cart' button
  // also listen to the changes very time user hit + or - qty button
  void updatingSession() {
    // Name updateingSession because this process will update the session

    box.listenKey('items_cart', (updatedValue) {
      print("Perubahan terjadi pada session items_cart $updatedValue");
      print("Trigger perubahan nilai cart dan UI List Product $updatedValue");

      // We check if updatedValue is the type of list, that means has value in it
      if (updatedValue is List) {
        // Delete existing datas inside list of cart
        cart.clear();
        // Then assign the updated datas from session into the list of cart
        cart.addAll(updatedValue.map((e) => Airsoft.fromMap(e)).toList());
      }
    });
  }

  // Subtracting one qty of item from the cart
  void decreaseQtyOfItemInCart(Airsoft airsoft) {
    if (airsoft.qty == 1) {
      // remove the selected item from list of cart
      cart.removeWhere((Airsoft selectedItem) => selectedItem.id == airsoft.id);
    } else {
      // remove the selected item from list of cart
      cart.removeWhere((Airsoft selectedItem) => selectedItem.id == airsoft.id);

      // substract qty by 1
      airsoft.qty--;

      // add again the model with the substracted one qty
      cart.add(airsoft);
    }

    // Write current list of cart into session
    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();
    box.write('items_cart', items_cart);
  }

  // Adding one qty of item in the cart
  void increaseQtyOfItemInCart(Airsoft airsoft) {
    // remove the current selected item from the list of cart
    cart.removeWhere((Airsoft selectedItem) => selectedItem.id == airsoft.id);

    // increase the total of qty by one
    airsoft.qty++;

    // adding it back to the list of cart, The Airsoft model that has increased qty
    cart.add(airsoft);

    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();
    // Write current list cart into session
    box.write('items_cart', items_cart);
  }

  // Remove selected item from the list of cart no mater how much the qty is
  void removeSelectedItemFromCart(int id) {
    cart.removeWhere((Airsoft selectedItem) => selectedItem.id == id);

    List<Map<String, dynamic>> items_cart =
        cart.map((Airsoft e) => e.toJson()).toList();

    box.write('items_cart', items_cart);
  }

  // Keep the previous data of items_cart displayed on the logged in user
  void getUpdatedSessionCartData() {
    // Check if previously user has selected items into the cart?
    if (box.hasData('items_cart')) {
      List<dynamic> value = GetStorage().read('items_cart');
      if (value is List) {
        List<Airsoft> getModelFromSession =
            value.map((e) => Airsoft.fromMap(e)).toList();
        cart.clear();
        cart.addAll(getModelFromSession);
      }
    }

    // if previously user haven't selected any items into the cart,
    // Then simply listen for the changes that will happen now
    updatingSession();
  }

  @override
  void onReady() {
    getUpdatedSessionCartData();
    super.onReady();
  }

  // Logout, remove all session
  void logout() {
    box.erase();
    Get.offAllNamed('/splash');
  }
}
