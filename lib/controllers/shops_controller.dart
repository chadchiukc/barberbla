import 'package:barberbla/models/shop_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopController extends GetxController {
  var shopList = <ShopModel>[].obs;
  var filteredShopList = <ShopModel>[].obs;
  var selectedShop = ShopModel().obs;

  QuerySnapshot _shops;

  void addShops(String name) async {
    if (shopList.length == 0) {
      EasyLoading.show(status: 'Loading...');
      try {
        _shops = await Database().getShops(name);
        _shops.docs.forEach((element) {
          shopList.add(ShopModel.fromQueryDocumentnapshot(element));
        });
      } catch (e) {
        Get.snackbar(
            "Error during fetching from server", 'Please try again later...');
      }
      EasyLoading.dismiss();
    }
  }

  void filterShop(String searchText) {
    if (searchText != null) {
      shopList.forEach(
        (element) {
          if (element.address
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            filteredShopList.add(element);
          }
        },
      );
    } else {
      filteredShopList = shopList;
    }
  }

  void selectShop(int index) {
    selectedShop.value = ShopModel(
      id: shopList[index].id,
      address: shopList[index].address,
      latLon: shopList[index].latLon,
      img: shopList[index].img,
      name: shopList[index].name,
      openHour: shopList[index].openHour,
    );
  }
}
