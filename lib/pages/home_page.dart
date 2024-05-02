import 'package:cafe_client_01/controller/home_controller.dart';
import 'package:cafe_client_01/pages/login_page.dart';
import 'package:cafe_client_01/pages/menu_description_page.dart';
import 'package:cafe_client_01/widgets/drop_down_btn.dart';
import 'package:cafe_client_01/widgets/menu_card.dart';
import 'package:cafe_client_01/widgets/multi_select_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctrl) {
        return RefreshIndicator(
          onRefresh: () async {
            ctrl.fetchMenus();
          },
          child: Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'Cafe Order Screen',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                backgroundColor: Colors.deepPurpleAccent,
                actions: [
                  IconButton(
                    onPressed: () {
                      GetStorage box = GetStorage();
                      box.erase();
                      Get.offAll(LoginPage());
                    },
                    icon: Icon(Icons.logout),
                    color: Colors.white,
                  )
                ],
              ),
              body: Column(children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.menuCategories.length,
                      itemBuilder: (context, index) {
                        // return Text('Category');
                        return InkWell(
                          onTap: () {
                            ctrl.filterByCategory(
                                ctrl.menuCategories[index].name ?? '');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Chip(
                                label: Text(ctrl.menuCategories[index].name ??
                                    'Error')),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Flexible(
                      child: DropDownBtn(
                          items: ['Rs: Low to High', 'Rs: High To Low'],
                          selectedItemText: 'Sort',
                          onSelected: (selected) {
                            // print(selected);
                            ctrl.sortByPrice(ascending: selected == 'Rs: Low to High' ? true : false);
                          }),
                    ),
                    Flexible(
                        child: MultiSelectDropDown(
                      items: ['Type 1', 'Type 2', 'Type 3'],
                      onSelectionChanged: (selectedItems) {
                        // print(selectedItems);
                        ctrl.filterByType(selectedItems);
                      },
                    )),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                      itemCount: ctrl.menusShowInUi.length,
                      itemBuilder: (context, index) {
                        return MenuCard(
                          name: ctrl.menusShowInUi[index].name ?? 'No name',
                          imageUrl: ctrl.menusShowInUi[index].image ?? 'Url',
                          price: ctrl.menusShowInUi[index].price ?? 00,
                          offerTag: '20% Off',
                          onTap: () {
                            Get.to(MenuDescriptionPage(), arguments: {'data':ctrl.menusShowInUi[index]});
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           const MenuDescriptionPage()),
                          },
                        );
                      }),
                )
              ])),
        );
      },
    );
  }
}
