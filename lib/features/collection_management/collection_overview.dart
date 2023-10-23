import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/Controller/collection_controllers/collection_view_controller.dart';
import 'package:small_app_example/Extensions/async_value_ui.dart';

// - [ ] add a new item to my collection.
// - [ ] view all items in my collection.
// - [ ] view a specific item in my collection.
// - [ ] update an item in my collection.
// - [ ] delete an item from my collection.
// - [ ] search for an item in my collection by name.
// - [ ] categorize items in my collection.
// - [ ] filter items in my collection by category.

class CollectionView extends ConsumerWidget {
  const CollectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement grid of items
    final state = ref.watch(collectionViewControllerProvider);
    ref.listen(
      collectionViewControllerProvider,
      (_, state) {
        state.showSnackBarOnError(context);
      },
    );
    return GridView.count(
      crossAxisCount: 2,
      children: [],
    );
  }
}
