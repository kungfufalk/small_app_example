import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/Extensions/async_value_ui.dart';
import 'package:small_app_example/features/collection_management/collection_overview_controller.dart';

class CollectionOverview extends ConsumerWidget {
  const CollectionOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement grid of collections
    final state = ref.watch(collectionOverviewControllerProvider);
    ref.listen(
      collectionOverviewControllerProvider,
      (_, state) {
        state.showSnackBarOnError(context);
      },
    );
    return state.when(data: (data) {
      return GridView.count(
        crossAxisCount: 2,
        children: data.map((e) => Text(e.name)).toList(),
      );
    }, error: (error, stackTrace) {
      return const Text('Error');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
