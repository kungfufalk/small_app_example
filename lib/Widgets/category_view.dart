import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_app_example/API/api_structs.dart';
import 'package:small_app_example/API/collection_api.dart';

class CategoryAddForm extends StatelessWidget {
  CategoryAddForm({super.key});

  final TextEditingController categoryID = TextEditingController();
  final TextEditingController categoryName = TextEditingController();
  final TextEditingController parentCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: categoryID,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          TextFormField(controller: categoryName),
          TextFormField(
            controller: parentCategory,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          ElevatedButton(
              child: const Text('Add Category'),
              onPressed: () {
                var parentCategoryNumber = int.tryParse(parentCategory.text);
                var categoryIDNumber = int.tryParse(categoryID.text);
                CategoryApi().addCategory(Category(
                    categoryIDNumber, categoryName.text, parentCategoryNumber));
              }),
          ElevatedButton(
            onPressed: () {
              try {
                var categories = CategoryApi().getCategories();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        CategoryOverview(categories),
                  ),
                );
              } catch (e) {
                print(e);
              }
            },
            child: Text('Show categories'),
          )
        ],
      ),
    );
  }
}

class CategoryOverview extends StatelessWidget {
  const CategoryOverview(this.categories, {super.key});

  final Future<List<Category>> categories;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categories,
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