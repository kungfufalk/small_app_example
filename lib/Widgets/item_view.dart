import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/Controller/item_view_controller.dart';
import 'package:small_app_example/Extensions/async_value_ui.dart';
import 'package:small_app_example/Widgets/basic_widgets/background_widget.dart';
import 'package:small_app_example/Widgets/basic_widgets/custom_text_form_field.dart';
import 'package:small_app_example/Widgets/basic_widgets/paddin_widget.dart';

class ItemView extends ConsumerWidget {
  ItemView({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController categoryID = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemViewControllerProvider);
    ref.listen(
      itemViewControllerProvider,
      (_, state) {
        state.showSnackBarOnError(context);
        if (state.hasValue && state.value != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('success')));
        }
      },
    );
    return Scaffold(
      body: BackGroundWidget(
        child: PaddingWidget(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  controller: name,
                  labelText: 'Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: description,
                  labelText: 'Description',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomNumberFormField(
                  controller: price,
                  labelText: 'Price',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomNumberFormField(
                  controller: categoryID,
                  labelText: 'Category ID',
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    child: state.when(
                        data: (_) => const Text('Add Item'),
                        error: (err, stack) => const Text('Add Item'),
                        loading: () => const CircularProgressIndicator()),
                    onPressed: () {
                      if (!state.isLoading) {
                        ref.read(itemViewControllerProvider.notifier).addItem(
                            name: name.text,
                            description: description.text,
                            price: double.tryParse(price.text),
                            categoryId: int.tryParse(categoryID.text),
                            context: context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
