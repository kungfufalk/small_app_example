import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_app_example/api_structs.dart';
import 'package:small_app_example/collection_api.dart';

class ItemView extends StatelessWidget {
  ItemView({super.key});

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController categoryId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(controller: name, decoration: InputDecoration(labelText: 'Name')),
          TextFormField(controller: description, decoration: InputDecoration(labelText: 'Description')),
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
                CollectionApi().addItem(Item(
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

  Future<List<Category>> categories;

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
