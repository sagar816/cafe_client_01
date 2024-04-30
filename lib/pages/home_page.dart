import 'package:cafe_client_01/pages/menu_description_page.dart';
import 'package:cafe_client_01/widgets/drop_down_btn.dart';
import 'package:cafe_client_01/widgets/menu_card.dart';
import 'package:cafe_client_01/widgets/multi_select_drop_down.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cafe Order Screen',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
       body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  // return Text('Category');
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: Chip(label: Text('Category')),
                  );
                }),
          ),
          Row(
            children: [
              Flexible(
                child: DropDownBtn(
                    items: ['Rs: Low to High', 'Rs: High To Low'],
                    selectedItemText: 'Sort',
                    onSelected: (selected) {}),
              ),
              Flexible(
                  child: MultiSelectDropDown(
                items: ['Type 1', 'Type 2', 'Type 3'],
                onSelectionChanged: (selectedItems) {},
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MenuCard(
                    name: 'Cheese Burger',
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/cafe-app-01.appspot.com/o/Burger.jpeg?alt=media&token=d4c5e7d9-499f-4566-8e36-5d438cf4b238',
                    price: 100,
                    offerTag: '30% Off',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MenuDescriptionPage()),
                      );
                    },
                  );
                }),
          )




        ]
       )
    );
  }
}
