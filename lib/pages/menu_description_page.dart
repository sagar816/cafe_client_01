import 'package:cafe_client_01/model/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDescriptionPage extends StatelessWidget {
  const MenuDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Menu menu = Get.arguments['data'];
    // print(data);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                menu.image ?? '',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200, //Adjust the height accordingly
              ),
            ),
            const SizedBox(height: 20),
            Text(
              menu.name ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              menu.description ?? '',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            Text(
              'Rs. ${menu.price ?? ''}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                labelText: 'Enter Your Data',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.indigoAccent),
                child: const Text(
                  'Place order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
