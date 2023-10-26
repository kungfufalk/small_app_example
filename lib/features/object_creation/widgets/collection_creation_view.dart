import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/features/object_creation/controllers/collection_creation_controller.dart';
import 'package:small_app_example/generated/collection_types.pb.dart';

class CollectionCreationView extends ConsumerWidget {
  const CollectionCreationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collectionCreationControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Collection',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New Collection',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset('assets/categoryThumbnail.png'),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        maximumSize: const Size(150, 48.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.photo,
                              color: Theme.of(context).colorScheme.onPrimary),
                          Text(
                            'Add Image',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter a name',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref
                .read(collectionCreationControllerProvider.notifier)
                .createCollection(
                  Collection(
                    name: 'New Collection',
                  ),
                );
          },
          child: const Icon(Icons.add),
        ));
  }
}
