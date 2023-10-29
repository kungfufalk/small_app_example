import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:small_app_example/Extensions/async_value_ui.dart';
import 'package:small_app_example/features/collection_management/collection_overview_controller.dart';
import 'package:small_app_example/features/routing/route_constants.dart';

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
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Collections',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Container(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: GridView.count(
              crossAxisCount: 2,
              children: data
                  .map(
                    (e) => Card(
                      borderOnForeground: true,
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                                child:
                                    Image.asset('assets/categoryThumbnail.png'),
                                onTap: () {
                                  context.go(AppRoutes.collectionFullPath);
                                }),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(e.name),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }, error: (error, stackTrace) {
      return const Text('Error');
    }, loading: () {
      return const CircularProgressIndicator();
    });
  }
}
