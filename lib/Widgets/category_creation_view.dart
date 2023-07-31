import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/Controller/category_creation_controller.dart';
import 'package:small_app_example/Extensions/async_value_ui.dart';

import '../API/category_api.dart';

class CategoryAddForm extends ConsumerWidget {
  CategoryAddForm({super.key, required this.api});

  final CategoryApi api;

  final TextEditingController categoryID = TextEditingController();
  final TextEditingController categoryName = TextEditingController();
  final TextEditingController parentCategory = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryControllerProvider);
    ref.listen(
      categoryControllerProvider,
      (_, state) {
        state.showSnackBarOnError(context);
      },
    );
    if (state.isLoading) {
      return const CircularProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Category ID'),
              controller: categoryID,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextFormField(
                decoration: const InputDecoration(labelText: 'Category Name'),
                controller: categoryName),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Parent Category'),
              controller: parentCategory,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            ElevatedButton(
              child: const Text('Add Category'),
              onPressed: () {
                final parentCategoryNumber = int.tryParse(parentCategory.text);
                final categoryIDNumber = int.tryParse(categoryID.text);
                ref
                    .read(categoryControllerProvider.notifier)
                    .addCategory(
                      Category(
                        categoryIDNumber,
                        categoryName.text,
                        parentCategoryNumber,
                      ),
                    );
              },
            ),
          ],
        ),
      );
    }
  }
}
