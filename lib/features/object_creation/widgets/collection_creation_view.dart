import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:small_app_example/Extensions/async_value_ui.dart';
import 'package:small_app_example/features/basic_widgets/async_value_widget.dart';
import 'package:small_app_example/features/camera/camera_provider.dart';
import 'package:small_app_example/features/object_creation/controllers/collection_creation_controller.dart';
import 'package:small_app_example/features/object_creation/widgets/image_thumbnail.dart';
import 'package:small_app_example/features/routing/route_constants.dart';
import 'package:small_app_example/generated/collection_types.pb.dart';

class CollectionCreationView extends ConsumerWidget {
  CollectionCreationView({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collectionCreationControllerProvider);
    final imagePath = ref.watch(imagePathProvider);
    ref.listen(
      (collectionCreationControllerProvider),
      (previous, next) {
        state.showSnackBarOnError(context);
        if (next is AsyncData && next.value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Collection created'),
            ),
          );
        }
      },
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Collection',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraScreen(
                        CameraController(
                          ref.read(cameraProvider)!,
                          ResolutionPreset.high,
                        ),
                      ),
                    ));
              },
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
                    ImageThumbnail(
                      imagePath: imagePath,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        maximumSize: const Size(150, 48.0),
                      ),
                      onPressed: () {
                        ref.read(imagePathProvider);
                      },
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
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter a name',
                  border: OutlineInputBorder(),
                ),
                controller: _nameController,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final response = ref
                .read(collectionCreationControllerProvider.notifier)
                .createCollection(
                  Collection(
                    name: _nameController.text,
                  ),
                );
          },
          child: AsyncValueButton(
            value: state,
            data: (_) => const Icon(Icons.add),
            error: (_, __) => const Icon(Icons.error),
          ),
        ));
  }
}
