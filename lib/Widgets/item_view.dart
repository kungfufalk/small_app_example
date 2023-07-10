import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_app_example/API/api_structs.dart';

import '../API/item_api.dart';

class ItemView extends StatelessWidget {
  ItemView({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController categoryId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
              controller: name, decoration: InputDecoration(labelText: 'Name')),
          TextFormField(
              controller: description,
              decoration: InputDecoration(labelText: 'Description')),
          TextFormField(
            decoration: InputDecoration(labelText: 'Price'),
            controller: price,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Category ID'),
            controller: categoryId,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          ElevatedButton(
              child: const Text('Add Item'),
              onPressed: () {
                var priceNumber = double.tryParse(price.text);
                var categoryNumber = int.tryParse(categoryId.text);
                ItemRestApi().addItem(Item(
                  null,
                  name.text,
                  description.text,
                  categoryNumber,
                  priceNumber,
                ));
              }),
          // ElevatedButton(
          //   onPressed: () {
          //     try {
          //       var categories = CollectionApi().getItems();
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute<void>(
          //           builder: (BuildContext context) => ItemOveview(categories),
          //         ),
          //       );
          //     } catch (e) {
          //       print(e);
          //     }
          //   },
          //   child: Text('Show categories'),
          // )
        ],
      ),
    );
  }
}

class ItemOveview extends StatelessWidget {
  ItemOveview(this.categories, {super.key});

  final Future<List<Category>> categories;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Text> categoriesNames =
              snapshot.data!.map((e) => Text(e.name)).toList();
          return Column(
            children: categoriesNames,
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
