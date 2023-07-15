import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_app_example/API/api_structs.dart';

import '../API/item_api.dart';

class ItemView extends StatefulWidget {
  ItemView({super.key, required this.api});

  final ItemApi api;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  final TextEditingController name = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController price = TextEditingController();

  final TextEditingController categoryId = TextEditingController();

  Item? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name')),
            TextFormField(
                controller: description,
                decoration: const InputDecoration(labelText: 'Description')),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              controller: price,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Category ID'),
              controller: categoryId,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            ElevatedButton(
              child: const Text('Add Item'),
              onPressed: () async {
                var priceNumber = double.tryParse(price.text);
                var categoryNumber = int.tryParse(categoryId.text);
                try {
                  item = await widget.api.addItem(Item(
                    null,
                    name.text,
                    description.text,
                    categoryNumber,
                    priceNumber,
                  ));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('success')));
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('error')));
                  }
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  var items = widget.api.getItems();
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => ItemOverview(items),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Show categories'),
            )
          ],
        )
    );
  }
}

class ItemOverview extends StatelessWidget {
  const ItemOverview(this.items, {super.key});

  final Future<List<Item>> items;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
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
