import 'package:flutter/material.dart';
import 'package:small_app_example/API/collection_api.dart';
import 'package:small_app_example/Constants/constants.dart';
import '../API/api_structs.dart';

// - [ ] add a new item to my collection.
// - [ ] view all items in my collection.
// - [ ] view a specific item in my collection.
// - [ ] update an item in my collection.
// - [ ] delete an item from my collection.
// - [ ] search for an item in my collection by name.
// - [ ] categorize items in my collection.
// - [ ] filter items in my collection by category.

class CollectionView extends StatefulWidget {
  const CollectionView({required this.collection, required this.api, super.key});

  final Collection collection;
  final CollectionApi api;

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
  late Future<List<Item>> items;
  List<Widget> itemWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = widget.api.getItemsInCollection(widget.collection);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _createWidgetList(List<Item> itemList) {
    itemWidgets = itemList.map((e) => Text(e.name)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement grid of items
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == []) {
            return const Text('no items in this collection');
          } else {
            _createWidgetList(snapshot.data!);
            return GridView.count(
              crossAxisCount: itemsCrossAxis,
              children: itemWidgets,
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
