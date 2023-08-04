import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:small_app_example/Constants/route_constants.dart';
import 'package:small_app_example/Controller/category_controller.dart';
import 'package:small_app_example/Widgets/category_thumbnail.dart';

class CategoryOverview extends ConsumerWidget {
  const CategoryOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryControllerProvider);
    return Scaffold(
      body: state.when(
        data: (data) {
          if (data.isEmpty) {
            return const Text('No categories');
          } else {
            return GridView.count(

              crossAxisCount: 3,
              children: data
                  .map((e) => CategoryThumbnail(
                        image: Image.asset('assets/categoryThumbnail.png'),
                        category: e,
                      ))
                  .toList(),
            );
          }
        },
        error: (error, stackTrace) {
          return const Text('Error');
        },
        loading: () => const CircularProgressIndicator(),
      ),
      appBar: AppBar(title: const Text('Categories')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutes.categoryCreation),
        child: const Icon(Icons.add),
      ),
    );
  }
}
