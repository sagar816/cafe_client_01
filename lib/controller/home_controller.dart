import 'package:cafe_client_01/model/menu/menu.dart';
import 'package:cafe_client_01/model/menu_category/menu_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference menuCollection;
  late CollectionReference categoryCollection;

  List<Menu> menus = [];
  List<Menu> menusShowInUi = [];
  List<MenuCategory> menuCategories = [];

  @override
  Future<void> onInit() async {
    menuCollection = firestore.collection('menus');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchMenus();
    super.onInit();
  }

  fetchMenus() async {
    try {
      QuerySnapshot menuSnapshot = await menuCollection.get();
      final List<Menu> retrievedMenus = menuSnapshot.docs
          .map((doc) => Menu.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      menus.clear();
      menus.assignAll(retrievedMenus);
      menusShowInUi.assignAll(menus);
      Get.snackbar('Success', 'Menu fetched Successfully',
          colorText: Colors.blue);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<MenuCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) =>
              MenuCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      menuCategories.clear();
      menuCategories.assignAll(retrievedCategories);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    menusShowInUi.clear();
    menusShowInUi = menus.where((menu) => menu.category == category).toList();
    update();
  }

  filterByType(List<String> types) {
    if (types.isEmpty) {
      menusShowInUi = menus;
    } else {
      List<String> lowerCaseTypes =
          types.map((type) => type.toLowerCase()).toList();
      menusShowInUi = menus
          .where((menu) => lowerCaseTypes.contains(menu.type?.toLowerCase()))
          .toList();
    }
    update();
  }

  sortByPrice({required bool ascending}) {
    List<Menu> sortedMenus = List<Menu>.from(menusShowInUi);
    sortedMenus.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    menusShowInUi = sortedMenus;
    update();
  }
}
