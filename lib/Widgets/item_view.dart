import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/Controller/ItemViewController.dart';

class ItemView extends ConsumerWidget {
  ItemView({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController categoryID = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(itemViewControllerProvider);
    ref.listen(
      itemViewControllerProvider,
      (_, value) {
        value.when(
            data: (state) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('success')));
            },
            error: (error, __) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('error')));
            },
            loading: () {});
      },
      //   onError: (value, stack) {
      //   if (context.mounted) {
      //     ScaffoldMessenger.of(context)
      //         .showSnackBar(const SnackBar(content: Text('error')));
      //   }
      // },
    );
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
          controller: categoryID,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        ElevatedButton(
            child: loadingState.when(
                data: (_) => const Text('Add Item'),
                error: (err, stack) => Text('Error: $err'),
                loading: () => const CircularProgressIndicator()),
            onPressed: () {
              var priceNumber = double.tryParse(price.text);
              var categoryNumber = int.tryParse(categoryID.text);
              ref.read(itemViewControllerProvider.notifier).addItem(Item(null,
                  name.text, description.text, categoryNumber, priceNumber));
            }),
        // ElevatedButton(
        //   onPressed: () {
        //     try {
        //       var items = widget.api.getItems();
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute<void>(
        //           builder: (BuildContext context) => ItemOverview(items),
        //         ),
        //       );
        //     } catch (e) {
        //       print(e);
        //     }
        //   },
        //   child: const Text('Show categories'),
        // )
      ],
    ));
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
