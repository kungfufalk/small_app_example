import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:small_app_example/api_structs.dart';
import 'package:small_app_example/collection_api.dart';

class CategoryAddForm extends StatelessWidget {
  CategoryAddForm({super.key});

  TextEditingController categoryID = TextEditingController();
  TextEditingController categoryName = TextEditingController();
  TextEditingController parentCategory = TextEditingController();

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
                CollectionApi().addCategory(Category(
                    categoryIDNumber, categoryName.text, parentCategoryNumber));
              }),
          ElevatedButton(
            onPressed: () {
              var categories = CollectionApi().getCategories();
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      CategoryOverview(categories),
                ),
              );
            },
            child: Text('Show categories'),
          )
        ],
      ),
    );
  }
}

class CategoryOverview extends StatelessWidget {
  CategoryOverview(this.categories, {super.key});

  Future<List<Category>> categories;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
